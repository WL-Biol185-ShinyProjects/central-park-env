library(shiny)

attitude <- tabItem(tabName = "Attitude",
                               fluidRow(
                                 box(plotOutput("squirrel_plot1")), box(plotOutput("squirrel_plot2"))
                               )
                  )
                               
tail_behavior <- tabItem(tabName = "Tail_Behavior",
                                fluidRow(
                                  box(plotOutput("squirrel_plot3")), box(plotOutput("squirrel_plot4"))
                                )
                         )
                                 
activity <- tabItem(tabName = "Activity",
                                fluidRow(
                                  box(plotOutput("squirrel_plot7")), box(plotOutput("squirrel_plot8"))
                                )
                    )
                    
noise <- tabItem(tabName = "Noise",
                                fluidRow(
                                         box(plotOutput("squirrel_plot5")), box(plotOutput("squirrel_plot6"))
                                )
                 )  
