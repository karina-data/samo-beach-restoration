# This interactive web application highlights a living shoreline project implemented by The Bay Foundation and known as the Santa Monica Beach Restoration Pilot Project. TBF has collected five years of post restoration data displayed in the app.
# Author: Karina Johnston, kjohnston@santamonicabay.org


# Attach packages
library(shiny)
library(tidyverse)
library(here)
library(shinythemes)

# Read in the data
# plant_cover <- read_csv(here("data", "samo_vegetation_master.csv"))
# elev_profile <- read_csv(here("data", "elev_profile_master.csv"))


##############################
#### USER INTERFACE INPUT ####
##############################

# This section includes the inputs from the user interface section 
ui <- fluidPage(
    
  theme = shinytheme("cerulean"),
  
    # Application title
   
  navbarPage("Santa Monica Beach Restoration Pilot Project",
    
    #### PAGE 1 ####
    
    tabPanel("Information",
             sidebarLayout(
               sidebarPanel(
                 h4("This is an introduction to the Santa Monica Beach Restoration Pilot Project."
                   
                 ) # end h4
                 
               ), # end sidebarPanel
               
               mainPanel(
                 h5("Shiny App created by Karina Johnston, Science Director, The Bay Foundation"),
                 
                 
               ) # end mainPanel
               
             ) # end sidebarLayout
    
      
    ), # end tabPanel page 1
    
    
    #### PAGE 2 ####
    
    tabPanel("Plant Species Maps",
      
    # Sidebar with a slider input for number of bins 
    sidebarLayout(
        sidebarPanel(
          selectInput("select", label = h3("Select box"), 
                      choices = list("Species 1" = 1, 
                                     "Species 2" = 2, 
                                     "Species 3" = 3,
                                     "Species 4" = 4,
                                     "Species 5" = 5,
                                     "All plant species" = 6), 
                      selected = 1),
          
          hr(),
          fluidRow(column(6, verbatimTextOutput("value"))
                   ) # end selectInput
          
        ), # end sidebarPanel

        # Show a plot of the generated distribution
        mainPanel(
          # plotOutput("plantmap")
           
        ) # end mainPanel
        
    ) # end sidebarLayout

    ), # end tabPanel page 2

    #### PAGE 3 ####
    
    tabPanel("Plant Cover",
      sidebarLayout(
        sidebarPanel(
          
        ), # end sidebarPanel
        
        mainPanel(
          
        ) # end mainPanel
        
      ) # end sidebarLayout
      
    ), # end tabPanel page 3

    
    #### PAGE 4 ####
    
    tabPanel("Topography Profiles",
             sidebarLayout(
               sidebarPanel(
                 
               ), # end sidebarPanel
               
               mainPanel(
                 
               ) # end mainPanel
               
             ) # end sidebarLayout
             
    ), # end tabPanel page 4
    
    
    #### PAGE 5 ####
    
    tabPanel("Birds",
             sidebarLayout(
               sidebarPanel(
                 
               ), # end sidebarPanel
               
               mainPanel(
                 
               ) # end mainPanel
               
             ) # end sidebarLayout
             
    ), # end tabPanel page 5
    
    
    #### PAGE 6 ####
    
    tabPanel("Photographs",
             sidebarLayout(
               sidebarPanel(
                 
               ), # end sidebarPanel
               
               mainPanel(
                 
               ) # end mainPanel
               
             ) # end sidebarLayout
             
    ) # end tabPanel page 6
    
    
  ) # end navbarPage
  
) # end fluidPage


#######################
#### SERVER OUTPUT ####
#######################

# This section includes the server logic for the output commands
server <- function(input, output) {

  output$value <- renderPrint({ input$select })
  
} # end server function


#### Run the application ####
shinyApp(ui = ui, server = server)
