# ASSIGNMENT 3 SHINY APPLICATION : server.R
# Backend processing of the Shiny application

# LIBRARIES
library(ROCR) # ROC curve
library(ggplot2)
# load performance measures
load('perf.RO')


# load test dataset
datatest <- read.table("datatest2.txt",header=TRUE,sep=",",stringsAsFactors = FALSE)



shinyServer(function(input, output) {
  
  output$OUTPUT <- renderPlot({
    plot( perf, col = 'red', lwd = 2)
    plot(perf2, add = TRUE, col = 'blue', lwd = 2)
    plot(perf3, add = TRUE, col = 'darkgreen', lwd = 2)
    legend(0.6,0.6, legend=c("Decision Tree", "Naive Bayes", "ANN"),
           col=c("red", "blue", "darkgreen"), lty=1, cex=0.8, lwd = 2)
    
    if(input$selection == 1 & input$classifier == 1) {
      plot( perf, col = 'red', lwd = 2)
    }
    if(input$selection == 2 & input$classifier == 1) {
      plot( perf4, col = 'red', lwd = 2)
    }
    if(input$selection == 1 & input$classifier == 2) {
      plot( perf2, col = 'blue', lwd = 2)
    }
    if(input$selection == 2 & input$classifier == 2) {
      plot( perf5, col = 'blue', lwd = 2)
    }
    if(input$selection == 1 & input$classifier == 3) {
      plot( perf3, col = 'darkgreen', lwd = 2)
    }
    if(input$selection == 2 & input$classifier == 3) {
      plot( perf6, col = 'darkgreen', lwd = 2)
    }
    if(input$selection == 1 & input$classifier == 4) {
      plot( perf, col = 'red', lwd = 2)
      plot(perf2, add = TRUE, col = 'blue', lwd = 2)
      plot(perf3, add = TRUE, col = 'darkgreen', lwd = 2)
      legend(0.6,0.6, legend=c("Decision Tree", "Naive Bayes", "ANN"),
             col=c("red", "blue", "darkgreen"), lty=1, cex=0.8, lwd = 2)
    }
    if(input$selection == 2 & input$classifier == 4) {
      plot(perf4, col = 'red', lwd = 2)
      plot(perf5, add = TRUE, col = 'blue', lwd = 2)
      plot(perf6, add = TRUE, col = 'darkgreen', lwd = 2)
      legend(0.6,0.6, legend=c("Decision Tree", "Naive Bayes", "ANN"),
             col=c("red", "blue", "darkgreen"), lty=1, cex=0.8, lwd = 2)
    }
    
    
  })
})