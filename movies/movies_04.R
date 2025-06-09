# Lastly, let's create a checkbox to display a data table if the box is checked
# Which input should we use? 

# Load packages -----------------------------------------------------
library(tidyverse)
library(ggplot2)

# Load data ---------------------------------------------------------
load("data/movies.Rdata")

# Define UI ---------------------------------------------------------
ui <- fluidPage(
  
  # Sidebar layout with a input and output definitions
  sidebarLayout(
    
    # Inputs: Select variables to plot
    sidebarPanel(
      
      # Select variable for y-axis
      selectInput(inputId = "y", 
                  label = "Y-axis:",
                  choices = c("imdb_rating", "imdb_num_votes", "critics_score", "audience_score", "runtime"), 
                  selected = "audience_score"),
      
      # Select variable for x-axis
      selectInput(inputId = "x", 
                  label = "X-axis:",
                  choices = c("imdb_rating", "imdb_num_votes", "critics_score", "audience_score", "runtime"), 
                  selected = "critics_score"),
      
      # Select variable for color
      selectInput(inputId = "z", 
                  label = "Color by:",
                  choices = c("title_type", "genre", "mpaa_rating", "critics_rating", "audience_rating"),
                  selected = "mpaa_rating"),
      
      # Set alpha level
      sliderInput(inputId = "alpha", 
                  label = "Alpha:", 
                  min = 0, max = 1, 
                  value = 0.5),
      
      # Show data table
      checkboxInput(inputId = "show_data", #Comment on the changes here
                    label = "Show data:", 
                    value = TRUE)
    ),
    
    # Output
    mainPanel(
      
      # Show scatterplot
      plotOutput(outputId = "scatterplot"),
      

      # Show data table
      DT::dataTableOutput(outputId = "moviestable") #Comment on the changes here
      
     

    )
  )
)

# Define server function --------------------------------------------
server <- function(input, output) {
  
  # Create scatterplot object the plotOutput function is expecting
  output$scatterplot <- renderPlot({
    ggplot(data = movies, aes_string(x = input$x, y = input$y,
                                     color = input$z)) +
      geom_point(alpha = input$alpha)
  })
  
  # Print data table if checked
  output$moviestable <- DT::renderDataTable( #Comment on the changes here
    if(input$show_data){                                                                                                                                                                                                                                       
      DT::datatable(data = movies[, 1:7], 
                    options = list(pageLength = 15), 
                    rownames = FALSE)
    }
  )
}

# Create the Shiny app object ---------------------------------------
shinyApp(ui, server)
