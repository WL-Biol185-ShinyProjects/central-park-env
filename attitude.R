library(shiny)

attitude <- tabItem(tabName = "Attitude",
        fluidRow(
          box(plotOutput("squirrel_plot1", height = 250)), box(plotOutput("squirrel_plot2", height = 250))
        ),
        
)
