# Meta --------------------------------------------------------------------

## Date Created:  8/5/2020
## Date Edited:   8/12/2020
## Description:   Analysis file for exercise 3


# Preliminaries -----------------------------------------------------------

if (!require("pacman")) install.packages("pacman")
pacman::p_load(tidyverse, ggplot2, dplyr, lubridate, stargazer, knitr, kableExtra,
               lfe, modelr, SAScii, gtsummary, ggrepel, ivpack, lfe, haven, rdrobust, rddensity)

source('paths.R')

# Load data ------------------------------------------------------------

pdp.data <- read_dta(paste0(replicate.path,"/Ericson 2014/DataFiles/Data_main.dta"))
lis.data <- read_dta(paste0(replicate.path,"/Ericson 2014/DataFiles/Data_subsidyinfo.dta"))

# Analytic Datasets -----------------------------------------------------------

# calculate shares from pdp data
pdp.data <- pdp.data %>%
  group_by(state, year) %>%
  mutate(state_yr_enroll = sum(enrollment, na.rm=TRUE)) %>%
  ungroup() %>%
  mutate(share = enrollment/state_yr_enroll,
         ln_share = log(share))

# reshape subsidy data to long
lis.data <- pivot_longer(lis.data, cols=c("s2006","s2007","s2008","s2009","s2010"), 
                         names_to="year",
                         names_prefix="s",
                         values_to="LISsubsidy") %>%
  mutate(year=as.numeric(year))

# merge the subsidy data into the pdp data and create new variables matching Ericson's code files
final.data <- pdp.data %>%
  inner_join(lis.data, by=c("PDPregion","year")) %>%
  mutate(LISPremium = premium - LISsubsidy,
         proposedBenchmarkPlan = ifelse(LISPremium<=0,1,0),
         ProblemObs = case_when(
           LISPremium < 0 & LIS == 0 ~ 1,
           LISPremium > 0 & LIS == 1 ~ 2
         ),
         LISPremium = ifelse(benefit=="E",NA,LISPremium),
         proposedBenchmarkPlan = ifelse(benefit=="E", NA, proposedBenchmarkPlan),
         LISPremiumNeg = ifelse(LISPremium<=0, LISPremium, 0),
         LISPremiumPos = ifelse(LISPremium>=0, LISPremium, 0))

# recreate Ericson RD windows
final.data.rd <- final.data %>%
  mutate(RDwindow1 = ifelse(LISPremium>=-10 & LISPremium<=10 & year==2006, 1, 0),
         belowBench1 = ifelse(LISPremium<=0 & RDwindow1==1, 1, 0),
         RDwindow2 = ifelse(LISPremium>=-4 & LISPremium<=4 & year==2006, 1, 0),
         belowBench2 = ifelse(LISPremium<=0 & RDwindow2==1, 1, 0),
         RDwindow3 = ifelse(LISPremium>=-2.5 & LISPremium<=2.5 & year==2006, 1, 0),
         belowBench3 = ifelse(LISPremium<=0 & RDwindow3==1, 1, 0),
         RDwindow4 = ifelse(LISPremium>=-6 & LISPremium<=6 & year==2006, 1, 0),
         belowBench4 = ifelse(LISPremium<=0 & RDwindow4==1, 1, 0)) %>%
  select(uniqueID, starts_with(c("RDwindow","belowBench"))) %>%
  group_by(uniqueID) %>%
  summarize_all(max, na.rm=TRUE) %>%
  filter_at(vars(RDwindow1:belowBench4), all_vars(is.finite(.)))

final.data <- final.data %>%
  left_join(final.data.rd, by=c("uniqueID"))

# Q1 - Ericson (2014) Figure 3 --------------------------------------------

final.bw1 <- final.data %>% 
  filter(RDwindow1==1, benefit=="B", year==2006)

rd.result1 <- rdplot(y=final.bw1$ln_share, 
                     x=final.bw1$LISPremium, 
                     c=0,
                     p=4,
                     hide=TRUE,
                     ci=95,
                     nbins=20)

bin.avg1 <- as_tibble(cbind(rd.result1$vars_bins,rd.result1$vars_poly))

rd.plot1 <- bin.avg1 %>%
  ggplot() +
  geom_point(aes(x=rdplot_mean_bin, y=rdplot_mean_y)) +
  geom_vline(aes(xintercept=0),linetype='dashed') +
  labs(
    x="Monthly premium - LIS subsidy, 2006",
    y="log enrollment share, 2006"
  ) +
  geom_line(aes(x=rdplot_x, y=rdplot_y)) +
  geom_line(aes(x=rdplot_mean_bin, y=rdplot_ci_l), linetype='longdash') +
  geom_line(aes(x=rdplot_mean_bin, y=rdplot_ci_r), linetype='longdash') +
  theme_bw()



# Q2 - Different bin widths -----------------------------------------------

rd.result2 <- rdplot(y=final.bw1$ln_share, 
                     x=final.bw1$LISPremium, 
                     c=0,
                     p=4,
                     hide=TRUE,
                     ci=95,
                     nbins=10)

bin.avg2 <- as_tibble(cbind(rd.result2$vars_bins,rd.result2$vars_poly))


rd.plot2 <- bin.avg2 %>%
  ggplot() +
  geom_point(aes(x=rdplot_mean_bin, y=rdplot_mean_y)) +
  geom_vline(aes(xintercept=0),linetype='dashed') +
  labs(
    x="Monthly premium - LIS subsidy, 2006",
    y="log enrollment share, 2006"
  ) +
  geom_line(aes(x=rdplot_x, y=rdplot_y)) +
  geom_line(aes(x=rdplot_mean_bin, y=rdplot_ci_l), linetype='longdash') +
  geom_line(aes(x=rdplot_mean_bin, y=rdplot_ci_r), linetype='longdash') +
  theme_bw()



# Q3 - Manipulation test --------------------------------------------------

rd.test <- rddensity(X=final.bw1$LISPremium, p=4)
pval.rd.test <- rd.test$test$p_jk
diff.rd.test <- rd.test$hat$diff
rd.test.plot <- rdplotdensity(rd.test, final.bw1$LISPremium,
                              lcol = c("black","black"),
                              xlabel = "Monthly premium - LIS subsidy, 2006",
                              plotRange = c(-10,10),
                              plotN = 100)



# Q4 - Enrollment/mkt share and premiums ----------------------------------
data.2006 <- final.data %>%
  filter(year==2006) %>%
  select(orgParentCode, planName, state, contractId, uniqueID,
         enrollment, share, ln_share, LISPremium_2006=LISPremium,
         premium_2006=premium)

data.2007 <- final.data %>%
  filter(year==2007) %>%
  select(orgParentCode, planName, state, contractId, uniqueID,
         premium_2007=premium)

reg.data <- data.2006 %>%
  left_join(data.2007, by=c("orgParentCode","planName","state",
                            "contractId","uniqueID")) %>%
  mutate(premium_diff=premium_2007-premium_2006)

inertia.plot <- reg.data %>%
  ggplot() +
  geom_point(aes(x=ln_share, y=premium_diff)) +
  labs(
    x="Log Market Share in 2006",
    y="Premium Growth from 2006 to 2007"
  ) +
  theme_bw()


# Q5 - Using LIS as IV ----------------------------------------------------


inertia <- ivreg(premium_diff~ln_share | LISPremium_2006, data=reg.data)
mean.share <- round(as.numeric(reg.data %>% summarize(mean_share=mean(share, na.rm=TRUE))), 3)

# Save final image --------------------------------------------------------

rm(list=c("pdp.data","lis.data", "bin.avg1", "bin.avg2", "final.bw1",
          "final.data", "final.data.rd", "rd.result1", "rd.result2",
          "rd.test","reg.data"))
save.image("solutions/exercise3/workspace.Rdata")

