#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(leaflet)
library(mapsapi)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {

    # points <- eventReactive(input$recalc, {
    #     cbind(rnorm(40) * 2 + 13, rnorm(40) + 48)
    # }, ignoreNULL = FALSE)
    
    key <- Sys.getenv('GAPPS_KEY')
    
    doc = mp_directions(
        # origin = c(34.81127, 31.89277),
        origin = c(-104.6189, 50.4452),
        # destination = "Haifa",
        destination = "Beaks Chicken",
        alternatives = FALSE,
        key = key,
        quiet = TRUE
    )
    
    r = mp_get_routes(doc)
    
    pnt <- c(-104.6189, 50.4452)
    point <- t(as.matrix(pnt))
    
    output$mymap <- renderLeaflet({
        leaflet() %>%
            addProviderTiles(providers$Stamen.TonerLite,
                             options = providerTileOptions(noWrap = TRUE)
            ) %>%
            # addMarkers(data = point)
            # addMarkers(lat=50.4452, lng=-104.6189)
            addPolylines(data = r, opacity = 1, weight = 7)
    })

})



# 
# accidents <- data.frame(
#     # id = c(1,2,3,4,5),
#     lat = c(50.447218, 50.446684, 50.447723, 50.447238, 50.449212),
#     long = c(-104.606566, -104.618063, -104.618042, -104.617409, -104.606541)
# )
# kk <- kmeans(accidents, 3)
# 
# 
# 
# centerIcons <- awesomeIcons(
#     icon = 'ios-close',
#     iconColor = 'black',
#     library = 'ion',
#     markerColor = 'red'
# )
# 
# leaflet() %>% 
#     addProviderTiles("CartoDB.DarkMatter") %>%
#     # addPolylines(data = r, opacity = 1, weight = 7, color = ~pal(alternative_id))
#     # addMarkers(data=accidents) %>%
#     # addMarkers(data=as.data.frame(kk$centers), icon = centerIcons)
#     addMarkers(data=accidents, clusterOptions = markerClusterOptions())
