# loading libraries and the dataset itself
datasetD <- read.csv('day.csv', stringsAsFactors = FALSE)
datasetH <- read.csv('hour.csv',stringsAsFactors = FALSE)
library(plyr)
library(ggplot2)
library(lattice)



# converts dteday to date format
datasetD$dteday <- as.Date(datasetD$dteday)
datasetH$dteday <- as.Date(datasetH$dteday)


# cnt check
# ensure that cnt is the sum of casual and registered
indicesD <- which(datasetD$casual + datasetD$registered != datasetD$cnt)
indicesH <- which(datasetH$casual + datasetH$registered != datasetH$cnt)

# mean of bike count, sorted by season and time of day
# using the plyr package
bikeMean <- ddply(datasetD, .(datasetD$yr, datasetD$season), summarize, cnt=mean(cnt))
colnames(bikeMean)[1:2] = c('year','season') # naming columns
bikeMean <- bikeMean[ order(bikeMean$year, bikeMean$season),]
bikeMean$year = as.factor(bikeMean$year)
bikeMean$season = as.factor(bikeMean$season)

# display bar graph
ggplot(bikeMean, aes(year,cnt)) +
  geom_bar(aes(fill = as.factor(season)), position = "dodge", stat="identity") +
  scale_fill_discrete(name = "Season",
                      labels = c('Spring','Summer','Autumn','Winter')) +
  scale_x_discrete(labels = c('2011','2012'))

# mean of bike count, seprate by year and holiday
bikeMean1 <- ddply(datasetD, .(datasetD$yr,datasetD$holiday), summarize, cnt=mean(cnt))
colnames(bikeMean1)[1:2] = c('year','holiday')
bikeMean1 <- bikeMean1[ order(bikeMean1$year, bikeMean1$holiday),]
bikeMean1$year = as.factor(bikeMean1$year)
bikeMean1$holiday = as.factor(bikeMean1$holiday)

# bar graph plot
ggplot(bikeMean1, aes(year,cnt)) +
  geom_bar(aes(fill = as.factor(holiday)), position = "dodge", stat="identity") +
  scale_fill_discrete(name = "Holiday",
                      labels = c('Not Holiday','Holiday')) +
  scale_x_discrete(labels = c('2011','2012'))

# mean of bike count, separate by hours in a day
# must use hour.csv for this
bikeMean3 <- ddply(datasetH, .(datasetH$hr), summarize, cnt=mean(cnt))
colnames(bikeMean3) <- c('hour','cnt')
bikeMean3$hour <- as.factor(bikeMean3$hour)

# bar graph
ggplot(bikeMean3, aes(hour,cnt)) +
  geom_bar(stat="identity")


# scatterplot of temperature and bike count
ggplot(datasetD, aes(x = datasetD$temp, y = datasetD$cnt)) +
  geom_point() + labs(x = "Normalized temperature", y = "Bike count")