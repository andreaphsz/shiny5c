library(shiny)
library(leaflet)
library(googleVis)
library(ggplot2)
library(dplyr)
library(tidyr)

source("global.R")

shinyServer(function(input, output, session) {
  
  output$mymap <- renderLeaflet({
    leaflet() %>%
      addProviderTiles("Stamen.TonerLite",
                       options = providerTileOptions(noWrap = TRUE)
      ) %>%
      setView( 9.838323, 46.497777, 2)
    #addTiles() 
    #addMarkers(data = points())
  })
  
  #proj <- c("mercator", "albers", "lambert","kavrayskiy-vii")
  
  output$gvismap <- renderGvis({
    gvisGeoChart(data.all, locationvar="Country_Name", 
                 colorvar = input$factor,
                 options = list(projection = input$projection,
                              width = 900, height = 500,
                              region = input$region, gvis.editor="test"))
  })

#  output$regionsel <- renderUI({
#    region <- c("World" = "world",
#      "Africa"= "002", 
#      "Europe"="150",
#      "Americas"="019",
#      "Asia"="142",
#      "Oceania"="009")
#    selectInput("regionsel","Region", region, "world")
#  })
  
  output$csel <- renderUI({
    selectInput("csel","Select countries", data.all$Country_Name, "Switzerland", multiple = TRUE)
  })

  output$dsel <- renderUI({
    selectInput("dsel","Select Dimension", paste0("Dimension_",1:7), "Dimension_1", multiple = TRUE)
  })
  
  output$dims <- renderPlot({
    if(!is.null(input$dsel)) {
      data <- data.all %>% 
        filter(Country_Name %in% input$csel) %>%
        select_("Country_Name", .dots=input$dsel) %>%
        gather(Dimension, Value, contains("Dimension"))
    
      p <- ggplot(data, aes(Dimension, Value, fill=Country_Name))
      p + geom_col(position="dodge")
    }
  })
  
  output$test <- renderPrint({
    input$dsel
  })
})
