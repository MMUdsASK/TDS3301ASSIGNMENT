# ASSIGNMENT 2 SHINY APPLICATION : UI.R
# Determines the UI elements present in the shiny application

shinyUI(fluidPage(
  # title
  titlePanel("Visualization of association rule"),
  
  # Sidebar layout
  sidebarLayout(
    # Side Panel
    sidebarPanel(
      # selection
      selectInput("selection", label = h3("Visualization options"), 
                  choices = list("Scatter Plot" = 1, "Grouped Matrix (limited)" = 2,
                                 "Graph plot (limited)" = 3, "Parallel Coordinate (limited)" = 4), selected = 1)
      ,
      hr(),
      helpText("Based on Extended Bakery dataset by Cal Poly")
    ),


    
    
    
    # Main panel
    mainPanel(
      plotOutput("OUTPUT")
    )
  )
)
)
