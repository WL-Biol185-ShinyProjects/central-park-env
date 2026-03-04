library(shinydashboard)

dashboardPage(
  dashboardHeader(title = "Squirrel Exploration"),
  dashboardSidebar(
    sidebarMenu(
      menuItem("Dashboard", tabName = "dashboard", icon = icon("dashboard")),
      menuItem("Widgets", tabName = "widgets", icon = icon("th"))
    )
  ),
  dashboardBody(
    fluidRow(
      box(plotOutput("squirrel_plot", height = 250)), box(plotOutput("squirrel_plot2", height = 250)
    )
  )
))