# global.R
library(shiny)
library(shinydashboard)
library(dplyr)
library(ggplot2)
library(plotly)
library(readxl)
library(shinyWidgets)

# Import utils.R 
source("utils.R")

# Import ui.R and server.R
source("ui.R")
source("server.R")

# Run the application
shinyApp(ui = ui, server = server)