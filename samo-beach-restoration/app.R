# This web application highlights a living shoreline project implemented by The Bay Foundation and known as the Santa Monica Beach Restoration Pilot Project. TBF has collected 5 years of post restoration data.
# Author: Karina Johnston, kjohnston@santamonicabay.org


# Attach packages
library(shiny)
library(tidyverse)


# This section includes the inputs from the user interface section 
ui <- fluidPage(

    # Application title
    titlePanel("Santa Monica Beach Restoration Pilot Project"),

    # Sidebar with a slider input for number of bins 
    sidebarLayout(
        sidebarPanel(
            sliderInput("bins",
                        "Number of bins:",
                        min = 1,
                        max = 50,
                        value = 30)
        ),

        # Show a plot of the generated distribution
        mainPanel(
           plotOutput("distPlot")
        )
    )
)


# This section includes the server logic for the output commands
server <- function(input, output) {

    
  
}

# Run the application 
shinyApp(ui = ui, server = server)
