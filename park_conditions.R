library(tidyverse)
library(shinydashboard)
library(shiny)
library(plotly)

park_conditions <- tabItem(tabName = "park_conditions",
                           fluidRow(
                             box(
                               title = "Average Daily Tempertaure In Central Park",
                               status = "warning", solidHeader = TRUE,
                               width = 12,
                               p("Every time a volunteer added an entry for a squirrel, they were asked to record the 
          temperature outside during their time of observation. They also noted if they observed the squirrels in the
          morning (AM) or late afternoon (PM).")
                             )
                           ), 
                           fluidRow(
                             box(
                               width = 6,
                               plotOutput("conditions_plot1")
                                ),
                             box(
                               width = 6,
                               plotOutput("conditions_plot2")
                           )),
                           fluidRow(
                             box(
                               width = 6,
                               height = "500px",
                               plotOutput("conditions_plot3", height = "440px")
                             ),
                             box(
                               width = 6,
                               height = "500px",
                               radioButtons("shift_choice", 
                                            label = "Pick a time",
                                            choices = c("AM", "PM"),
                                            selected = "AM"),
                               plotOutput("conditions_plot4_5", height = "380px")
                             )
                           ),
                           fluidRow(
                             box(
                               title = "Temperature and Squirrel Activity",
                               status = "warning", solidHeader = TRUE,
                               width = 12,
                               p("The chart below shows how the temperature affected the activity the squirrels were doing. As the temperature increased, squirrels appear to be more active. They engage especially in foraging when the weather is warmer than 50 degrees.")
                             )
                           ),
                           fluidRow(
                             box(title = "Squirrel Activity by Temperature",
                                 status = "warning", solidHeader = TRUE,
                                 width = 12, plotOutput("temp_activity_plot", height = 350))
                           ))

