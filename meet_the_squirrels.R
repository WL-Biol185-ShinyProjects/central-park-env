library(shiny)

meet_the_squirrels <- tabItem(tabName = "meet_the_squirrels",
                              #insert code here

                  fluidRow(
                    box(
                      width = 12,
                      div(
                        style = "width: 100%; height: 400px; overflow: hidden;",
                        tags$img(
                          src = "https://media.istockphoto.com/id/1667398983/photo/squirrel-in-central-park-new-york-city.jpg?s=612x612&w=0&k=20&c=uz0a7GzAq5CbfBlEQcAelOqtRig0pHmrpUBsWHTifRE=",
                          style = "width: 100%; height: 100%; object-fit: contain;"
                        )
                      )
                    ),
                  fluidRow(
                    box(
                      p("This app focuses on an open access data set compiled by the 2018 squirrel census available through NYC open data.  This data set was collected through 323 volunteer squirrel sighters in October of 2018 and findings regarding the population size of a particular grey squirrel species (sciurus carolinensis) within Central Park. However, there is so much more to the Central Park squirrel community than just the number of eastern grey squirrels present, and it is those dynamics that you can see here!"), title = "About the Squirrels", width = 12
                      )
                          )
                       
                          
                          )
)


