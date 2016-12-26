# ASSIGNMENT 1 SHINY APPLICATION : server.R
# Backend processing of the Shiny application

# LOAD DATASET HERE
datasetX <- read.csv('day.csv')


shinyServer(function(input, output) {
  
  
  output$OUTPUT <- renderPlot({
    # get input variable
    selected <- input$selection
    if (selected == 1) {
      # PLOT CODE
      plot( x = dataset$instant, y = dataset$weathersit)
    }
    else if (selected == 2) {
      
    }
    
    
    
    
    
    
  })
  
  
  
  
  
  
  
  
})