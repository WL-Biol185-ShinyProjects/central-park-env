library(shinydashboard)
library(shiny)


dashboardPage(skin = "green",

  dashboardHeader(title = "Squirrel Exploration"),
  dashboardSidebar(title = "Squirrels in Central Park",
    sidebarMenu(
      menuItem("Dashboard", tabName = "dashboard", icon = icon("dashboard")),
      menuItem("Meet the Squirrels", tabName = "meet_the_squirrels", icon = icon("tree")),
      menuItem("Where Are They", tabName = "where_are_they", icon = icon("map")),
      menuItem("What are They Doing", tabName = "what_are_they_doing", icon = icon("walking")),
      menuItem("Park Conditions", tabName = "park_conditions", icon = icon("sun"))
    )
  ),
  dashboardBody(
    tabItems(
      tabItem(tabName = "dashboard"),
      tabItem(tabName = "meet_the_squirrels"),
      tabItem(tabName = "where_are_they"),
      tabItem(tabName = "what_are_they_doing",
              fluidRow(
                box(plotOutput("squirrel_plot4", height = 250)), box(plotOutput("squirrel_plot2", height = 250))
              )
      ),
      tabItem(tabName = "park_conditions")
    )
  )
)
