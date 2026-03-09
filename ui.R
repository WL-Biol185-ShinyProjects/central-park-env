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
      tabItem(tabName = "Attitude",
              fluidRow(
                box(plotOutput("squirrel_plot1", height = 250)), box(plotOutput("squirrel_plot2", height = 250))
              )),
      tabItem(tabName = "Tail_Behavior",
              fluidRow(
                box(plotOutput("squirrel_plot3")), box(plotOutput("squirrel_plot4"))
              )),    
      tabItem(tabName = "Noise",
               fluidRow(
                 box(plotOutput("squirrel_plot5")), box(plotOutput("squirrel_plot6"))
              )),    
      tabItem(tabName = "park_conditions")
      )
    )
)

