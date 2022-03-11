######################################################
#### Santa Monica Beach Restoration Pilot Project ####
######################################################

# This interactive web application highlights a living shoreline project implemented by The Bay Foundation and known as the Santa Monica Beach Restoration Pilot Project. TBF has collected five years of post restoration data displayed in the app.

# Author: Karina Johnston, kjohnston@santamonicabay.org, www.santamonicabay.org
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

# Plant cover by sps over all years
plants <- read_csv(here("samo-beach-restoration", "data", "sps_total_distance.csv")) %>% 
  mutate(year = mdy(date)) %>% 
  janitor::clean_names() 



##############################
#### USER INTERFACE INPUT ####
##############################

# This section includes the inputs from the user interface section 
ui <- fluidPage(
    
  theme = shinytheme("cerulean"),
  
    # Application title
   
  navbarPage("Santa Monica Beach Restoration Pilot Project",
    
    #### PAGE 1 ####
    
    tabPanel("Introduction",
             sidebarLayout(
               sidebarPanel(
                 h4("This web app visualizes five years of data from the Santa Monica 
                    Beach Restoration Pilot Project"
                   
                 ), # end h4
                 tags$li("Installed in December 2016"),
                 tags$li("Led by: The Bay Foundation"),
                 tags$li("Partners: City of Santa Monica, California State Parks, Audubon Society"),
                 tags$li("Funded by: US Environmental Protection Agency and Annenberg Foundation"),
                 
                 br(),
                 img(src = "TBF_logo.png", 
                     height = 100, width = 100)
               

               ), # end sidebarPanel
               
               mainPanel(
                 h4("Shiny App created by Karina Johnston, Science Director, The Bay Foundation"),
                 h5("The Bay Foundation (TBF) restored approximately three acres of beach adjacent to the ocean, by seeding four species of native plants adapted to live in this habitat area. Living on the ocean’s edge, this community of plants grew slowly and attracted insects and birds, while adapting to the harsh conditions of beach life, including salt spray, wind, and intense sunlight."),
                
                 h5("As the plants of the coastal strand habitat grow, they capture windblown sand beneath their leaves. Over time, the plants stabilize the sand and then build small sand dunes that prevent waves and extreme tides from flooding the beach and nearby infrastructure. By reestablishing this habitat, TBF and its partners are able to enhance beaches that are naturally resilient to sea level rise, while creating a refuge for endangered species and adding natural beauty to our beaches."),
                 
                 h5("This interactive web application displays trends from five-years of project data. Click through the tabs at the top to explore the data. The goal is to help visualize and understand biological and physical restoration trajectories at the site. For more information:"),
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
    

    
    #### PAGE 6 ####
    
    tabPanel("Photographs",
             sidebarLayout(
               sidebarPanel(
                 h5("This page shows a series of project photographs beginning before implementation (top photo on the right), then a week after the sand fence and seeds went in (second photo), and the rest were taken in January 2022, approximately five years after implementation, with small dunes and native plants visible throughout the site."
                    
                 ), # end h4
                 
                 
                 h5("For more information, project reports, photographs, and other supplemental documents, please visit:"), # end h4
                 a(href="www.santamonicabay.org", "www.santamonicabay.org"),
                 br(),
                 h6("Photo credit: The Bay Foundation"),
                 br(),
                 img(src = "TBF_logo.png", 
                     height = 100, width = 100)
                 
               ), # end sidebarPanel
               
               mainPanel(
                 
                 # Photograph 1
                 h5("Santa Monica Beach when it was groomed, or mechanically raked, before project implementation in August 2015 (facing northwest). Note the mechanized grooming tracks and lack of plants and dunes."),
                 img(src = "samo_2016_before.jpg", 
                     height = 283, width = 515),
                 br(),
                 br(),
                 
                 # Photograph 2
                 h5("The project site approximately one week after the sand fence and native seeds were installed (facing southwest from the middle of the site). Note the smoothed sand from the wind and the installation of the fence in a curved pattern."),
                 img(src = "samo_1wk_after.jpg", 
                     height = 283, width = 515),
                 br(),
                 br(),
                 
                 # Photograph 3
                 h5("The project site five years after implementation (January 2022) taken from approximately the same location as the 'before' photograph at the top (facing northwest). You can see plants of several species throughout the site with small sand dunes, and the fence is over half buried."),
                 
                 img(src = "samo_1-28-22_north.jpg", 
                     height = 283, width = 515),
                 br(),
                 br(),
                 
                 # Photograph 4
                 h5("The project site five years after implementation (January 2022) taken from the middle of the site facing the public access pathway and ocean (west). You can see one of the two interpretive signs, the pathway, plants throughout the site, and a line of dunes close to the ocean."),
                 
                 img(src = "samo_1-28-22_sign.jpg", 
                     height = 283, width = 515),
                 br(),
                 br(),
                 
                 # Photograph 5
                 h5("The project site five years after implementation (January 2022) taken from the southern half of the site facing west and towards the lifeguard tower. Note the 3-foot tall sand fence is buried in several areas of the picture (foreground and close to the lifeguard tower)."),
                 
                 img(src = "samo_1-28-22_west.jpg", 
                     height = 283, width = 515),
                 br()
                 
               ) # end mainPanel
               
             ) # end sidebarLayout
             
    ), # end tabPanel page 6
    
    
        
#### PAGE 2 ####

tabPanel("Topography Profiles",
         sidebarLayout(
           sidebarPanel(
             pickerInput(inputId = "season_year_winter", 
                         label = h4("Select Winter Survey(s)"), 
                                choices = list("Baseline", 
                                               "Winter 2017",
                                               "Winter 2018",
                                               "Winter 2019",
                                               "Winter 2020"),
                         options = list(`actions-box` = TRUE),
                         multiple = TRUE,
                         selected = c("Baseline", "Winter 2020")), # end pickerInput 1

                          
             pickerInput(inputId = "season_year_summer", 
                         label = h4("Select Summer Survey(s)"), 
                         choices = list("Baseline", 
                                        "Summer 2017",
                                        "Summer 2018",
                                        "Summer 2019",
                                        "Summer 2020",
                                        "Summer 2021"),
                         options = list(`actions-box` = TRUE),
                         multiple = TRUE,
                         selected = c("Baseline", "Summer 2021")), # end pickerInput 2
             
           
             h5("These checkboxes select elevation profile data for either winter (top) or summer (bottom) months within the restoration area. The graphs start from the back of the beach (lefthand side of the graph) to the ocean (righthand side)."),
            
             h5("Data begin at the baseline in winter of 2016 (bottom line on the graphs) and show an increase in elevation over time, as well as the formation of small dunes. Click through the top dropdown box to select the winter survey data years, and click through the bottom dropdown box to change the selection of summer data years. The starting default visualizes the baseline survey in 2016 for both graphs and the most recent survey for each.")
             
           ), # end sidebarPanel
           
           mainPanel(
             plotOutput("elevProfile_winter", height = "225px", width = "700px"),
             plotOutput("elevProfile_summer", height = "225px", width = "700px")
             
           ) # end mainPanel
           
         ) # end sidebarLayout
         
), # end tabPanel page 2


#### PAGE 3 ####

tabPanel("Bird Species",
         sidebarLayout(
           sidebarPanel(
             
             selectInput(
               "hierarchy", "Tree hierarchy",
               choices = c(
                 "Category", "Scientific Name", "Family"),
               selected = c("Category", "Scientific Name"),
               multiple = TRUE
             ), # end selectInput
             
             
             h5("This collapsible tree shows bird species identified on site between 2016-2021. It is not a comprehensive list of bird species presence; rather, it is intended to be representative of species identified on infrequent surveys."),
            
             h5("The starting tree output shows the bird categories or guilds, and if you click on the category, it will unfold into the scientific bird names of that guild found on site. Use the box to change options (e.g., to add a family layer or remove one of the other layers).")
             
           ), # end sidebarPanel
           
           
           # Show a tree diagram with the selected root node
           mainPanel(
             collapsibleTreeOutput("tree", height = "500px")
           ) # end mainPanel
           
         ) # end sidebarLayout
         
), # end tabPanel page 3


    #### PAGE 5 ####
    
    tabPanel("Plant Cover",
      sidebarLayout(
        sidebarPanel(
          fluidRow(
            column(12,
                   
                   # Slider bar 
                   sliderInput("slider1", label = h3("Select Year Range"), 
                               min = 2017, 
                               max = 2021, 
                               value = 2021,
                               sep = "",
                               dragRange = TRUE)
            )
            
          ), # end fluidRow
          
          h5("This graph shows vegetation cover by species over time, beginning just after restoration in 2017, and continuing through five years of surveys through the most recent in 2021. Seven species are native and one (sea rocket) is not native."),
          h5("Sliding the bar across the years will change the graph display on the right. The graph default displays all years of data.")
          
        ), # end sidebarPanel
        
        mainPanel(
          plotOutput("plant_cover")
          
          
        ) # end mainPanel
        
      ) # end sidebarLayout
      
    ), # end tabPanel page 5



    #### PAGE 7 ####

    tabPanel("Citations",
         sidebarLayout(
           sidebarPanel(
             h5("This page contains citations for the web application development and project data. This web application was created using R Shiny App by Karina Johnston."),
             br(),
             img(src = "TBF_logo.png", 
                 height = 100, width = 100),
             img(src = "Rlogo.png", 
                 height = 100, width = 100)
             
           ), # end sidebarPanel
           
           mainPanel(
             h4("Citations"),
             h6("Chang, Winston, Joe Cheng, JJ Allaire, Carson Sievert, Barret Schloerke, Yihui Xie, Jeff Allen, Jonathan McPherson, Alan Dipert, and Barbara Borges (2021). shiny: Web Application Framework for R. R package version 1.7.1. https://CRAN.R-project.org/package=shiny"),
             h6("Chang, Winston (2021). shinythemes: Themes for Shiny. R package version 1.2.0. https://CRAN.R-project.org/package=shinythemes"),
             h6("Garrett Grolemund, Hadley Wickham (2011). Dates and Times Made Easy with lubridate. Journal of Statistical Software, 40(3), 1-25. URL https://www.jstatsoft.org/v40/i03/."),
             h6("Johnston, K., C. Enyart, M. Jenkins, D. Lazarus, and S. Cuadra. 2021. Santa Monica Beach Restoration Pilot Project: Year 5 Annual Report. Report prepared by The Bay Foundation for City of Santa Monica, California Coastal Commission, US Environmental Protection Agency, and California Department of Parks and Recreation. 118 pages."),
             h6("Johnston, K., C. Enyart, K. Alvarez, and H. Weyland. 2020. Santa Monica Beach Restoration Pilot Project: Year 4 Annual Report. Report prepared by The Bay Foundation for City of Santa Monica, California Coastal Commission, US Environmental Protection Agency, and California Department of Parks and Recreation. 100 pages."),
             h6("Johnston, K., M. Grubbs, and C. Enyart. 2019. Santa Monica Beach Restoration Pilot Project: Year 3 Annual Report. Report prepared by The Bay Foundation for City of Santa Monica, California Coastal Commission, US Environmental Protection Agency, and California Department of Parks and Recreation. 88 pages."),
             h6("Johnston, K, et al. Unpublished Data. 2016-2021. Source: The Bay Foundation. Funded by US Environmental Protection Agency, Annenberg Foundation."),
             h6("Khan, Adeel (2018). collapsibleTree: Interactive Collapsible Tree Diagrams using 'D3.js'. R package version 0.1.7. https://CRAN.R-project.org/package=collapsibleTree"),
             h6("Perrier, Victor, Fanny Meyer, and David Granjon (2022). shinyWidgets: Custom Inputs Widgets for Shiny. R package version 0.6.4. https://CRAN.R-project.org/package=shinyWidgets"),
             h6("R Core Team (2021). R: A language and environment for statistical computing. R   Foundation for Statistical Computing, Vienna, Austria. URL https://www.R-project.org/."),
             h6("RStudio Team (2021). RStudio: Integrated Development Environment for R. RStudio, PBC, Boston, MA URL http://www.rstudio.com/."),
             h6("Wickham et al., (2019). Welcome to the tidyverse. Journal of Open Source Software, 4(43), 1686, https://doi.org/10.21105/joss.01686")
             
             
#             h6("any other citations, put them here")

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
  
  # Elevation winter reactive
  season_year_winter_react <- reactive({
    season_yr <- input$season_year_winter

#    message("season year winter react check:", season_yr)
    x <- elevation_rest %>% filter(season_year %in% season_yr) %>% 
      filter(season == "Winter")
    

  })
    
  # Elevation Profile output - winter plot
  output$elevProfile_winter <- renderPlot({
    
    
    ggplot(data = season_year_winter_react(), aes(x = distance_m, y = elevation_m, 
                                        group = season_year)) +
      ggalt::geom_xspline(aes(color = season_year), size = 1.2) +
      labs(x = "Distance (m)", y = "Elevation (m)", 
           title = "Winter Elevation Profiles") +
      scale_color_viridis_d() +
      theme_classic() +
      theme(plot.title = element_text(hjust = 0.5))
    
  })

  # Elevation summer reactive
  season_year_summer_react <- reactive({
    season_yr <- input$season_year_summer
    
#    message("season year summer react check:", season_yr)
    x <- elevation_rest %>% filter(season_year %in% season_yr) %>% 
      filter(season == "Summer")
    
#    print(head(x))
#    return(x)
  })
  
  
  # Elevation Profile output - summer plot
  output$elevProfile_summer <- renderPlot({
    
    ggplot(data = season_year_summer_react(), aes(x = distance_m, y = elevation_m, 
                                                  group = season_year)) +
      ggalt::geom_xspline(aes(color = season_year), size = 1.2) +
      labs(x = "Distance (m)", y = "Elevation (m)", 
           title = "Summer Elevation Profiles") +
      scale_color_viridis_d() +
      theme_classic() +
      theme(plot.title = element_text(hjust = 0.5))
    
  })
  

  # Bird Collapsible Tree output
  output$tree <- renderCollapsibleTree({
    collapsibleTreeSummary(
      birds,
      hierarchy = input$hierarchy,
      inputId = "node"
#      fill = qualitative_hcl(4, palette = "Dark 3"),
#      fillByLevel = TRUE
      
#      root = input$fill
#      attribute = input$fill
    )
  })
  
  
  # Plant reactive
  plant_react <- reactive({
    
    veg_cover <- input$slider1
    x <- plants %>% filter(date %in% veg_cover) 
    
  })
  
#  season_year_summer_react <- reactive({
#    season_yr <- input$season_year_summer
    
#    x <- elevation_rest %>% filter(season_year %in% season_yr) %>% 
#      filter(season == "Summer")
  
  
  # Plant cover output
  output$plant_cover <- renderPlot({
    
    ggplot(data = plant_react(), aes(x = date, y = veg_cover_percent), group = species) +
      geom_col(aes(fill = species)) +
      scale_fill_viridis_d() +
      labs(x = "Survey Event Year",
           y = "Vegetation Cover (%)",
           title = "Vegetation Cover by Species 2016-2021") +
      theme_classic() +
      theme(plot.title = element_text(hjust = 0.5))
    
    
  })
  
  
  
  output$value <- renderPrint({ input$select })
  
} # end server function



#### Run the application ####
shinyApp(ui = ui, server = server)
