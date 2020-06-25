# scfa
Chapter four builds two examples using different samples. The first set of examples make use of the 2012 NSDUH (available here:
https://www.datafiles.samhsa.gov/study/national-survey-drug-use-and-health-nsduh-2012-nid13601). The second set of examples makes use of the public-use version of Wave 4 of the National Longitudinal Study of Adolescent to Adult Health (Add Health). This dataset can be downloaded from ICPSR at https://www.icpsr.umich.edu/web/ICPSR/studies/21600?archive=ICPSR&q=21600.

## Data File
The data file "chp4-nsduh-data" is a csv file that contains the following variables for 5,431 cases with non-missing data on all of the indicators. All of the indicators are coded 1 = all of the time, ..., 5 = none of the time.

1. nervous
2. restless
3. hopeless
4. depressed
5. effort
6. worthless

The data file "chp4-ah-data" is a csv file that contains the following variables for 5,091 cases with non-missing data on all of the indicators. All of the indicators are coded 1 = strongly agree, ..., 5 = strongly disagree.

1. change
2. determine
3. interfere
4. control
5. solve


## Code Files

### Stata
1. chp4-stata.do: illustration of model fit and modification indices using both data sources.


