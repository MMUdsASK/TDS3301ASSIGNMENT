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
    } else if (selected == 4) {
      # defaults
      
      xData <- input$xdata
      yData <- input$ydata
      datasetChoice <- input$choice1
      
      # slice dataset according to year and season
      if (datasetChoice == 1) {
        datasetSC <- datasetD
      }
      else if (datasetChoice == 2) {
        datasetSC <- datasetD[which(datasetD$yr == 0),]
      }
      else if (datasetChoice == 3) {
        datasetSC <- datasetD[which(datasetD$yr == 0 & datasetD$season == 1),]
      }
      else if (datasetChoice == 4) {
        datasetSC <- datasetD[which(datasetD$yr == 0 & datasetD$season == 2),]
      }
      else if (datasetChoice == 5) {
        datasetSC <- datasetD[which(datasetD$yr == 0 & datasetD$season == 3),]
      }
      else if (datasetChoice == 6) {
        datasetSC <- datasetD[which(datasetD$yr == 0 & datasetD$season == 4),]
      }
      else if (datasetChoice == 7) {
        datasetSC <- datasetD[which(datasetD$yr == 1),]
      }
      else if (datasetChoice == 8) {
        datasetSC <- datasetD[which(datasetD$yr == 1 & datasetD$season == 1),]
      }
      else if (datasetChoice == 9) {
        datasetSC <- datasetD[which(datasetD$yr == 1 & datasetD$season == 2),]
      }
      else if (datasetChoice == 10) {
        datasetSC <- datasetD[which(datasetD$yr == 1 & datasetD$season == 3),]
      }
      else if (datasetChoice == 11) {
        datasetSC <- datasetD[which(datasetD$yr == 1 & datasetD$season == 4),]
      }
      textStrings <- c('Normalized temperature', 'Normalized feeling temperature', 'Normalized windspeed',
                       'Normalized humidity', 'Bike count')
      # slice data according to attribute
      if (xData  == 1) {
        xDataOut <- datasetSC$temp
      } else if (xData == 2) {
        xDataOut <- datasetSC$atemp
      } else if (xData == 3) {
        xDataOut <- datasetSC$windspeed
      } else if (xData == 4) {
        xDataOut <- datasetSC$hum
      } else if (xData == 5) {
        xDataOut <- datasetSC$cnt
      }
      if (yData  == 1) {
        yDataOut <- datasetSC$temp
      } else if (yData == 2) {
        yDataOut <- datasetSC$atemp
      } else if (yData == 3) {
        yDataOut <- datasetSC$windspeed
      } else if (yData == 4) {
        yDataOut <- datasetSC$hum
      } else if (yData == 5) {
        yDataOut <- datasetSC$cnt
      }
      
      
      # plot
      ggplot(datasetSC, aes(x = xDataOut, y = yDataOut)) +
        geom_point() + labs(x = textStrings[as.integer(xData)], y = textStrings[as.integer(yData)])
    }
  })
  
  
  
  
  
  
})
