# scfa
The examples in Chapter 5 involve a measurement for beliefs about democracy using indicators from the Wave 6 of the World Values Survey (Ingelhart 20xx). Information about obtaining the data can be found at http://www.worldvaluessurvey.org/wvs.jsp.

## Data File
The data file "chp5-data" is a csv file that contains the following variables for 2889 cases with non-missing data on all of the indicators. All of the indicators are coded 1 = not essential characteristic, ..., 10 = essential characteristic.

1. ger: binary variable for German respondents (1 = German, 0 = Spanish)
2. fre: people choose their leaders in free elections
3. rgt: civil rights protect people from state oppression
4. wom: women have the same rights as men
5. rel: religious authorities ultimately interpret the laws


## Code Files

### Mplus
1. chp5-mplus-mg-1.inp: multiple-groups CFA examining configular, metric, and scalar invariance
2. chp5-mplus-mg-2.inp: multple-groups CFA examining partial measurement invariance
3. chp5-mplus-mimic.inp: baseline MIMIC model
4. chp5-mplus-mimic-u.inp: MIMIC model for uniform DIF
5. chp5-mplus-mimic-nu.inp: MIMIC model for nonuniform DIF

### Stata
1. chp5-stata.do: descriptive statistics, multiple-groups CFA, and MIMIC models


## Citation
Inglehart, R. C., Haerpfer, A. M., Welzel, C., et al. (2014). World Values Survey: Round Six - Country-Pooled Datafile 2010-2014.JD Systems Institute, Madrid.
