# This is the user-interface definition of a Shiny web application----
library(shiny)
library(leaflet) #For maps creation

#List of choises----
list_of_process<- list("Comparación Climática entre Centros de Investigación" = "comparation",
                       "Visualizador Variables Climáticas en un Centro de Investigación"= "visualization")
list_of_variables<- list("Temperatura (°C)"="Temperatura (°C)", "Máxima temperatura (°C)"= "Máxima temperatura (°C)",
                         "Mínima temperatura (°C)"= "Mínima temperatura (°C)", "Humedad relativa (%)"="Humedad relativa (%)", 
                         "LLuvia (mm)"="LLuvia (mm)")
list_of_dates<- list("start"= as.Date("2011-01-01"), "end"= as.Date("2011-01-01"))
list_of_time_lapse<- list("Cada Hora" = "hour","Diario" = "day", "Semanal"="week", "Mensual" = "month",
                          "Bimestral"="bimonth", "Trimestral" ="quarter", "Semestral" = "halfyear", 
                          "Anual"= "year")
list_of_research_centers<- list("Caribia"="caribia", "Nataima"= "nataima", "Palmira"= "palmira", 
                                "Tibiatatá"="tibaitata", "a"="a", "b"="b", "e"="e","f"="f")


#input-->process, variables, date_range, frequency, research_center, upload_inf, downloadPlot, downloadData

# Define UI----

shinyUI(fluidPage(
    navbarPage(title = "SAVIA WEATHER APP",
               #General information----
               tabPanel("Centros de Investigación", icon =icon("map-marker"),
                        #Map of Colombia with the research Center---
                        leafletOutput("research_Centers_Map")),
               #Process----
               tabPanel("Datos Climáticos", icon = icon ("signal"),
                        sidebarPanel(
                            #Heather----
                            HTML("<h3>Criterios de filtro</h3>"),
                            #Select one process----
                            selectInput("process", label= "Proceso a realizar", choices = list_of_process),
                            #Select up to three climatic variables----
                            selectizeInput("variables", label = "Variables Climáticas",choices = list_of_variables, 
                                           multiple = TRUE,  options = list(maxItems = 3)),
                            #Date Range----
                            dateRangeInput("date_range", label = "Tiempo a visualizar", start = list_of_dates$start, end = list_of_dates$end),
                            #Time lapse----
                            selectInput("frequency", label = "Espacio de Tiempo:", 
                                        choices = list_of_time_lapse, selected = "Cada Hora"),
                            #Various research centers if process=comparation (max 4)----
                            conditionalPanel(condition = "input.process == 'comparation'",
                                             selectizeInput("research_center", label = "Centro de Investigación (máximo 4)", 
                                                            choices = list_of_research_centers, multiple = TRUE,  options = list(maxItems = 4))
                            ),
                            #One research center if process= visualization----
                            conditionalPanel(condition = "input.process == 'visualization'",
                                             selectInput("research_center", label= "Centro de Investigación", choices = list_of_research_centers)
                            ),
                            #Button for download data----
                            actionButton(inputId = "upload_inf", "Cargar Datos", icon = icon("cloud-download")),
                            #Download plot----
                            downloadLink('downloadPlot', 'Descargar Gráfica'),
                            #Download table----
                            downloadLink('downloadData', 'Descargar Tabla')),
                        #----
               )
    )
)
)
