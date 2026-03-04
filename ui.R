library(shinydashboard)

<<<<<<< HEAD
dashboardPage((skin = "#652A0E"),
=======
dashboardPage(
>>>>>>> e4797d09b38855aea829ae3e7f3cddf36bb941e4
  dashboardHeader(title = "Squirrel Exploration"),
  dashboardSidebar(title = "What's the squirrel doing?"),
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