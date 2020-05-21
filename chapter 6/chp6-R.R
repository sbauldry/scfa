### Project: CFA chapter 6 
### Author:  S Bauldry
### Date:    May 21, 2020


### Clear, set working directory, and load lavaan and polycor
rm(list = ls())
setwd("~/desktop")
library(lavaan)
library(polycor)


### Load data
d1 <- read.table("chp6-data.csv", header = F, sep = ",")
attach(d1)


### declare indicators ordered
d1[, c("V2", "V3", "V4", "V5", "V6", "V7")] <- 
  lapply(d1[, c("V2", "V3", "V4", "V5", "V6", "V7")], ordered)


### selected polychoric correlations
pc23 <- polychor(V2,V3)
pc24 <- polychor(V2,V4)
pc25 <- polychor(V2,V5)
pc26 <- polychor(V2,V6)
pc27 <- polychor(V2,V7)
c(pc23, pc24, pc25, pc26, pc27)


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
