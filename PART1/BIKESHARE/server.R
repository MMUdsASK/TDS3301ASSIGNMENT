# ASSIGNMENT 1 SHINY APPLICATION : server.R
# Backend processing of the Shiny application

# LOAD DATASET HERE
datasetD <- read.csv('day.csv', stringsAsFactors = FALSE)
datasetH <- read.csv('hour.csv',stringsAsFactors = FALSE)
library(plyr)
library(ggplot2)


shinyServer(function(input, output) {
  
  
  output$OUTPUT <- renderPlot({
    # get input variable
    selected <- input$selection
    if (selected == 1) {
      # data processing
      bikeMean <- ddply(datasetD, .(datasetD$yr, datasetD$season), summarize, cnt=mean(cnt))
      colnames(bikeMean)[1:2] = c('year','season') # naming columns
      bikeMean <- bikeMean[ order(bikeMean$year, bikeMean$season),]
      bikeMean$year = as.factor(bikeMean$year)
      bikeMean$season = as.factor(bikeMean$season)
      # produce bar graph
      ggplot(bikeMean, aes(year,cnt)) +
        geom_bar(aes(fill = as.factor(season)), position = "dodge", stat="identity") +
        scale_fill_discrete(name = "Season",
                            labels = c('Spring','Summer','Autumn','Winter')) +
        scale_x_discrete(labels = c('2011','2012'))
    }
    else if (selected == 2) {
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
    } else if (selected == 3) {
      # mean of bike count, separate by hours in a day
      # must use hour.csv for this
      bikeMean3 <- ddply(datasetH, .(datasetH$hr), summarize, cnt=mean(cnt))
      colnames(bikeMean3) <- c('hour','cnt')
      bikeMean3$hour <- as.factor(bikeMean3$hour)
      
      # bar graph
      ggplot(bikeMean3, aes(hour,cnt)) +
        geom_bar(stat="identity")
    }
  })
  
  output$TEXTOUT <- renderUI({}
  )
  
  
  
  
  
  
  
  
})
