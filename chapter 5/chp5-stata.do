*** Project: CFA Chapter 5
*** Author:  S Bauldry
*** Date:    May 21, 2020


*** Clear, set working directory, and load data
clear all
cd ~/desktop
import delim ger fre rgt wom rel using chp5-data.csv


*** descriptive statistics for indicators
bysort ger: sum fre rgt wom rel


*** preparing figure with distribution of indicators
local op1 "scheme(s1color) ylab(0(0.2)1, angle(h) grid gstyle(dot))"
local op2 "ytit("proportion")"
local op3 "scheme(s1color) rows(4)"

preserve
keep if ger
gen prp = 1/_N
tempfile g1 g2 g3 g4
graph bar (sum) prp, over(fre) `op1' `op2' tit("free")  saving(`g1')
graph bar (sum) prp, over(rgt) `op1' `op2' tit("civil") saving(`g2')
graph bar (sum) prp, over(rgt) `op1' `op2' tit("women") saving(`g3')
graph bar (sum) prp, over(rel) `op1' `op2' tit("religious") saving(`g4')
restore

preserve
keep if !ger
gen prp = 1/_N
tempfile g5 g6 g7 g8
graph bar (sum) prp, over(fre) `op1' `op2' tit("free")  saving(`g5')
graph bar (sum) prp, over(rgt) `op1' `op2' tit("civil") saving(`g6')
graph bar (sum) prp, over(rgt) `op1' `op2' tit("women") saving(`g7')
graph bar (sum) prp, over(rel) `op1' `op2' tit("religious") saving(`g8')
restore

tempfile g9 g10
graph combine "`g1'" "`g2'" "`g3'" "`g4'", `op3' tit("Germany") saving(`g9')
graph combine "`g5'" "`g6'" "`g7'" "`g8'", `op3' tit("Spain") saving(`g10')

graph combine "`g9'" "`g10'", scheme(s1color) rows(1)
graph export scfa-chp5-fig1.pdf, replace


*** separate measurement models for each country
sem (Dem -> fre rgt wom rel) if ger
sem (Dem -> fre rgt wom rel) if !ger

*** multiple-groups CFA
sem (Dem -> fre rgt wom rel), group(ger) ginvariant(mcoef mcons)
estat ginvariant

*** MIMIC models
sem (Dem -> fre rgt wom rel) (ger -> Dem)
sem (Dem -> fre rgt wom rel) (ger -> wom Dem)
