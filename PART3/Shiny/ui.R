# ASSIGNMENT 3 SHINY APPLICATION : UI.R
# Determines the UI elements present in the shiny application

shinyUI(fluidPage(
  # title
  titlePanel("Performance of classifier"),
  
  # Sidebar layout
  sidebarLayout(
    # Side Panel
    sidebarPanel(
      # selection
      selectInput("selection", label = h3("Navigation"), 
                  choices = list("ROC Curve" = 1, "Specficity and Sensitivity Curve" = 2), selected = 1),
       selectInput("classifier", label = h3("Classifier"), 
                choices = list("Decision Tree" = 1, "Naive Bayes" = 2,
                               "Artifical Neural Network" = 3, "All classifiers" = 4), selected = 1),
      hr(),
      helpText("Classfier model dataset based on Occupancy Dataset at UCI Machine Learning Repository")
    ),


    
    
    
    # Main panel
    mainPanel(
      plotOutput("OUTPUT")
    )
  )
)
)
