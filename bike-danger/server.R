#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {

    # points <- eventReactive(input$recalc, {
    #     cbind(rnorm(40) * 2 + 13, rnorm(40) + 48)
    # }, ignoreNULL = FALSE)
    
    point <- t(as.matrix(c(-104.6189, 50.4452)))
    
    output$mymap <- renderLeaflet({
        leaflet() %>%
            # addTiles() %>%
            addProviderTiles(providers$Stamen.TonerLite,
                             options = providerTileOptions(noWrap = TRUE)
            ) %>%
            addMarkers(data = point)
            # addMarkers(lat=50.4452, lng=-104.6189)
    })

})
