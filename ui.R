library(shinydashboard)
library(shiny)


dashboardPage(skin = "green",

  dashboardHeader(title = "Squirrel Exploration"),
  dashboardSidebar(title = "Squirrels in Central Park",
    sidebarMenu(
      menuItem("Dashboard", tabName = "dashboard", icon = icon("dashboard")),
      menuItem("Meet the Squirrels", tabName = "Meet the Squirrels", icon = icon("tree")),
      menuItem("Where Are They", tabName = "Where Are They", icon = icon("map")),
      menuItem("What are They Doing", tabName = "What are They Doing", icon = icon("walking")),
      menuItem("Park Conditions", tabName = "Park Conditions", icon = icon("sun"))
    )
  ),
  dashboardBody(
    fluidRow(
      box(plotOutput("squirrel_plot4", height = 250)), box(plotOutput("squirrel_plot2", height = 250))
    )
  )
)

