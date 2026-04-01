library(shiny)

sidebar <- dashboardSidebar(title = "",
                sidebarMenu(
                      menuItem("Meet the Squirrels", tabName = "meet_the_squirrels", icon = icon("tree")),
                      menuItem("Where Are They", tabName = "where_are_they", icon = icon("map")),
                      menuItem("What Are They Doing", icon = icon("walking"),
                          menuSubItem("Attitude", tabName = "Attitude"),
                          menuSubItem("Activity", tabName = "Activity"),
                          menuSubItem("Tail Behavior", tabName = "Tail_Behavior"),
                          menuSubItem("Noise", tabName = "Noise")
                          ),
                      menuItem("Park Conditions", tabName = "park_conditions", icon = icon("cloud")),
                      menuItem("Squirrel Name Generator", tabName = "squirrel_name_generator", icon = icon("paw")),
                      menuItem("About Us", tabName = "about_us", icon = icon("info-circle"))
                          )
)



