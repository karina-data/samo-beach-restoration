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
                 h4("This web app summarizes information from the Santa Monica 
                    Beach Restoration Pilot Project."
                   
                 ), # end h4
                 h6("- Installed in 2016"),
                 h6("- Led by: The Bay Foundation"),
                 h6("- Partners: City of Santa Monica, California State Parks, Audubon Society"),
                 h6("- Funded by: US Environmenal Protection Agency and Annenberg Foundation"),
                 h6("- Five years after implementation"),
                 
               ), # end sidebarPanel
               
               mainPanel(
                 h4("Shiny App created by Karina Johnston, Science Director, The Bay Foundation"),
                 h5("The Bay Foundation (TBF) restored approximately three acres beach adjacent to the ocean, by seeding four species of native plants adapted to live in this habitat area. Living on the ocean’s edge, this community of plants attracted insects and birds, and adapted to the harsh conditions of beach life, including salt spray, wind, and intense sunlight."),
                
                 h5("As the plants of the coastal strand habitat grow, they capture windblown sand beneath their branches and leaves. Over time, they build sand dunes that prevent waves and extreme tides from flooding the beach and nearby infrastructure. By reestablishing this habitat, TBF and its partners are able to enhance beaches that are naturally resistant to sea level rise, while creating refuge for endangered species and adding natural beauty to our beaches."),
                
                 h5("This interactive web application displays trends from five-years of project data. For more information: www.santamonicabay.org or email kjohnston@santamonicabay.org."),
                 
                 img(src = "pathview_verbena.jpg", 
                     height = 283, width = 515)
                 
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
                      selected = 1), # end selectInput
          
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
          fluidRow(
            column(12,
                   
                   # Slider bar 
                   sliderInput("slider1", label = h3("Slider"), min = 0, 
                               max = 100, value = 50)
            )
            
          ), # end fluidRow
          
        ), # end sidebarPanel
        
        mainPanel(
          
        ) # end mainPanel
        
      ) # end sidebarLayout
      
    ), # end tabPanel page 3

    
    #### PAGE 4 ####
    
    tabPanel("Topography Profiles",
             sidebarLayout(
               sidebarPanel(
                 checkboxGroupInput("checkGroup", label = h3("Checkbox group"), 
                                    choices = list("Dec 2016" = 1, 
                                                   "Jun 2017" = 2, 
                                                   "Nov 2017" = 3,
                                                   "Jun 2018" = 4,
                                                   "Nov 2018" = 5,
                                                   "Jun 2019" = 6,
                                                   "Nov 2019" = 7,
                                                   "Jun 2020" = 8),
                                    selected = 1),
                 
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
