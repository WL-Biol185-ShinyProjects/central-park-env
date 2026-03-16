library(shiny)

attitude <- tabItem(tabName = "Attitude",
                    fluidRow(
                      box(plotOutput("squirrel_plot1")),
                      box(plotOutput("squirrel_plot2"))
                    ),
                    fluidRow(
                      box(p("When the squirrel observer volunteers were monitoring squirrels, they took note of the squirrel’s general demeanor by assigning it a description. They rated them as indifferent to the observer (indifferent), skittish to the observer when the squirrel would run away (runs from), or curious towards the observer when the squirrel approached the observer (approaches). Based on the 2018 Census Data, the majority of squirrels, 63%, were indifferent when an observer was present, 29% of the squirrels would run from the observer, and only 7% would approach the observer. When squirrels feel threatened, their response is often to escape or run away from the threat, however, in an urban area like Central Park, squirrels may be used to human activity, altering their responses to human activity. This attitude alteration may account for the majority of squirrels indifference to the observer's presence. In the 7% of squirrels that chose to approach the observer, it is possible the squirrel was approaching to ask for food. The 29% who ran from human observers are likely doing so because they perceive them as a threat or because they have a shy attitude."), title = "Attitude Observations", width = 12)
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
