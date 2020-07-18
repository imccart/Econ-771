
# Meta --------------------------------------------------------------------

## Title:         Econ 771: Exercise 2 Solutions
## Author:        Ian McCarthy
## Date Created:  7/17/2020
## Date Edited:   7/17/2020
## Description:   This file renders/runs all relevant R code for the project


# Preliminaries -----------------------------------------------------------

if (!require("pacman")) install.packages("pacman")
pacman::p_load(tidyverse, ggplot2, dplyr, lubridate, stargazer, knitr, kableExtra,
               lfe, modelr, SAScii)

paths...


# Load data ------------------------------------------------------------

bench.data <- 
pen.data <- 
ahrf.data <- read.SAScii(paste0(ahrf.path,"AHRF2019.asc"),
                         paste0(ahrf.path,"AHRF2019.sas")) 


# Call analysis and set workspace for knitr -------------------------------
source('analysis.R')
rm(list=c("data", "data.ind", "households", "data.hh", "zip3.choices",
          "plan.data", "product.definitions", "final.data", "hh.language"))
save.image("workspace.Rdata")



# Run abstract markdown ---------------------------------------------------
rmarkdown::render(input = 'solutions.Rmd',
                  output_format = 'all',
                  output_file ='Exercise2_Answers')
