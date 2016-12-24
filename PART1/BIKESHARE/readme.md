# ABOUT THIS DATASET

This dataset records the number of rental bikes that are currently
mobile. Also, the dataset also records environmental factors, such
as windspeed, humidity, and temperatures

The observations are recorded every one hour, and its values recorded
in hour.csv. There is another dataset, days.csv, that aggregates the hours
into days, and removes the hour variable.

# DOMAIN

Urban transportation, related to bike-sharing

# VARIABLES

The variables that are recorded in the dataset are as follows:

## RECORD INDEX

The "instant" variable help identify the records in a chornological ascending order,
with the first record being the first hour, first day on the first year, while the last
record is recorded during the last hour, last day on the second year.

## TIME-OF-DAY

The dates are recorded under 'dteday', 'yr' ( 0 for 2011, 1 for 2012 ), 'mnth' for month,
and 'hr' for hour. In the day.csv of the dataset, the hour variable is removed, as all the hourly records
under the same day are aggregated into a single record.

In addition, 'holiday' indicates whether a day is considered a holiday for Washington, D.C where the dataset
were recorded, 'weekday' indicates the day of the week (Monday to Sunday), and 'workingday' indicates whether
it was a working day.

## WEATHER CONDITIONS

The weather conditions for a given time is recorded in the dataset. 'temp' indicates the temperature in Celsius,
while 'atemp' indicates the feeling temperature. Humidity is recorded under 'hum' and windspeed under the variable
'windspeed'. The variables stated above are normalized, and how the normalization were done under a certain formula.

## COUNTS

The count of rented bicycle on the move are divided into casual and registered users, the counts are summed up and
recorded as 'cnt'.

# URL

https://archive.ics.uci.edu/ml/datasets/Bike+Sharing+Dataset

The readme.txt explains the dataset in greater detail, from the original source.

