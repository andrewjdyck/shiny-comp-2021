#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(leaflet)
library(bslib)

# Define UI for application that draws a histogram
shinyUI(fluidPage(

    theme = bs_theme(version = 4, bootswatch = "minty"),
    
    # Application title
    titlePanel("Find a safe bicycle route in Regina, SK, Canada"),
    
    sidebarLayout(
        sidebarPanel(
            textInput("routeBegin", label="Trip start", value="City Hall, Regina, SK"),
            textInput("routeEnd", label="Trip endpoint", value="Beaks Chicken"),
            actionButton("submit", label = "Map your route!"),
            tags$br(),
            p("Bicycling in a city can be dangerous at the best of times. This app helps you identify how safe your bicycle trip will be in Regina, SK, Canada by showing where your route might intersect with locations where previous bicycle-automobile accidents have occurred."),
            p("Some examples of routes you may want to try are:"),
            tags$ul(
                tags$li("Wascana Lake to Mosaic Stadium"),
                tags$li("Sandra Schmirler Leisure Centre to Regina City Hall")
            )
        ),
        mainPanel(
            leafletOutput("mymap")
        )
    ),
    HTML("<br />"),
    fluidRow(
        style="float: right;",
        p(HTML(paste("Made with love by ", a(href="http://github.com/andrewjdyck", "github.com/andrewjdyck"))))
    )

))
