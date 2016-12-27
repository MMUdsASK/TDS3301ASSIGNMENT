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
      plot( x = datasetX$instant, y = datasetX$weathersit, ylab = "Weather",
            xlab = "Time")
    }
    else if (selected == 2) {
      
    }
  })
  
  output$TEXTOUT <- renderUI(
    tagList(
      p("Weather indicators"),
      p("1 = Normal weather"),
      p("2 = Cloudy weather"),
      p("3 = Rainy or snowy weather")
    )
    
    
    
  )
  
  
  
  
  
  
  
  
})
