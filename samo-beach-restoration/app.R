# This interactive web application highlights a living shoreline project implemented by The Bay Foundation and known as the Santa Monica Beach Restoration Pilot Project. TBF has collected five years of post restoration data displayed in the app.
# Author: Karina Johnston, kjohnston@santamonicabay.org
# Date: February 2022


# Attach packages
library(shiny)
library(tidyverse)
library(here)
library(shinythemes)
library(collapsibleTree)
library(colorspace)

# Read in the data
birds <- read_csv(here("samo-beach-restoration", "data", "birds.csv"))
elevation_rest <- read_csv(here("samo-beach-restoration", "data", "elevation.csv")) %>% 
  filter(type == "restoration")
# elevation_ctrl <- read_csv(here("samo-beach-restoration", "data", "elevation.csv")) %>%
#   filter(type == "control")

# plant_cover <- read_csv(here("data", "samo_vegetation_master.csv"))


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
                 h4("This web app visualizes five years of data from the Santa Monica 
                    Beach Restoration Pilot Project"
                   
                 ), # end h4
                 h6("- Installed in 2016"),
                 h6("- Led by: The Bay Foundation"),
                 h6("- Partners: City of Santa Monica, California State Parks, Audubon Society"),
                 h6("- Funded by: US Environmental Protection Agency and Annenberg Foundation"),
                 
                 br(),
                 img(src = "TBF_logo.png", 
                     height = 100, width = 100)
                 
#                 h6("- Five years after implementation"),
                 

               ), # end sidebarPanel
               
               mainPanel(
                 h4("Shiny App created by Karina Johnston, Science Director, The Bay Foundation"),
                 h5("The Bay Foundation (TBF) restored approximately three acres beach adjacent to the ocean, by seeding four species of native plants adapted to live in this habitat area. Living on the ocean’s edge, this community of plants attracted insects and birds, and adapted to the harsh conditions of beach life, including salt spray, wind, and intense sunlight."),
                
                 h5("As the plants of the coastal strand habitat grow, they capture windblown sand beneath their branches and leaves. Over time, they build sand dunes that prevent waves and extreme tides from flooding the beach and nearby infrastructure. By reestablishing this habitat, TBF and its partners are able to enhance beaches that are naturally resistant to sea level rise, while creating refuge for endangered species and adding natural beauty to our beaches."),
                 
                 h5("This interactive web application displays trends from five-years of project data. The goal is to help visualize and understand biological and physical restoration trajectories. For more information:"),
                    a(href="www.santamonicabay.org", "www.santamonicabay.org"),
                 br(),
                    a(href="kjohnston@santamonicabay.org", "kjohnston@santamonicabay.org"),
                 br(),
                 br(),
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
                 checkboxGroupInput("checkGroup", label = h3("Select Survey Dates"), 
                                    choices = list("Dec 2016" = 1, 
                                                   "Jun 2017" = 2, 
                                                   "Nov 2017" = 3,
                                                   "Jun 2018" = 4,
                                                   "Nov 2018" = 5,
                                                   "Jun 2019" = 6,
                                                   "Nov 2019" = 7,
                                                   "Jun 2020" = 8),
                                    selected = 1:8),
                 
                 h5("This checkbox selects elevation profile data starting from the back of the beach (lefthand side of the graph) to the ocean (righthand side). Data begin at the baseline in 2016 and show an increase in elevation over time, as well as the formation of small dunes."),
                 
               ), # end sidebarPanel
               
               mainPanel(
                 plotOutput("elevProfile", height = "300px", width = "750px")
               ) # end mainPanel
               
             ) # end sidebarLayout
             
    ), # end tabPanel page 4
    
    
    #### PAGE 5 ####
    
    tabPanel("Birds",
             sidebarLayout(
               sidebarPanel(
                 
                 selectInput(
                   "hierarchy", "Tree hierarchy",
                   choices = c(
                     "Category", "Scientific Name", "Family", "Common Name"),
                   selected = c("Category", "Scientific Name"),
                   multiple = TRUE
                 ), # end selectInput
                 
       
                 h5("This collapsible tree shows bird species identified on site between 2016-2021. It is not a comprehensive list of bird species presence; rather, it is intended to be representative of species identified on surveys."),
               ), # end sidebarPanel
               
               
               # Show a tree diagram with the selected root node
               mainPanel(
                 collapsibleTreeOutput("tree", height = "500px")
               ) # end mainPanel
                 
             ) # end sidebarLayout
             
    ), # end tabPanel page 5
    
    
    #### PAGE 6 ####
    
    tabPanel("Photographs",
             sidebarLayout(
               sidebarPanel(
                 h4("This page shows a series of project photographs beginning before implementation (first photo), then a week after the sand fence and seeds went in (second photo), and the rest were taken in January 2022, just over five years after implementation, with small dunes throughout the site."
                    
                 ), # end h4
                 
                 br(),
                 h4("For more information, project reports, and documents, please visit:"), # end h4
                 a(href="www.santamonicabay.org", "www.santamonicabay.org"),
                 br(),
                 h6("Photo credit: The Bay Foundation"),
                 br(),
                 img(src = "TBF_logo.png", 
                     height = 100, width = 100)
                 
               ), # end sidebarPanel
               
               mainPanel(
                 
                 # Photograph 1
                 h6("Santa Monica Beach when it was groomed, or mechanically raked, before project implementation in August 2015 (facing northwest)."),
                 img(src = "samo_2016_before.jpg", 
                     height = 283, width = 515),
                 br(),
                 br(),
                 
                 # Photograph 2
                 h6("The project site approximately one week after the sand fence and native seeds were installed."),
                 img(src = "samo_1wk_after.jpg", 
                     height = 283, width = 515),
                 br(),
                 br(),
                 
                 # Photograph 3
                 h6("The project site five years after implementation (January 2022) taken from approximately the same location as the *before* photograph (facing northwest)."),
                 
                 img(src = "samo_1-28-22_north.jpg", 
                     height = 283, width = 515),
                 br(),
                 br(),
                 
                 # Photograph 4
                 h6("The project site five years after implementation (January 2022) taken from the middle of the site facing the public access pathway and ocean (west)."),
                 
                 img(src = "samo_1-28-22_sign.jpg", 
                     height = 283, width = 515),
                 br(),
                 br(),
                 
                 # Photograph 5
                 h6("The project site five years after implementation (January 2022) taken from the southern half of the site facing west and towards the lifeguard tower."),
                 
                 img(src = "samo_1-28-22_west.jpg", 
                     height = 283, width = 515),
                 br()
                 
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
  
  # Elevation Profile output
  output$elevProfile <- renderPlot({
    
    ggplot(data = elevation_rest, aes(x = distance_m, y = elevation_m, group = date)) +
      geom_line(aes(color = date), size = 1.2) +
      labs(x = "Distance (m)", y = "Elevation (m)") +
      theme_classic()
  })

  
  # Bird Collapsible Tree output
  output$tree <- renderCollapsibleTree({
    collapsibleTreeSummary(
      birds,
      hierarchy = input$hierarchy,
      inputId = "node",
#      fill = qualitative_hcl(4, palette = "Dark 3"),
#      fillByLevel = TRUE
      
#      root = input$fill
#      attribute = input$fill
    )
  })
  
  output$value <- renderPrint({ input$select })
  
} # end server function



#### Run the application ####
shinyApp(ui = ui, server = server)
