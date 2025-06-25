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
      selectInput(inputId = "...", #name your y-input 
                  label = "...", #label your input
                  choices = c("..."), #provide choices for your input 
                  selected = "..."), #choose what's selected
      
      # Select variable for x-axis
      selectInput(inputId = "...", #name your x-input 
                  label = "...", #label your input
                  choices = c("..."), 
                  selected = "...") #choose what's selected
    ),
    
    # Output: Show scatterplot
    mainPanel(
      plotOutput(outputId = "...") #name your output
    )
  )
)


#Before moving to the server, take special note about the names of your y-input, x-input, and output. 

# Define server function --------------------------------------------
server <- function(input, output) {

  # Create scatterplot object the plotOutput function is expecting
  output$name.of.output <- renderPlot({ #change code here
    ggplot(data = movies, aes_string(x = input$name.of.x.input, y = input$name.of.y.input)) + #change code here
      geom_point()
  })
}

# Create the Shiny app object ---------------------------------------
shinyApp(ui = ui, server = server)


#The solutions are in the moives_01.R file
