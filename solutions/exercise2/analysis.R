# Meta --------------------------------------------------------------------

## Date Created:  7/17/2020
## Date Edited:   7/22/2020
## Description:   Analysis file for exercise 2


# Preliminaries -----------------------------------------------------------

if (!require("pacman")) install.packages("pacman")
pacman::p_load(tidyverse, ggplot2, dplyr, lubridate, stargazer, knitr, kableExtra,
               lfe, modelr, SAScii, gtsummary, ggrepel, ivpack, lfe)

source('paths.R')

# Load data ------------------------------------------------------------

source('solutions/exercise2/1_benchmark.R')
source('solutions/exercise2/2_penetration.R')
source('solutions/exercise2/3_ahrf.R')


# Analytic Datasets -----------------------------------------------------------
full.data <- ma.penetration.data %>% 
  left_join(ma.benchmark.data %>% select(year, ssa, bench_pay, starts_with("risk")),
            by=c("ssa","year")) %>%
  left_join(ahrf.data %>% select(year, ssa, medicare_ffs_exp), 
            by=c("ssa","year")) %>%
  filter(year>=2010, 
         complete.cases(bench_pay, medicare_ffs_exp, penetration))
  



# Q1 summary stats --------------------------------------------------------


sum.stats <- full.data %>% ungroup() %>%
  summarize_at(c("penetration","bench_pay","medicare_ffs_exp"), list(mean, sd, min, max), na.rm=TRUE)

mean.stats <- sum.stats %>% select(ends_with("_fn1")) %>%
  pivot_longer(cols=ends_with("_fn1"),
               values_to="mean") %>%
  mutate(name=str_remove(name,"_fn1"))


std.stats <- sum.stats %>% select(ends_with("_fn2")) %>%
  pivot_longer(cols=ends_with("_fn2"),
               values_to="std") %>%
  mutate(name=str_remove(name,"_fn2"))


min.stats <- sum.stats %>% select(ends_with("_fn3")) %>%
  pivot_longer(cols=ends_with("_fn3"),
               values_to="min") %>%
  mutate(name=str_remove(name,"_fn3"))


max.stats <- sum.stats %>% select(ends_with("_fn4")) %>%
  pivot_longer(cols=ends_with("_fn4"),
               values_to="max") %>%
  mutate(name=str_remove(name,"_fn4"))

final.sum.stats <- mean.stats %>%
  left_join(std.stats, by="name") %>%
  left_join(min.stats, by="name") %>%
  left_join(max.stats, by="name") %>%
  mutate(name=case_when(
    name=="penetration" ~ "MA Share",
    name=="bench_pay" ~ "Benchmark Pymt",
    name=="medicare_ffs_exp" ~ "FFS Expenditure"
  ))



# Q2 scatterplot ----------------------------------------------------------

exp.pene.scatter <- full.data %>% ungroup() %>%
  group_by(year) %>%
  summarize(mean_pen=mean(penetration, na.rm=TRUE),
            mean_exp=mean(medicare_ffs_exp, na.rm=TRUE),
            mean_bench=mean(bench_pay, na.rm=TRUE)) %>%
  ggplot(aes(x=mean_pen, y=mean_exp)) +
  geom_point(size=4) +
  geom_text_repel(aes(label = year), point.padding=.2, segment.color='NA') + 
  labs(
    x="Penetration Rate",
    y="Medicare Expenditures"
  ) + 
  theme_minimal()  



# Q3 IV results -----------------------------------------------------------

iv1 <- felm(medicare_ffs_exp ~ 0 | year + ssa | (penetration ~ bench_pay) | ssa, 
             data=full.data)
iv1.pen <- iv1$coefficients[1]



# Q4 First stage and reduced form -----------------------------------------

first.stage <- felm(penetration ~ bench_pay | year + ssa | 0 | ssa, 
                    data=full.data)
reduced.form <- felm(medicare_ffs_exp ~ bench_pay | year + ssa | 0 | ssa, 
                     data=full.data)


# Q5 Sensitivity ----------------------------------------------------------
full.data2 <- full.data %>%
  mutate(bench_pay2=case_when(
    year<2012 ~ bench_pay,
    year>=2012 & year<2015 ~ risk_star35,
    year>=2015 ~ risk_bonus35,
    TRUE ~ NA_real_
  ))

iv2 <- felm(medicare_ffs_exp ~ 0 | year + ssa | (penetration ~ bench_pay2) | ssa, 
            data=full.data2)
first.stage2 <- felm(penetration ~ bench_pay2 | year + ssa | 0 | ssa, 
                    data=full.data2)
reduced.form2 <- felm(medicare_ffs_exp ~ bench_pay2 | year + ssa | 0 | ssa, 
                     data=full.data2)


library(riv)
riv.data <- full.data %>%
  filter(complete.cases(medicare_ffs_exp, penetration, bench_pay))

y.resid <- lm(medicare_ffs_exp ~ factor(year) + factor(ssa),
                data=riv.data)
x.resid <- lm(penetration ~ factor(year) + factor(ssa),
                data=riv.data)
z.resid <- lm(bench_pay ~ factor(year) + factor(ssa),
                data=riv.data)

riv.data <- riv.data %>%
  spread_residuals(y.resid, x.resid, z.resid) %>%
  filter(complete.cases(y.resid, x.resid, z.resid))


Y <- as.matrix(riv.data[,25])
Xend <- as.matrix(riv.data[,26])
Zinst <- as.matrix(riv.data[,27])

robust.iv1 <- riv(Y, Xend, Xex=NULL, Zinst, method="classical")
robust.iv2 <- riv(Y, Xend, Xex=NULL, Zinst)

riv2.pen <- robust.iv2$Summary.Table[2,1]



# Save final image --------------------------------------------------------

rm(list=c("full.data","ma.benchmark.data","ma.pene.2008","ma.pene.2009",
          "ma.pene.2010","ma.pene.2011","ma.pene.2012","ma.pene.2013",
          "ma.pene.2014","ma.pene.2015","ma.penetration.data",
          "max.stats","mean.stats","std.stats","min.stats","sum.stats",
          "pene.data","ahrf.data","full.data2","riv.data",
          "bench.data","bench.data.2007","bench.data.2008",
          "bench.data.2009","bench.data.2010","bench.data.2011",
          "bench.data.2012","bench.data.2013","bench.data.2014",
          "bench.data.2015"))
save.image("solutions/exercise2/workspace.Rdata")

