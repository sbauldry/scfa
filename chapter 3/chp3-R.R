### Project: CFA chapter 3
### Author:  S Bauldry
### Date:    May 29, 2020


### Clear, set working directory, and load libraries for CFA, IV, and renaming
rm(list = ls())
setwd("~/desktop")
library(lavaan)
library(AER)
library(reshape)


### Load data
d1 <- read.table("chp3-data.csv", header = F, sep = ",")
attach(d1)


### Rename variables
d1 <- rename(d1, c(V1 = "lead", V2 = "intl", V3 = "infl", V4 = "strg", V5 = "comp",
                   V6 = "nice", V7 = "plst", V8 = "like", V9 = "intl1", V10 = "like1",
                   V11 = "intl2", V12 = "like2"))
summary(d1)


### define measurement model
mod1 <- '
  Lead =~ lead + intl + infl + strg + comp
  Like =~ nice + plst + like
'

### standard ML estimator
fit1 <- cfa(mod1, data = d1)
summary(fit1)

### Satorra-Bentler robust estimator
fit2 <- cfa(mod1, data = d1, estimator = "MLM")
summary(fit2)

### Robust estimator
fit3 <- cfa(mod1, data = d1, estimator = "MLR")
summary(fit3)


### define measurement model with MCAR
mod2 <- '
  Lead =~ lead + intl1 + infl + strg + comp
  Like =~ nice + plst + like1
'

### ML estimator with missing data
fit4 <- cfa(mod2, data = d1, missing = "ML")
summary(fit4)


### define measurement model with MNAR
mod3 <- '
  Lead =~ lead + intl2 + infl + strg + comp
  Like =~ nice + plst + like2
'

### ML estimator with missing data
fit5 <- cfa(mod3, data = d1, missing = "ML")
summary(fit5)


### MIIV estimators
miiv.lambda2 <- ivreg(plst ~ nice | like, data = d1)
summary(miiv.lambda2)

miiv.lambda3 <- ivreg(like ~ nice | plst, data = d1)
summary(miiv.lambda3)
