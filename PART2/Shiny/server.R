# ASSIGNMENT 2 SHINY APPLICATION : server.R
# Backend processing of the Shiny application

# LIBRARIES
library("arules")
library(arulesViz)
library(pmml)
rules <- read.PMML('rules.xml')


shinyServer(function(input, output) {
  
  output$OUTPUT <- renderPlot({
    choice <- input$selection
    if (choice == 1) {
      plot(rules)
    }
    else if (choice == 2) {
      plot(rules[1:10], method = 'grouped')
    }
    else if (choice == 3) {
      plot(rules[1:10], method = 'graph', control = list(type = 'items'))
    }
    else if (choice == 4) {
      plot(rules[1:10], method = 'paracoord', control = list(reorder = TRUE))
    }
    
    
    
    
  })
  
  
  
  
})
