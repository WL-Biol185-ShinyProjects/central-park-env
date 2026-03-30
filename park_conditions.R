library(tidyverse)
library(shinydashboard)
library(shiny)

park_conditions <- tabItem(tabName = "park_conditions",
                           fluidRow(
                             box(plotOutput("conditions_plot1"), width = 12),
                           ),
                             fluidRow(
                               box(
                                 title = "Average Daily Tempertaure In Central Park",
                                 status = "warning", solidHeader = TRUE,
                                 width = 12,
                                 p("Every time a volunteer added an entry for a squirrel, they were also asked to recorded the 
          temperature outside during their time of observation as well as if they observed the squirrels in the
          morning (AM) or afternoon (PM).")
                               )
                           ),
                           fluidRow(
                             box(title = "Squirrel Activity by Temperature",
                                 status = "warning", solidHeader = TRUE,
                                 width = 12, plotOutput("temp_activity_plot", height = 350))
                           ),
                           fluidRow(
                             box(
                               title = "About this Chart",
                               status = "warning", solidHeader = TRUE,
                               width = 12,
                               p("This chart shows how the temperature affected the activity the squirrels were observed doing. As the temperature increased, squirrels appear to be more active. They especially engage in foraging when the weather is warmer than 50 degrees.")
                             )
                             
                           )
)
