### Project: CFA chapter 6 
### Author:  S Bauldry
### Date:    May 21, 2020


### Clear, set working directory, and load Lavaan
rm(list = ls())
setwd("~/desktop")
library(lavaan)


### Load data
d1 <- read.table("chp6-data.csv", header = F, sep = ",")
attach(d1)


### declare indicators ordered
d1[, c("V2", "V3", "V4", "V5", "V6", "V7")] <- 
  lapply(d1[, c("V2", "V3", "V4", "V5", "V6", "V7")], ordered)


### define measurement model
mod1 <- '
  CN =~ V2 + V3 + V4 + V5 + V6 + V7
'

### DWLS/WLS-MV estimator delta parameterization
fit1 <- cfa(mod1, data = d1, ordered = c("V2", "V3", "V4", "V5", "V6", "V7"))
summary(fit1)


### DWLS/WLS-MV estimator theta parameterization
fit2 <- cfa(mod1, data = d1, ordered = c("V2", "V3", "V4", "V5", "V6", "V7"), 
            parameterization = "theta")
summary(fit2)
