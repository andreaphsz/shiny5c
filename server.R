library(shiny)
library(googleVis)
library(ggplot2)
library(dplyr)
library(tidyr)

source("global.R")

shinyServer(function(input, output, session) {
   
  output$gvismap <- renderGvis({
    gvisGeoChart(data.all, locationvar="Country_Name", 
                 colorvar = input$facdim1,
                 options = list(projection = input$projection,
                              width = 900, height = 500,
                              region = input$region))
  })

  output$country2 <- renderUI({
    selectInput("country2","Countries", data.all$Country_Name, "Switzerland", multiple = TRUE)
  })

  output$dim2 <- renderUI({
    selectInput("dim2","Dimensions", paste0("Dimension_",1:7), paste0("Dimension_",1:3), multiple = TRUE)
  })
  
  output$dimplot <- renderPlot({
    if(!is.null(input$dim2)) {
      data <- data.all %>% 
        filter(Country_Name %in% input$country2) %>%
        select_("Country_Name", .dots=input$dim2) %>%
        gather(Dimension, Value, contains("Dimension"))
    
      p <- ggplot(data, aes(Dimension, Value, fill=Country_Name))
      p + geom_col(position="dodge") + theme_bw()
    }
  })
  
  output$dim3 <- renderUI({
    selectInput("dim3","Dimension", paste0("Dimension_",1:7), "Dimension_1")
  })

  output$fac3 <- renderUI({
    selectInput("fac3","Factor", paste0("Factor_",1:10), "Factor_1")
  })
  
  output$size3 <- renderUI({
    selectInput("size3","Size", paste0("Factor_",1:10), "Factor_2")
  })
  
  output$dimxfac <- renderPlot({
    #data <- data.all %>%
    #  select_(.dots=c(input$dim3, input$fac3))
    
    p <- ggplot(data.all, aes_string(input$dim3, input$fac3, size=input$size3))
    p + geom_point() + theme_bw()
  })
  
  output$country99 <- renderUI({
    selectInput("country99","Countries", data.all$Country_Name, "Switzerland", multiple = TRUE)
  })

  output$dim99 <- renderUI({
    selectInput("dim99","Dimensions", paste0("Dimension_",1:7), paste0("Dimension_",1:3), multiple = TRUE)
  })
  
  output$testplot <- renderGvis({
    data <- data.all %>%
      filter(Country_Name %in% input$country99)
    
    gvisColumnChart(data, xvar="Country_Name", yvar=input$dim99)
  })
  
  ## see https://gitlab.com/snippets/16220
  output$hover_info <- renderUI({     
    hover <- input$plot_hover     
    point <- nearPoints(data.all, hover, threshold = 5, maxpoints = 1, addDist = TRUE)     
    if (nrow(point) == 0) return(NULL)         
    ## calculate point position INSIDE the image as percent of total dimensions     
    ## from left (horizontal) and from top (vertical)     
    left_pct <- (hover$x - hover$domain$left) / (hover$domain$right - hover$domain$left)     
    top_pct <- (hover$domain$top - hover$y) / (hover$domain$top - hover$domain$bottom)         
    ## calculate distance from left and bottom side of the picture in pixels     
    left_px <- hover$range$left + left_pct * (hover$range$right - hover$range$left)     
    top_px <- hover$range$top + top_pct * (hover$range$bottom - hover$range$top)         
    ## create style property fot tooltip     
    ## background color is set so tooltip is a bit transparent     
    ## z-index is set so we are sure are tooltip will be on top     
    style <- paste0("position:absolute; z-index:100; background-color: rgba(245, 245, 245, 0.85);",                     "left:", left_px + 2, "px; top:", top_px + 2, "px;")         
    ## actual tooltip created as wellPanel     
    wellPanel(style = style, HTML(paste0(point$Country_Name, "<br>",
                                         "Dim: ", round(point[,input$dim3],2), "<br>",
                                         "Fac: ", round(point[,input$fac3],2), "<br>",
                                         "Size: ", round(point[,input$size3],2)))
    )   
  })
  
})

