# loading libraries and the dataset itself
datasetD <- read.csv('day.csv', stringsAsFactors = FALSE)
datasetH <- read.csv('hour.csv',stringsAsFactors = FALSE)
library(plyr)
library(ggplot2)



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
colnames(bikeMean)[1:2] = c('year','season')
bikeMean <- bikeMean[ order(bikeMean$year, bikeMean$season),]
bikeMean$year = as.factor(bikeMean$year)
bikeMean$season = as.factor(bikeMean$season)

ggplot(bikeMean, aes(year,cnt)) +
  geom_bar(aes(fill = as.factor(season)), position = "dodge", stat="identity") +
  scale_fill_discrete(name = "Season",
                      labels = c('Spring','Summer','Autumn','Winter')) +
  scale_x_discrete(labels = c('2011','2012'))