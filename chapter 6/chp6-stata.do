*** Project: CFA Chapter 6
*** Author:  S Bauldry
*** Date:    May 21, 2020


*** Clear, set working directory, and load data
clear all
cd ~/desktop
import delim id mp12a mp12b mp12c mp12d mp12e mp12f using chp6-data.csv


*** preparing figure with distribution of indicators
lab def dua 1 "D" 2 "U" 3 "A"
lab val mp12* dua 

gen prp = 1/_N

local op1 "scheme(s1color) ylab(0(0.2)1, angle(h) grid gstyle(dot))"
local op2 "ytit("proportion")"

tempfile g1 g2 g3 g4 g5 g6
graph bar (sum) prp, over(mp12a) `op1' `op2' tit("nation") saving(`g1')
graph bar (sum) prp, over(mp12b) `op1' `op2' tit("values") saving(`g2')
graph bar (sum) prp, over(mp12c) `op1' `op2' tit("separate") saving(`g3')
graph bar (sum) prp, over(mp12d) `op1' `op2' tit("symbols") saving(`g4')
graph bar (sum) prp, over(mp12e) `op1' `op2' tit("plan") saving(`g5')
graph bar (sum) prp, over(mp12f) `op1' `op2' tit("prayer") saving(`g6')
graph combine "`g1'" "`g2'" "`g3'" "`g4'" "`g5'" "`g6'", scheme(s1color)
graph export scfa-chp6-fig1.pdf, replace

drop prp


*** estimate correlations and polychoric correlations
*** note: polychoric is a user-written command that needs to be installed
corr mp12*
polychoric mp12*


*** ML estimator with logit link
gsem (CN -> mp12a mp12b mp12c mp12d mp12e mp12f, ologit)
estat ic

*** ML estimator with probit link
gsem (CN -> mp12a mp12b mp12c mp12d mp12e mp12f, oprobit)
estat ic


*** graph predicted probabilities using WLS-MV delta parameterization
*** estimates from Mplus
capture program drop grp
program grp
  args ld t1 t2 tb1 tb2 tb3 tb4 tb5 tb6 tit gn
  
  graph twoway (function y = 1 - normal( (-1)*`t1' + `ld'*x), range(-3 3))  ///
    (function y = normal( (-1)*`t1' + `ld'*x ) -                            ///
	              normal( (-1)*`t2' + `ld'*x ), range(-3 3))                ///
	(function y = normal( (-1)*`t2' + `ld'*x ) - 0, range(-3 3)),           ///
    scheme(s1color) legend(off) ylab( , angle(h) grid gstyle(dot))          ///
    xlab(-3(1)3, grid gstyle(dot)) ytit("predicted probability")            ///
    xtit("latent Christian nationalism") tit("`tit'")                       ///
	text(`tb1' `tb2' "D") text(`tb3' `tb4' "U") text(`tb5' `tb6' "A")       ///
	xline(-1.8, lp(dash)) xline(1.8, lp(dash)) saving(`gn', replace)
  
end

grp  1.000  0.415  0.611 0.90 -1.5 0.12 0 0.90 2.4 "nation" g1
grp  1.006 -0.066  0.102 0.90 -2.0 0.12 0 0.90 2.0 "values" g2
grp -0.516 -0.600 -0.309 0.12 -2.0 0.15 0 0.32 2.1 "separate" g3
grp  0.832 -0.576 -0.318 0.92 -1.9 0.14 0 0.92 2.0 "symbols" g4
grp  0.872 -0.163  0.185 0.90 -2.2 0.19 0 0.90 2.2 "plan" g5
grp  0.970 -0.513 -0.307 0.88 -2.2 0.13 0 0.90 2.0 "prayer" g6

graph combine g1.gph g2.gph g3.gph g4.gph g5.gph g6.gph, scheme(s1color)
graph export scfa-chp6-fig5.pdf, replace

forval i = 1/6 {
  erase g`i'.gph
}


*** calculate marginal effects using WLS-MV delta parameterization
*** estimates from Mplus
capture program drop me
program me
  args a b ld t1 t2
  
  * predicted probabilities at a
  scalar Da = 1 - normal( (-1)*`t1' + `ld'*`a' )
  scalar Ua = normal( (-1)*`t1' + `ld'*`a' ) - normal( (-1)*`t2' + `ld'*`a' )
  scalar Aa = normal( (-1)*`t2' + `ld'*`a' )
  
  * predicted probabilities at b
  scalar Db = 1 - normal( (-1)*`t1' + `ld'*`b' )
  scalar Ub = normal( (-1)*`t1' + `ld'*`b' ) - normal( (-1)*`t2' + `ld'*`b' )
  scalar Ab = normal( (-1)*`t2' + `ld'*`b' )
  
  * difference
  scalar Dba = Db - Da
  scalar Uba = Ub - Ua
  scalar Aba = Ab - Aa
  
  dis "pr at a: " as res %5.2f Da  " " as res %5.2f Ua  " " as res %5.2f Aa
  dis "pr at b: " as res %5.2f Db  " " as res %5.2f Ub  " " as res %5.2f Ab
  dis "me: "      as res %5.2f Dba " " as res %5.2f Uba " " as res %5.2f Aba
end

me -0.45 0.45  1.000  0.415  0.611 // nation
me -0.45 0.45  1.006 -0.066  0.102 // values
me -0.45 0.45 -0.516 -0.600 -0.309 // separate
me -0.45 0.45  0.832 -0.576 -0.318 // symbols
me -0.45 0.45  0.872 -0.163  0.185 // plan
me -0.45 0.45  0.970 -0.513 -0.307 // prayer
