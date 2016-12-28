# ASSIGNMENT 1 SHINY APPLICATION : UI.R
# Determines the UI elements present in the shiny application

shinyUI(fluidPage(
  # title
  titlePanel("Bike sharing dataset visualizations"),
  
  # Sidebar layout
  sidebarLayout(
    
    # Side Panel
    sidebarPanel(
    
    # selection
    selectInput("selection", label = h3("Visualization options"), 
                choices = list("Mean of bike count by season and year" = 1, "Mean of bike count by holidays and year" = 2,
                               "Mean of bike count by hours" = 3), selected = 1),
    htmlOutput("TEXTOUT"),
    hr(),
    helpText("Data from Fanaee-T, Hadi and Gama, Joao ( 2013 ), Event labeling combining ensemble detectors and background knowledge")
    ),
    
    
    
    # Main panel
    mainPanel(
      plotOutput("OUTPUT")
    )
  )
  

)
)
