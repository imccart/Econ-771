
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

source('paths.R')


# Load data ------------------------------------------------------------

bench.data <- 
pen.data <- 
ahrf.data <- read.SAScii(fn=paste0(ahrf.path,"DATA/AHRF2019.asc"),
                         sas_ri=paste0(ahrf.path,"DOC/AHRF2018-19.sas"),
                         beginline=3) 


# Call analysis and set workspace for knitr -------------------------------
source('analysis.R')
rm(list=c("data", "data.ind", "households", "data.hh", "zip3.choices",
          "plan.data", "product.definitions", "final.data", "hh.language"))
save.image("solutions/exercise2/workspace.Rdata")



# Run abstract markdown ---------------------------------------------------
rmarkdown::render(input = 'solutions.Rmd',
                  output_format = 'all',
                  output_file ='Exercise2_Answers')
