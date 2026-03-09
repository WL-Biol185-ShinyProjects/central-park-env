library(shinydashboard)
library(shiny)


dashboardPage(
  dashboardHeader(title = "Squirrel Exploration"),
  dashboardSidebar(title = "What's the squirrel doing?",
    sidebarMenu(
      menuItem("Dashboard", tabName = "dashboard", icon = icon("dashboard")),
      menuItem("Meet the Squirrels", tabName = "Meet the Squirrels", icon = icon("tree")),
      menuItem("Where Are They", tabName = "Where Are They", icon = icon("map"))
    )
  ),
  dashboardBody(
    fluidRow(
      box(plotOutput("squirrel_plot", height = 250)), box(plotOutput("squirrel_plot2", height = 250))
    )
  )
)

