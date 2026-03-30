library(shinydashboard)
library(shiny)
library(leaflet)
library(tidyverse)
source("sidebar.R")
source("meet_the_squirrels.R")
source("where_are_they.R")
source("what_are_they_doing.R")
source("park_conditions.R")
source("about_us.R")

custom_css <- tags$style(HTML("
  .skin-green .main-sidebar { background-color: #A0522D !important; }
  .skin-green .main-sidebar .sidebar-menu > li > a { color: #FFF8DC !important; }
  .skin-green .main-sidebar .sidebar-menu > li.active > a { 
      background-color: #CD853F !important; color: white !important; }
  .skin-green .main-header .navbar { background-color: #CD853F !important; }
  .skin-green .main-header .logo { 
      background-color: #A0522D !important; color: #FFF8DC !important; 
      font-weight: bold !important; }
  .box { border-top: 3px solid #CD853F !important; border-radius: 6px !important; }
  .box-header { background-color: #A0522D !important; color: white !important; }
  .box-title { color: white !important; font-weight: bold !important; font-size: 16px !important; }
  p { font-size: 15px; line-height: 1.8; color: #5C3317; }
  h2 { color: #A0522D; font-weight: bold; margin-bottom: 15px; }
  h3 { color: #A0522D; font-weight: bold; }
  h4 { color: #A0522D; font-weight: bold; }
  h5 { color: #A0522D; font-weight: bold; }
  audio { width: 100%; margin-top: 8px; }
  .content-wrapper { background-color: #fdf8f4 !important; }
  .content { padding: 20px; }
"))

dashboardPage(skin = "green",
              dashboardHeader(title = "Squirrel Exploration"),
              dashboardSidebar(sidebar),
              dashboardBody(
                custom_css,
                tabItems(
                  meet_the_squirrels,
                  where_are_they,
                  attitude,
                  activity,
                  tail_behavior,
                  noise,
                  park_conditions,
                  about_us
                )
              )
)