*** Project: CFA Chapter 3
*** Author:  S Bauldry
*** Date:    May 29, 2020


*** Clear, set working directory, and load data
clear all
cd ~/desktop
import delim lead intl infl strg comp nice plst like intl1 like1 intl2 like2 ///
  using chp3-data.csv
  
  
*** preparing figure with distribution of indicators
local op1 "scheme(s1color) ylab(0(0.3)1, angle(h) grid gstyle(dot))"
local op2 "xlab(1(2)9, grid gstyle(dot)) ytit("density") xtit("rating")"

tempfile g1 g2 g3 g4 g5 g6 g7 g8
hist lead, `op1' `op2' tit("good leader") saving(`g1')
hist intl, `op1' `op2' tit("intelligent") saving(`g2')
hist infl, `op1' `op2' tit("influential") saving(`g3')
hist strg, `op1' `op2' tit("strong") saving(`g4')
hist comp, `op1' `op2' tit("competent") saving(`g5')
hist nice, `op1' `op2' tit("nice") saving(`g6')
hist plst, `op1' `op2' tit("pleasant") saving(`g7')
hist like, `op1' `op2' tit("likeable") saving(`g8')
graph combine "`g1'" "`g2'" "`g3'" "`g4'" "`g5'" "`g6'" "`g7'" "`g8'", ///
  scheme(s1color)
graph export chp3-fig4.pdf, replace


*** CFA with two latent variables
sem (lead <- Lead _cons@0) (Lead -> intl infl strg comp) ///
    (nice <- Like _cons@0) (Like -> plst like), means(Lead Like)
estat eqgof
sem, standardized


*** Fitting CFA with two latent variables using robust ML
sem (lead <- Lead _cons@0) (Lead -> intl infl strg comp) ///
    (nice <- Like _cons@0) (Like -> plst like), means(Lead Like) vce(sbentler)
	
sem (lead <- Lead _cons@0) (Lead -> intl infl strg comp) ///
    (nice <- Like _cons@0) (Like -> plst like), means(Lead Like) vce(robust)


*** Fitting CFA with missing data

* 25% MCAR in two indicators
sem (lead <- Lead _cons@0) (Lead -> intl1 infl strg comp)         ///
    (nice <- Like _cons@0) (Like -> plst like1), means(Lead Like) ///
	method(mlmv)
	
* generating 25% MNAR in two indicators
sem (lead <- Lead _cons@0) (Lead -> intl2 infl strg comp)         ///
    (nice <- Like _cons@0) (Like -> plst like2), means(Lead Like) ///
	method(mlmv)

	
*** MIIV estimator
sem (nice <- Like _cons@0) (Like -> plst like), means(Like)

ivregress 2sls plst (nice = like)
ivregress 2sls like (nice = plst)


sem (lead <- Lead _cons@0) (Lead -> intl infl strg comp) ///
    (nice <- Like _cons@0) (Like -> plst like), means(Lead Like)

ivregress 2sls intl (lead = infl strg comp)
ivregress 2sls infl (lead = intl strg comp)
ivregress 2sls strg (lead = infl intl comp)
ivregress 2sls comp (lead = infl intl strg)

