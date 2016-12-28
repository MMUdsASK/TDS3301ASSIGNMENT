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
                               "Mean of bike count by hours" = 3, "Customizable scatter plot" = 4), selected = 1),
    conditionalPanel(
      condition = "input.selection == 4",
      selectInput("choice1", label = h2("Data selection"), 
                  choices = list("2011 and 2012, all seasons" = 1,
                                 "2011, all seasons" = 2,
                                 "2011, Spring season" = 3,
                                 "2011, Summer season" = 4,
                                 "2011, Autumn season" = 5,
                                 "2011, Winter season" = 6,
                                 "2012, all seasons" = 7,
                                 "2012, Spring season" = 8,
                                 "2012, Summer season" = 9,
                                 "2012, Autumn season" = 10,
                                 "2012, Winter season" = 11),
                  selected = 1),
      selectInput("ydata", label = h2("Y axis"),
                  choices = list("Normalized Temperature" = 1,
                                 "Normalized Feeling Temperature" = 2,
                                 "Windspeed" = 3,
                                 "Normalized Humdity" = 4,
                                 "Bike count" = 5),
                  selected = 5),
      selectInput("xdata", label = h2("X axis"),
                  choices = list("Normalized Temperature" = 1,
                                 "Normalized Feeling Temperature" = 2,
                                 "Windspeed" = 3,
                                 "Normalized Humdity" = 4,
                                 "Bike count" = 5),
                  selected = 1)
    ),
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
