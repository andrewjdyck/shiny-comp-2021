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
library(dplyr)
library(sf)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
    
    accidents <- readr::read_csv('https://raw.githubusercontent.com/andrewjdyck/sask-bike-collisions/master/data/regina.csv') %>%
        select('lat', 'lon') %>%
        filter(!is.na(lat)) %>%
        rename(long = lon)
    
    key <- Sys.getenv('GAPPS_KEY')
    
    # text_reactive <- eventReactive( input$submit, {
    #     origin = input$routeBegin
    #     destination = input$routeEnd
    #     origin
    # })
    
    output$mymap <- renderLeaflet(
        leaflet() %>%
            addProviderTiles(providers$Stamen.TonerLite,
                             options = providerTileOptions(noWrap = TRUE)
            ) %>%
            setView(lng=-104.6189, lat = 50.4452, zoom = 14) %>%
            addMarkers(data=accidents, clusterOptions = markerClusterOptions())
    )
    
    # respond to the filtered data
    observeEvent( input$submit, {
        
        doc = mp_directions(
            # origin = c(-104.6189, 50.4452),
            origin = input$routeBegin,
            # destination = "Beaks Chicken",
            destination = input$routeEnd,
            alternatives = FALSE,
            mode="bicycling",
            key = key,
            quiet = TRUE
        )
        
        rt = mp_get_routes(doc)
        
        viewCenter <- as.data.frame(st_coordinates(st_centroid(rt)))
        
        leafletProxy(mapId = "mymap")  %>%
            addProviderTiles(providers$Stamen.TonerLite,
                             options = providerTileOptions(noWrap = TRUE)
            ) %>%
            setView(lng=viewCenter$X, lat = viewCenter$Y, zoom = 13) %>%
            addPolylines(data = rt, opacity = 1, weight = 7, layerId = 'bikeroute') %>%
            addMarkers(data=accidents, clusterOptions = markerClusterOptions())

    })

})



# accidents <- readr::read_csv('https://raw.githubusercontent.com/andrewjdyck/sask-bike-collisions/master/data/regina.csv') %>%
#     select('lat', 'lon') %>%
#     filter(!is.na(lat)) %>%
#     rename(long = lon)

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

# viewCenter <- as.data.frame(st_coordinates(st_centroid(r)))
# 
# leaflet() %>%
#     addProviderTiles("CartoDB.DarkMatter") %>%
#     setView(lng=viewCenter$X, lat = viewCenter$Y, zoom = 14) %>%
#     addPolylines(data = r, opacity = 1, weight = 7, color = ~pal(alternative_id)) %>%
#     # addMarkers(data=accidents) %>%
#     # addMarkers(data=as.data.frame(kk$centers), icon = centerIcons)
#     addMarkers(data=accidents, clusterOptions = markerClusterOptions())
#     
