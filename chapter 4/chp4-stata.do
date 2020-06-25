*** Project: CFA Chapter 4
*** Author:  JM Roos
*** Date:    June 25, 2020


*** Clear, set working directory, and load NSDUH data
clear all
cd ~/desktop
import delim nervous restless hopeless depressed effort worthless ///
  using chp4-nsduh-data.csv
  

*** Baseline model
sem (PD -> nervous restless hopeless depressed effort worthless)
di "sbic = "  e(chi2_ms) -  e(df_ms) * ln(e(N))
estat gof, stats(all)
estat eqgof
estat mindices


*** Alternative model
sem (Anx -> nervous restless) (Dep -> hopeless depressed effort worthless)
di "sbic = "  e(chi2_ms) -  e(df_ms) * ln(e(N))
estat gof, stats(all)
estat eqgof



*** Clear, set working directory, and load AH data
clear all
cd ~/desktop
import delim change determine interfere control solve using chp4-ah-data.csv


*** Baseline model
sem (SelfEff -> change determine interfere control solve)
di "sbic = "  e(chi2_ms) -  e(df_ms) * ln(e(N))
estat gof, stats(all)


*** Split sample to illustrate modification indices
set seed 777
gen splitvar = runiform()
gen sample1 = (splitvar < .5)


*** Models in lower half
sem (SelfEff -> change determine interfere control solve) if sample1
di "sbic = "  e(chi2_ms) -  e(df_ms) * ln(e(N))
estat gof, stats(all)
estat mindices, minchi2(0)

* first iteration based on modindices
sem (SelfEff -> change determine interfere control solve) if sample1, ///
  cov(e.change*e.determine)
di "sbic = "  e(chi2_ms) -  e(df_ms) * ln(e(N))
estat gof, stats(all)
estat mindices, minchi2(0)

* second iteration based on modindices
sem (SelfEff -> change determine interfere control solve) if sample1, ///
  cov(e.change*e.determine) cov(e.change*e.interfere) 
di "sbic = "  e(chi2_ms) -  e(df_ms) * ln(e(N))
estat gof, stats(all)


*** Compare with model in upper half
sem (SelfEff -> change determine interfere control solve) if !sample1, ///
  cov(e.change*e.determine) cov(e.change*e.interfere) 
di "sbic = "  e(chi2_ms) -  e(df_ms) * ln(e(N))
estat gof, stats(all)
