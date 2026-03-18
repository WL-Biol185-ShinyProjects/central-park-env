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
                      ),
                          
                    box(
                      p("On this site you will find a variety of data concerning eastern grey squirrels from observations of their behavior, where they are and what the weather was like at the time of their sighting. This site then takes that data a step further bringing different elements together to tell a full story for squirrels in central park."), title = "What to Expect", width = 6
                    )
                  ),
                  
                  fluidRow(
                    box(
                      p("It is expected that over 2000 Eastern grey squirrels call central park home. Since their introduction to the park in the 1870’s they have become  treasured icons among the park's residents. These city squirrels are primarily grey with some variations being black and cinnamon which will be reflected in the data. While park visitors are now discouraged from feeding the squirrels they remain fairly comfortable around them allowing for excellent observation with in the park."), title = "Central Park Squirrels", width = 6
                    )
                  ),
                     
                          
                          )
)


