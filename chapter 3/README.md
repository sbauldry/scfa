# scfa
The examples in Chapter 3 are based on a measurement model for leadership qualities that is part of an experimental study reported in Mize (2019).

## Data File
The data file "chp3-data" is a csv file that contains the following variables for 318 participants with non-missing data on all of the indicators (except for the indicators with added missingness for illustration). The data file "chp3-data-mplus" is a csv file with missing values set to -9 for reading the data in Mplus.

1. lead: good leader
2. intl: intelligent
3. infl: influential
4. strg: strong
5. comp: competent
6. nice: nice
7. plst: pleasant
8. like: likeable
9. intl1: intelligent with 25% MCAR
10. like1: likeable with 25% MCAR
11. intl2: intelligent with MNAR
12. like2: likeable with MNAR 


## Code Files

### Mplus
1. chp3-mplus-ml.inp: ML estimator
2. chp3-mplus-mlm.inp: Satorra-Bentler ML estimator (MLM)
3. chp3-mplus-mlr.inp: robust ML estimator (MLR)
4. chp3-mplus-miss1.inp: ML with MCAR misisng data
5. chp3-mplus-miss2.inp: ML with MNAR missing data

### R
1. chp3-R.R: figure and all measurement models

### Stata
1. chp3-stata.do: figure and all measurement models


## Citation
Mize, Trenton. 2019. "Doing Gender by Criticizing Leaders: Public and Private Displays of Status." *Social Problems* 66:86-107.
