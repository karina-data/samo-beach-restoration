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
library(lubridate)
library(shinyWidgets)


# Read in the data
birds <- read_csv(here("samo-beach-restoration", "data", "birds.csv"))
elevation_rest <- read_csv(here("samo-beach-restoration", "data", "elevation.csv")) %>% 
  filter(type == "restoration")

# Create winter/summer elevation dataframes
elevation_winter <- elevation_rest %>% 
  filter(season == "Winter")
elevation_summer <- elevation_rest %>% 
  filter(season == "Summer")

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
                 tags$li("Installed in 2016"),
                 tags$li("Led by: The Bay Foundation"),
                 tags$li("Partners: City of Santa Monica, California State Parks, Audubon Society"),
                 tags$li("Funded by: US Environmental Protection Agency and Annenberg Foundation"),
                 
                 br(),
                 img(src = "TBF_logo.png", 
                     height = 100, width = 100)
               

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

tabPanel("Topography Profiles",
         sidebarLayout(
           sidebarPanel(
             pickerInput(inputId = "season_year", 
                         label = h4("Select Winter Survey(s)"), 
                                choices = list("Baseline" = 1, 
                                               "Winter 2017" = 2,
                                               "Winter 2018" = 3,
                                               "Winter 2019" = 4,
                                               "Winter 2020" = 5),
                         options = list(`actions-box` = TRUE),
                         multiple = TRUE), # end pickerInput 1

                          
             pickerInput(inputId = "season_year", 
                         label = h4("Select Summer Survey(s)"), 
                         choices = list("Baseline" = 1, 
                                        "Summer 2017" = 2,
                                        "Summer 2018" = 3,
                                        "Summer 2019" = 4,
                                        "Summer 2020" = 5,
                                        "Summer 2021" = 6),
                         options = list(`actions-box` = TRUE),
                         multiple = TRUE), # end pickerInput 2
             
           
             h5("These checkboxes select elevation profile data for either winter or summer months within the restoration area. The graphs start from the back of the beach (lefthand side of the graph) to the ocean (righthand side). Data begin at the baseline in winter of 2016 and show an increase in elevation over time, as well as the formation of small dunes.")
             
           ), # end sidebarPanel
           
           mainPanel(
             plotOutput("elevProfile_winter", height = "250px", width = "700px"),
             plotOutput("elevProfile_summer", height = "250px", width = "700px")
             
           ) # end mainPanel
           
         ) # end sidebarLayout
         
), # end tabPanel page 2


#### PAGE 3 ####

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
         
), # end tabPanel page 3



    #### PAGE 4 ####
    
    tabPanel("Plant Species Maps",
      
    # Sidebar with a slider input for number of bins 
    sidebarLayout(
        sidebarPanel(
          selectInput("select", label = h4("Select box"), 
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

    ), # end tabPanel page 4


    #### PAGE 5 ####
    
    tabPanel("Plant Cover",
      sidebarLayout(
        sidebarPanel(
          fluidRow(
            column(12,
                   
                   # Slider bar 
                   sliderInput("slider1", label = h3("Select Year Range"), 
                               min = 0, 
                               max = 100, 
                               value = 50)
            )
            
          ), # end fluidRow
          
        ), # end sidebarPanel
        
        mainPanel(
          
        ) # end mainPanel
        
      ) # end sidebarLayout
      
    ), # end tabPanel page 5

    

    #### PAGE 6 ####
    
    tabPanel("Photographs",
             sidebarLayout(
               sidebarPanel(
                 h5("This page shows a series of project photographs beginning before implementation (first photo), then a week after the sand fence and seeds went in (second photo), and the rest were taken in January 2022, just over five years after implementation, with small dunes throughout the site."
                    
                 ), # end h4
                 
                 
                 h5("For more information, project reports, and documents, please visit:"), # end h4
                 a(href="www.santamonicabay.org", "www.santamonicabay.org"),
                 br(),
                 h6("Photo credit: The Bay Foundation"),
                 br(),
                 img(src = "TBF_logo.png", 
                     height = 100, width = 100)
                 
               ), # end sidebarPanel
               
               mainPanel(
                 
                 # Photograph 1
                 h5("Santa Monica Beach when it was groomed, or mechanically raked, before project implementation in August 2015 (facing northwest)."),
                 img(src = "samo_2016_before.jpg", 
                     height = 283, width = 515),
                 br(),
                 br(),
                 
                 # Photograph 2
                 h5("The project site approximately one week after the sand fence and native seeds were installed."),
                 img(src = "samo_1wk_after.jpg", 
                     height = 283, width = 515),
                 br(),
                 br(),
                 
                 # Photograph 3
                 h5("The project site five years after implementation (January 2022) taken from approximately the same location as the 'before' photograph (facing northwest)."),
                 
                 img(src = "samo_1-28-22_north.jpg", 
                     height = 283, width = 515),
                 br(),
                 br(),
                 
                 # Photograph 4
                 h5("The project site five years after implementation (January 2022) taken from the middle of the site facing the public access pathway and ocean (west)."),
                 
                 img(src = "samo_1-28-22_sign.jpg", 
                     height = 283, width = 515),
                 br(),
                 br(),
                 
                 # Photograph 5
                 h5("The project site five years after implementation (January 2022) taken from the southern half of the site facing west and towards the lifeguard tower. Note the 3-foot sand fence is buried across portions of the picture."),
                 
                 img(src = "samo_1-28-22_west.jpg", 
                     height = 283, width = 515),
                 br()
                 
               ) # end mainPanel
               
             ) # end sidebarLayout
             
    ), # end tabPanel page 6

   
    #### PAGE 7 ####

    tabPanel("Citations",
         sidebarLayout(
           sidebarPanel(
             h5("This page contains citations for the web application development and data.")
             
           ), # end sidebarPanel
           
           mainPanel(
             h4("Citations"),
             h6("citation1"),
             h6("citation2"),
             h6("citation3"),
             h6("citation4.....")
           ) # end mainPanel
           
         ) # end sidebarLayout
         
    ), # end tabPanel page 7


  ) # end navbarPage
  
) # end fluidPage



#######################
#### SERVER OUTPUT ####
#######################

# This section includes the server logic for the output commands
server <- function(input, output) {
  
  # Elevation Profile output - winter plot
  output$elevProfile_winter <- renderPlot({
    
    season_year <- input$season_year
    distance_m <- input$distance_m
    elevation_m <- input$elevation_m
    elevation_rest[elevation_rest$season_year %in% input$season_year,]
    
    ggplot(data = elevation_winter, aes(x = distance_m, y = elevation_m, 
                                        group = season_year)) +
      geom_line(aes(color = season_year), size = 1.2) +
      labs(x = "Distance (m)", y = "Elevation (m)", 
           title = "Winter Elevation Profiles") +
      scale_color_discrete(type = "viridis") +
      theme_classic() +
      theme(plot.title = element_text(hjust = 0.5))
    
  })

  
  # Elevation Profile output - summer plot
  output$elevProfile_summer <- renderPlot({
    
    season_year <- input$season_year
    distance_m <- input$distance_m
    elevation_m <- input$elevation_m
    elevation_rest[elevation_rest$season_year %in% input$season_year,]
    
    ggplot(data = elevation_summer, aes(x = distance_m, y = elevation_m, 
                                        group = season_year)) +
      geom_line(aes(color = season_year), size = 1.2) +
      labs(x = "Distance (m)", y = "Elevation (m)",
           title = "Summer Elevation Profiles") +
      scale_color_discrete(type = "viridis") +
      theme_classic() +
      theme(plot.title = element_text(hjust = 0.5))
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
