library(shinydashboard)
library(shiny)
library(leaflet)



source("sidebar.R")
source("meet_the_squirrels.R")
source("where_are_they.R")
source("what_are_they_doing.R")
source("park_conditions.R")
source("about_us.R")

  dashboardPage(skin = "green",
              dashboardHeader(title = "Squirrel Exploration"),
              dashboardSidebar(sidebar),
              dashboardBody(
    tabItems(
      meet_the_squirrels,
      where_are_they,
      attitude,
      activity,
      tail_behavior,
      noise,
      park_conditions,
      about_us
            )
  ),
  )