# Meta --------------------------------------------------------------------

## Date Created:  7/22/2020
## Date Edited:   9/9/2020
## Description:   Analysis file for exercise 1


# Preliminaries -----------------------------------------------------------

if (!require("pacman")) install.packages("pacman")
pacman::p_load(tidyverse, ggplot2, dplyr, lubridate, stargazer, knitr, kableExtra,
               lfe, modelr, gtsummary, ggrepel, lfe, dotwhisker, panelView)

source('paths.R')

# Load data ------------------------------------------------------------

source('solutions/exercise1/1_ipps.R')
source('solutions/exercise1/2_pos.R')


# Analytic Datasets -----------------------------------------------------------

## State crosswalk file (name and abbreviations)
state.xw <-  read_csv(file=paste0(geog.path,'/state_abbr_xw.csv'))
state.xw <- state.xw %>%
  select(state=State,
         state_short=Abbreviation)


## KFF data on Medicaid expansion
kff.dat <- read_csv(file=paste0(kff.path,'/KFF_medicaid_expansion_2019.csv'))

kff.final <- kff.dat %>%
  mutate(expanded = (`Expansion Status` == 'Adopted and Implemented'),
         Description = str_replace_all(Description,c("\n"='','"'='')))

kff.final$splitvar <- kff.final %>% select(Description) %>% as.data.frame() %>%
  separate(Description, sep=" ", into=c(NA, NA, NA, "date"))

kff.final <- kff.final %>%
  mutate(date_adopted = mdy(splitvar$date),
         expand_year = year(date_adopted)) %>%
  rename(state=State) %>%
  left_join(state.xw, by=c("state"))



## Full IPPS and POS data
full.data <- final.pos.data %>%
  left_join(final.ipps.data, by=c("provider", "year")) %>%
  mutate(profit_status = 
           case_when(
             own_type=="Non-profit Private" ~ "Non Profit",
             own_type %in% c("Physician Owned","Profit") ~ "For Profit"
           ),
         state_short=state) %>%
  select(-state) %>%
  inner_join(kff.final, by=c("state_short")) %>%
  mutate(expand = (year>=expand_year & !is.na(expand_year))) %>%
  rename(expand_ever=expanded)

  


# Q1 summary statistics ---------------------------------------------------

sum.stats <- full.data %>% ungroup() %>%
  group_by(year) %>%
  summarize_at(c("cmi","dshpct"), list(mean, sd, min, max), na.rm=TRUE) %>%
  filter(year>=1986) %>%
  select(year, cmi_fn1, cmi_fn2, cmi_fn3, cmi_fn4, 
         dshpct_fn1, dshpct_fn2, dshpct_fn3, dshpct_fn4) %>%
  mutate_if(is.numeric, ~ifelse(abs(.) == Inf, NA, .))



# Q2 plots ----------------------------------------------------------------

cmi.dat <- full.data %>% ungroup() %>%
  select(year, cmi, profit_status) %>%
  filter(!is.na(profit_status),
         year>=1986) %>%
  group_by(year, profit_status) %>%
  summarize(mean_cmi=mean(cmi, na.rm=TRUE))

fig.avg.cmi <- ggplot(data = cmi.dat,
                      aes(x=year, y=mean_cmi, group=profit_status, linetype=profit_status)) +
  geom_line() +
  geom_text(data = cmi.dat %>% filter(year==1986),
            aes(label = c("For Profit", "Non Profit"),
                x = year+1,
                y = mean_cmi)) +
  guides(linetype=FALSE) +
  labs(
    x="Year",
    y="Case Mix Index"
  ) + theme_bw() +
  scale_x_continuous(breaks=seq(1985,2020,5))
  

dsh.dat <- full.data %>% ungroup() %>%
  select(year, dshpct, profit_status) %>%
  filter(!is.na(profit_status),
         year>=1994) %>%
  group_by(year, profit_status) %>%
  summarize(mean_dsh=mean(dshpct, na.rm=TRUE))

fig.avg.dsh <- ggplot(data = dsh.dat,
                      aes(x=year, y=mean_dsh, group=profit_status, linetype=profit_status)) +
  geom_line() +
  geom_text(data = dsh.dat %>% filter(year==1994),
            aes(label = c("For Profit", "Non Profit"),
                x = year+1,
                y = mean_dsh)) +
  guides(linetype=FALSE) +
  labs(
    x="Year",
    y="Disproportionate Share"
  ) + theme_bw() +
  scale_x_continuous(breaks=seq(1990,2020,5))



# Q3 DD analysis ----------------------------------------------------------

dd.table <- full.data %>% 
  filter(!is.na(expand_ever), year %in% c(2013, 2015)) %>%  
  group_by(expand_ever, year) %>%
  summarize(dsh=mean(dshpct, na.rm=TRUE))

dd.table <- pivot_wider(dd.table, names_from="year", names_prefix="year", values_from="dsh") %>% 
  ungroup() %>%
  mutate(expand_ever=case_when(
    expand_ever==FALSE ~ 'Non-expansion',
    expand_ever==TRUE ~ 'Expansion')
  ) %>%
  rename(Group=expand_ever,
         Pre=year2013,
         Post=year2015)

reg.data <- full.data %>%
  filter(year>=2005,
         year<=2018,
         is.na(expand_year) | expand_year==2014) %>%
  mutate(post=(year>=2014),
         treat=post*expand_ever)

ever.fp <- reg.data %>%
  filter(!is.na(profit_status),
         year>=2014) %>%
  mutate(fp=ifelse(profit_status=="For Profit",1,0)) %>%
  group_by(provider) %>%
  summarize(ever_fp=ifelse(sum(fp,na.rm=TRUE)>0,1,0))

reg.data.ddd <- reg.data %>%
  inner_join(ever.fp, by=c("provider")) %>%
  mutate(prof_treat=treat*ever_fp)
  

dd.est <- lm(dshpct~post + expand_ever + treat, data=reg.data)
lfe.est <- felm(dshpct~treat | provider + year, data=reg.data)
ddd.est <- lm(dshpct~post + expand_ever + treat + ever_fp + prof_treat, data=reg.data.ddd)



# Q4 Event study with constant treatment ----------------------------------

event.dat <- reg.data %>%
  mutate(expand_2005 = expand_ever*(year==2005),
         expand_2006 = expand_ever*(year==2006),
         expand_2007 = expand_ever*(year==2007),
         expand_2008 = expand_ever*(year==2008),
         expand_2009 = expand_ever*(year==2009),
         expand_2010 = expand_ever*(year==2010),
         expand_2011 = expand_ever*(year==2011),
         expand_2012 = expand_ever*(year==2012),
         expand_2013 = expand_ever*(year==2013),
         expand_2014 = expand_ever*(year==2014),
         expand_2015 = expand_ever*(year==2015),
         expand_2016 = expand_ever*(year==2016),
         expand_2017 = expand_ever*(year==2017),
         expand_2018 = expand_ever*(year==2018))

event.reg <- felm(dshpct ~ expand_2005 + expand_2006 + expand_2007 +
                        expand_2008 + expand_2009 + expand_2010 + expand_2011 + expand_2012 + expand_2014 + 
                        expand_2015 + expand_2016 + expand_2017 + 
                        expand_2018 | year + provider, data=event.dat)

point.est <- as_tibble(c(event.reg$coefficients[c("expand_2005","expand_2006","expand_2007",
                                                      "expand_2008","expand_2009","expand_2010", "expand_2011",
                                                      "expand_2012","expand_2014","expand_2015",
                                                      "expand_2016","expand_2017","expand_2018"),]),
                       rownames = "term")
ci.est <- as_tibble(confint(event.reg)[c("expand_2005","expand_2006","expand_2007",
                                             "expand_2008","expand_2009","expand_2010","expand_2011",
                                             "expand_2012","expand_2014","expand_2015",
                                             "expand_2016","expand_2017","expand_2018"),],
                    rownames = "term")
point.est <- point.est %>% rename(estimate = value)
ci.est <- ci.est %>% rename(conf.low = `2.5 %`, conf.high = `97.5 %`)
new.row <- tibble(
  term = "expand_2013",
  estimate = 0,
  conf.low = 0,
  conf.high = 0,
  year = 2013
)

event.plot.dat <- point.est %>%
  left_join(ci.est, by=c("term")) %>%
  mutate(year = c(2005, 2006, 2007, 2008, 2009, 2010, 2011, 2012, 2014, 2015, 2016, 2017, 2018)) %>%
  bind_rows(new.row) %>%
  arrange(year)

event.plot <- dwplot(event.plot.dat, 
                     vline=geom_vline(xintercept=0, linetype=2), 
                     order_vars = c("expand_2018","expand_2017","expand_2016",
                                    "expand_2015","expand_2014","expand_2013",
                                    "expand_2012","expand_2011","expand_2010",
                                    "expand_2009","expand_2008","expand_2007",
                                    "expand_2006","expand_2005"),
                     whisker_args = list(color="black", size=1.1),
                     dot_args = list(color="black")) + 
  coord_flip() + theme_bw() + theme(legend.position = "none") +
  labs(y = "Year",
       x = "Estimate and 95% CI") +
  scale_y_discrete(labels = c("expand_2005" = "2005", 
                              "expand_2006" = "2006", 
                              "expand_2007" = "2007", 
                              "expand_2008" = "2008", 
                              "expand_2009" = "2009", 
                              "expand_2010" = "2010", 
                              "expand_2011" = "2011", 
                              "expand_2012" = "2012", 
                              "expand_2013" = "2013",
                              "expand_2014" = "2014",
                              "expand_2015" = "2015",
                              "expand_2016" = "2016",
                              "expand_2017" = "2017",
                              "expand_2018" = "2018"))




# Q5 Event study with varying treatment time ------------------------------

reg.data2 <- full.data %>%
  filter(year>=2005,
         year<=2018) %>%
  mutate(treat=case_when(
    year>=expand_year & !is.na(expand_year) ~ 1,
    is.na(expand_year) ~ 0,
    year<expand_year & !is.na(expand_year) ~ 0)
  )


event.dat2 <- reg.data2 %>%
  mutate(event_time=case_when(
    !is.na(expand_year) ~ year-expand_year ,
    is.na(expand_year) ~ -1)) %>%
  mutate(time_m12=1*(event_time<=-12),
         time_m11=1*(event_time==-11),
         time_m10=1*(event_time==-10),
         time_m9=1*(event_time==-9),
         time_m8=1*(event_time==-8),
         time_m7=1*(event_time==-7),
         time_m6=1*(event_time==-6),
         time_m5=1*(event_time==-5),
         time_m4=1*(event_time==-4),
         time_m3=1*(event_time==-3),
         time_m2=1*(event_time==-2),
         time_0=1*(event_time==0),
         time_p1=1*(event_time==1),
         time_p2=1*(event_time==2),
         time_p3=1*(event_time==3),
         time_p4=1*(event_time==4))

event.reg2 <- felm(dshpct ~ time_m12 + time_m11 + time_m10 + time_m9 + time_m8 +
                       time_m7 + time_m6 + time_m5 + time_m4 + time_m3 + time_m2 + time_0 +
                       time_p1 + time_p2 + time_p3 + time_p4 |
                       year + provider, data=event.dat2)

point.est2 <- as_tibble(event.reg2$coefficients, rownames="term")
point.est2 <- point.est2 %>% filter(term %in% c("time_m12","time_m11", "time_m10", "time_m9",
                                                "time_m8", "time_m7", "time_m6", "time_m5",
                                                "time_m4","time_m3","time_m2","time_0",
                                                "time_p1","time_p2","time_p3","time_p4"))
ci.est2 <- as_tibble(confint(event.reg2), rownames="term")
ci.est2 <- ci.est2 %>% filter(term %in% c("time_m12","time_m11", "time_m10", "time_m9",
                                          "time_m8", "time_m7", "time_m6", "time_m5",
                                          "time_m4","time_m3","time_m2","time_0",
                                          "time_p1","time_p2","time_p3","time_p4"))

point.est2 <- point.est2 %>% rename(estimate = dshpct)
ci.est2 <- ci.est2 %>% rename(conf.low = `2.5 %`, conf.high = `97.5 %`)
new.row <- tibble(
  term = "time_m1",
  estimate = 0,
  conf.low = 0,
  conf.high = 0,
  event_time = -1
)

event.plot.dat2 <- point.est2 %>%
  left_join(ci.est2, by=c("term")) %>%
  mutate(event_time = c(-12, -11, -10, -9, -8, -7, -6, -5, -4,-3,-2,0,1,2,3,4)) %>%
  bind_rows(new.row) %>%
  arrange(event_time)

event.plot2 <- dwplot(event.plot.dat2, 
                      vline=geom_vline(xintercept=0, linetype=2), 
                      order_vars = c("time_p4","time_p3","time_p2",
                                     "time_p1","time_0","time_m1",
                                     "time_m2","time_m3","time_m4",
                                     "time_m5","time_m6","time_m7",
                                     "time_m8","time_m9","time_m10",
                                     "time_m11","time_m12"),
                      whisker_args = list(color="black", size=1.1),
                      dot_args = list(color="black")) + 
  coord_flip() + theme_bw() + theme(legend.position = "none") +
  labs(y = "Year",
       x = "Estimate and 95% CI") +
  scale_y_discrete(labels = c("time_p4" = "t+4", 
                              "time_p3" = "t+3",
                              "time_p2" = "t+2",
                              "time_p1" = "t+1",
                              "time_0" = "0",
                              "time_m1" = "t-1",
                              "time_m2" = "t-2",
                              "time_m3" = "t-3",
                              "time_m4" = "t-4",
                              "time_m5" = "t-5",
                              "time_m6" = "t-6",
                              "time_m7" = "t-7",
                              "time_m8" = "t-8",
                              "time_m9" = "t-9",
                              "time_m10" = "t-10",
                              "time_m11" = "t-11",
                              "time_m12" = "t-12+"))


# Extras ------------------------------------------------------------------

# Panel view
pdata <- reg.data2 %>%
  group_by(state, year) %>%
  summarize(expand=max(expand, na.rm=TRUE),
            dshpct=mean(dshpct, na.rm=TRUE))
pdata <- data.frame(pdata)
pdata$expand <- as.numeric(pdata$expand)
panelView(dshpct~expand, data=pdata, index=c("state","year"),
          xlab="Year", ylab="State",
          by.timing=TRUE, legend.labs=c("No Expansion", "Expansion"),
          background="white", cex.main=14, cex.axis=7, cex.lab=12, cex.legend=12)

panelView(dshpct~expand, data=pdata, index=c("state","year"),
          xlab="Year", ylab="State",
          by.timing=TRUE, legend.labs=c("Never Expanded", "Pre-Expansion", "Post-Expansion"),
          background="white", cex.main=14, cex.axis=7, cex.lab=12, cex.legend=12,
          pre.post=TRUE)

# Check weights

felm(dshpct ~ treat | year + provider, data=reg.data2)

library(bacondecomp)
reg.bacon <- reg.data2 %>%
  filter(!is.na(dshpct)) %>%
  add_count(provider) %>%
  filter(n==14)
  
df.bacon <- bacon(dshpct~treat, data=reg.bacon, id_var="provider", time_var="year")
ggplot(df.bacon) +
  aes(x = weight, y = estimate, shape = factor(type)) +
  geom_point() +
  geom_hline(yintercept = 0) +
  labs(x = "Weight", y = "Estimate", shape = "Type")  


devtools::install_github("bcallaway11/did")
did.out <- att_gt(yname = "dshpct",
                  first.treat.name = "expand_year",
                  idname = "provider",
                  tname = "year",
                  xformla = ~1,
                  data = reg.data2,
                  estMethod = "reg",
                  printdetails = FALSE)


# Save final image --------------------------------------------------------

ipps.list=c("ipps.1986")
for (y in 1987:2018) {
  ipps.list=c(ipps.list, paste0("ipps.",y))
}
pos.list=c("pos.1984")
for (y in 1985:2018) {
  pos.list=c(pos.list, paste0("pos.",y))
}

rm(list=c(ipps.list, pos.list, "reg.data", "reg.data.ddd",
          "event.dat", "event.plot.dat", "event.plot.dat2"))
save.image("solutions/exercise1/workspace.Rdata")

