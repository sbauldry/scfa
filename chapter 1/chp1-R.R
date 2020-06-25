### Project: CFA chapter 1
### Author:  JM Roos
### Date:    June 9, 2020


### Clear, set working directory, and load package for CFA
rm(list = ls())
setwd("~/desktop")
library(lavaan)


### Define function for SBIC
sbicf <- function(semmodel) {
  sbicout.tmp <- (fitmeasures(semmodel, "chisq") - fitmeasures(semmodel, "df") * log(nobs(semmodel)))
  names(sbicout.tmp) = c("sbic")
  sbicout.tmp
}


### Load data
anes2016 <- read.csv("chp1-data.csv")


### Specify and fit measurement model
anesrace.model <- '
  # latent variables and indicators
  StereotypeDifferences =~ lazy + peaceful + tryhard
  RacialResentment =~ prejudice + deserve + tryhard + descrimination
  
  # correlated errors
  tryhard ~~ prejudice
  descrimination ~~ deserve
'

anesrace.est <- cfa(anesrace.model, data = anes2016)
summary(anesrace.est, fit.measures = TRUE)
sbicf(anesrace.est)
