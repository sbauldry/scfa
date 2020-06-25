*** Project: CFA Chapter 2
*** Author:  JM Roos
*** Date:    June 25, 2020


*** Clear, set working directory, and load NSDUH data
clear all
cd ~/desktop
import delim attend12 attendma reborn savesoul hellR bibleR using chp2-data.csv
  

*** 1 dimension
sem (PTC -> reborn savesoul bibleR hellR)

*** 2 dimensions
sem (EvangSpec -> reborn savesoul) (GenBel -> bibleR hellR)

*** 1 dimension, 1 correlated error
sem (PTC -> reborn savesoul bibleR hellR), cov(e.bibleR*e.hellR)

*** adding two causal indicators
sem (PTC -> reborn savesoul bibleR hellR) (PTC <- attend12 attendma), ///
  cov(e.bibleR*e.hellR)
