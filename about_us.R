about_us <- tabItem(tabName = "about_us",
                    fluidRow(
                      column(width = 12,
                             h2("About Us"),
                             hr()
                      )
                    ),
                    fluidRow(
                      box(width = 12,
                          fluidRow(
                            column(width = 2,
                                   img(src = "person1.jpg", width = "100%", style = "border-radius: 50%;")
                            ),
                            column(width = 10,
                                   h3("Ava Grace Flory"),
                                   p("Ava Grace Flory is a senior Biology and Environmental Studies double major
                                     who plans to pursue an MD/PhD with a focus on infectious disease. After graduation 
                                     she hopes to work in zoonotic disease research. She finds squirrels interesting because
                                     of the risk of disease transmission from squirrels to humans.")
                            )
                          ),
                          hr(),
                          fluidRow(
                            column(width = 2,
                                   img(src = "person2.jpg", width = "100%", style = "border-radius: 50%;")
                            ),
                            column(width = 10,
                                   h3("Person Two"),
                                   p("Bio for person two.")
                            )
                          ),
                          hr(),
                          fluidRow(
                            column(width = 2,
                                   img(src = "person3.jpg", width = "100%", style = "border-radius: 50%;")
                            ),
                            column(width = 10,
                                   h3("Person Three"),
                                   p("Bio for person three.")
                            )
                          ),
                          hr(),
                          fluidRow(
                            column(width = 2,
                                   img(src = "person4.jpg", width = "100%", style = "border-radius: 50%;")
                            ),
                            column(width = 10,
                                   h3("Person Four"),
                                   p("Bio for person four.")
                            )
                          )
                      )
                    )
)