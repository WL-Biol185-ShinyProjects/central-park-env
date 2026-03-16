library(tidyverse)
library(shinydashboard)
library(shiny)


park_conditions <- tabItem(tabName = "park_conditions",
    fluidRow(
      box(plotOutput("conditions_plot1"), width = 12),
      fluidRow(
        box(
          title = "Average Daily Tempertaure In Central Park", 
          width = 12,
          p("Every time a volunteer added an entry for a squirrel, they were also asked to recorded the 
          temperature outside during their time of observation as well as if they observed the squirrels in the
          morning (AM) or afternoon (PM)."),
            )
              )
            )
                          )
