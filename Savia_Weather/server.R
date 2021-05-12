# This is the server logic
#Libraries---- 
library(shiny)
library(leaflet) #For maps creation
library(readr) #For github download

#definition of important URLs---- 
research_center_coordinates_URL<- url("https://raw.githubusercontent.com/jrobledob/Savia_Weather_WEB/main/data/Research_center_information_map.csv")


shinyServer(function(input, output) {
    
    #Map with a pin whit information of every research center----
    output$research_Centers_Map <-renderLeaflet({
        #definition of information----
        research_center_coordinates<- read_csv2(research_center_coordinates_URL, locale(encoding = "UTF-8"),col_names = TRUE,col_types = NULL)
        #research_center_coordinates----
        map <- leaflet(data= research_center_coordinates) %>% 
            addTiles()  %>% 
            setView(lng = -72.930136, lat = 4.115672,
                    zoom = 5) %>%
            addMarkers(~long, ~lat, popup = ~as.character(popup), label = ~as.character(label))
    })
})
