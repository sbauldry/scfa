# scfa
The examples in Chapter 6 involve a measurement for Christian nationalism using indicators from the 2017 wave of the Values and Beliefs of the American Public Survey. The example is based on an analysis from Whitehead et al. (2018). Information about obtaining the data can be found at https://www.baylor.edu/baylorreligionsurvey/.

## Data File
The data file "chp6-data" is a csv file that contains the following variables for 1,378 cases with non-missing data on all of the indicators. All of the indicators are coded 1 = disagree/strongly disagree, 2 = undecided, and 3 = agree/strongly agree.

1. id: generated sequential ID variable
2. mp12a: declare US Christian nation
3. mp12b: advocate Christian values
4. mp12c: enforce separation of church and state
5. mp12d: allow display of religious symbols
6. mp12e: success of US part of God's plan
7. mp12f: allow prayer in school


## Code Files

### Stata
1. chp6-stata.do

### Mplus
1. chp6-mplus-wlsmv-delta.inp: code for WLS-MV estimator with delta parameterization
2. chp6-mplus-wlsmv-theta.inp: code for WLS-MV estimator with theta parameterization
3. chp6-mplus-mlr-logit.inp: code for ML estimator with logit link
4. chp6-mplus-mlr-probit.inp: code for ML estimator with probit link


## Citation
Whitehead, Andrew L., Samuel L. Perry, and Joseph O. Baker. 2018. "Make American Christian Again: Christian Nationalism and Voting for Donald Trump in the 2016 Election." *Sociology of Religion* 79: 147-171.
