library(shinydashboard)
library(shiny)


dashboardPage(skin = "green",

  dashboardHeader(title = "Squirrel Exploration"),
  dashboardSidebar(title = "Squirrels in Central Park",
    sidebarMenu(
      menuItem("Dashboard", tabName = "dashboard", icon = icon("dashboard")),
      menuItem("Meet the Squirrels", tabName = "meet_the_squirrels", icon = icon("tree")),
      menuItem("Where Are They", tabName = "where_are_they", icon = icon("map")),
      menuItem("What are They Doing", icon = icon("walking"), 
          menuSubItem("Attitude", tabName = "Attitude"),
          menuSubItem("Activity", tabName = "Activity"),
          menuSubItem("Tail Behavior", tabName = "Tail_Behavior"),
          menuSubItem("Noise", tabName = "Noise")
      ),
      menuItem("Park Conditions", tabName = "park_conditions", icon = icon("cloud"))
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
