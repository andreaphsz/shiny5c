library(shiny)
library(googleVis)
library(ggplot2)
library(dplyr)
library(tidyr)
#library(plotly)
#library(RColorBrewer)

source("global.R")

shinyServer(function(input, output, session) {
    sel1 <- c("Importance (5C Dim)", "Achievement (5C Dim)", "Gap (5C Dim)", "Individual Factors", "Country Factors")
    cfacs <- c("Gini_Country_Factor_1", "GDP_Country_Factor_2", paste0("Country_Factor_", 3:10))
    ## Map Tab ------------------------------------------
    output$gvismap <- renderGvis({
        if(is.null(input$facdimsel1)) return(NULL)
        
        facdim <- switch(input$facdimsel1,
                         "Importance (5C Dim)" = input$dim11,
                         "Achievement (5C Dim)" = input$dim21,
                         "Gap (5C Dim)" = input$dim31,
                         "Individual Factors" =  input$fac11,
                         "Country Factors" = input$fac21
                         )
        
        if(is.null(facdim)) return(NULL)
        
        gvisGeoChart(data.all, locationvar="Country_Name", 
                     colorvar = facdim,
                     options = list(projection = "mercator",
                                    width = 800, height = 580,
                                    region = input$region,
                                    colorAxis = "{colors:['#ABABAB','#9FC7F0']}",
                                    legend = "{numberFormat:'#.##'}")
                     )
    })

    output$facdimsel1 <- renderUI({    
        radioButtons("facdimsel1", "Dimension/Factor", sel1, selected = sel1[1])
    })

    output$dim11 <- renderUI({
        if(is.null(input$facdimsel1)) return(NULL)
        if(input$facdimsel1 == sel1[1]) {
            selectInput("dim11", "", paste0("Importance_", 1:7), "Importance_1")
        }
    })
    output$dim21 <- renderUI({
        if(is.null(input$facdimsel1)) return(NULL)
        if(input$facdimsel1 == sel1[2]) {
            selectInput("dim21", "", paste0("Achievement_", 1:7), "Achievement_1")
        }
    })
    output$dim31 <- renderUI({
        if(is.null(input$facdimsel1)) return(NULL)
        if(input$facdimsel1 == sel1[3]) {
            selectInput("dim31", "", paste0("Gap_", 1:7), "Gap_1")
        }
    })
    output$fac11 <- renderUI({
        if(is.null(input$facdimsel1)) return(NULL)
        if(input$facdimsel1 == sel1[4]) {
            selectInput("fac11", "", paste0("Individual_Factor_", 1:12), "Individual_Factor_1")
        }
    })
    output$fac21 <- renderUI({
        if(is.null(input$facdimsel1)) return(NULL)
        if(input$facdimsel1 == sel1[5]) {
            
            selectInput("fac21", "", cfacs, cfacs[1])
        }
    })
    ## Dimensions Tab ------------------------------------------
    output$country2 <- renderUI({
        selectInput("country2","Countries", data.all$Country_Name, "Switzerland", multiple = TRUE)
    })
    
    output$dim12 <- renderUI({
        selectInput("dim12","Importance", paste0("Importance_",1:7), "Importance_1", multiple = TRUE)
    })
    output$dim22 <- renderUI({
        selectInput("dim22","Achievement", paste0("Achievement_",1:7), "Achievement_1", multiple = TRUE)
    })
    output$dim32 <- renderUI({
        selectInput("dim32","Gap", paste0("Gap_",1:7), "Gap_1", multiple = TRUE)
    })
  
    output$xaxis  <- renderUI({
        radioButtons("xaxis", "x-Axis", c("Dimension","Country"), selected = "Dimension")
    })
  
    output$dimplot <- renderPlot({
        if(is.null(input$dim12) & is.null(input$dim22) & is.null(input$dim32)) return(NULL)
        data <- data.all %>% 
            filter(Country_Name %in% input$country2) %>%
            select_("Country_Name", .dots=c(input$dim12, input$dim22, input$dim32)) %>%
            gather(Dimension, Value, matches("Importance|Achievement|Gap"))
        
        if(input$xaxis=="Dimension") {
            p <- ggplot(data, aes(Dimension, Value, fill=Country_Name))
        } else {
            p <- ggplot(data, aes(Country_Name, Value, fill=Dimension))
        }
        
        p <- p + geom_col(position="dodge") + theme_bw() + scale_fill_hue(l=50)
        p + theme(text = element_text(size=16), axis.text = element_text(size=16), axis.title=element_blank())
    
  })

    ## Dimensions Tab ------------------------------------------
    output$cntorclus3  <- renderUI({
        radioButtons("cntorclus3", "Clusters/Countries", c("Clusters", "Countries"), selected = "Clusters", inline = TRUE)
    })
  
    output$clus3 <- renderUI({
        if(is.null(input$cntorclus3)) return(NULL)
        
        if (input$cntorclus3 == "Clusters") {
            all <- unique(data.all$Country_Cluster)
            if(is.null(input$cnt3)) {
                selected <- all
            } else {
                selected <- data.all %>%
                    filter(Country_Name %in% input$cnt3) %>%
                    select(Country_Cluster)
                selected  <- do.call(c, selected)
            }
            selectInput("clus3","", all, selected, multiple = TRUE)
        }
    })

  #output$test <- renderPrint({
  #  input$cnt3
  #})
  
  output$cnt3 <- renderUI({
    if(is.null(input$cntorclus3)) return(NULL)
    
    if (input$cntorclus3 == "Countries") {
      selected <- data.all %>%
        filter(Country_Cluster %in% input$clus3) %>%
        select(Country_Name)
      selected  <- do.call(c, selected)
      selectInput("cnt3","", data.all$Country_Name, selected, multiple = TRUE)
    }
  })

    output$hline13 <- renderText({
        HTML("<hr>")
    })

    output$dimsel3 <- renderUI({
        sel3 <<- c("Importance (5C Dim)", "Achievement (5C Dim)", "Gap (5C Dim)")
        radioButtons("dimsel3", "x-Axis", sel3, selected = sel3[1])
    })
    
    output$dim13 <- renderUI({
        if(is.null(input$dimsel3)) return(NULL)
        if(input$dimsel3 == sel3[1]) {
            selectInput("dim13", "", paste0("Importance_",1:7), "Importance_1")
        }
    })
    output$dim23 <- renderUI({
        if(is.null(input$dimsel3)) return(NULL)
        if(input$dimsel3 == sel3[2]) {
            selectInput("dim23", "", paste0("Achievement_",1:7), "Achievement_1")
        }
    })
    output$dim33 <- renderUI({
        if(is.null(input$dimsel3)) return(NULL)
        if(input$dimsel3 == sel3[3]) {
            selectInput("dim33", "", paste0("Gap_",1:7), "Gap_1")
        }
    })

    output$hline23 <- renderText({
        HTML("<hr>")
    })

    output$facsel3 <- renderUI({
        fsel3 <<- c("Individual Factors", "Country Factors")
        radioButtons("facsel3", "y-Axis", fsel3, selected = fsel3[1])
    })

    output$fac13 <- renderUI({
        if(is.null(input$facsel3)) return(NULL)
        if(input$facsel3 == fsel3[1]) {
            selectInput("fac13", "", paste0("Individual_Factor_",1:12), "Individual_Factor_1")
        }
    })
    output$fac23 <- renderUI({
        if(is.null(input$facsel3)) return(NULL)
        if(input$facsel3 == fsel3[2]) {
            selectInput("fac23", "", cfacs, cfacs[1])
        }
    })

    output$hline33 <- renderText({
        HTML("<hr>")
    })

    output$size3 <- renderUI({
        selectInput("size3","Size", c("(none)", cfacs), "(none)")
    })
  
    output$dimxfac <- renderPlot({
        if(input$cntorclus3 == "Clusters") {
            data <- data.all %>%
                filter(Country_Cluster %in% input$clus3)
        } else {
            data <- data.all %>%
                filter(Country_Name %in% input$cnt3)
        }

        if(is.null(input$dimsel3)) return(NULL)    
        xdim <<- switch(input$dimsel3,
                         "Importance (5C Dim)" = input$dim13,
                         "Achievement (5C Dim)" = input$dim23,
                         "Gap (5C Dim)" = input$dim33
                      )
        if(is.null(xdim)) return(NULL)

        if(is.null(input$facsel3)) return(NULL)    
        yfac <<- switch(input$facsel3,
                      "Individual Factors" =  input$fac13,
                      "Country Factors" = input$fac23
                      )
        if(is.null(yfac)) return(NULL)

        
        if(input$size3 != "(none)") {
            p <- ggplot(data, aes_string(xdim, yfac, size=input$size3, color="Country_Cluster"))
            p <- p + geom_point() 
        }else{
            p <- ggplot(data, aes_string(xdim, yfac, color="Country_Cluster"))
            p <- p + geom_point(size=3)
        }
        p <- p + theme_bw() 
        p <- p + theme(text = element_text(size=16), axis.text = element_text(size=16))
        p
    })
  
#  output$country99 <- renderUI({
#    selectInput("country99","Countries", data.all$Country_Name, "Switzerland", multiple = TRUE)
#  })

#  output$dim99 <- renderUI({
#    selectInput("dim99","Dimensions", paste0("Dimension_",1:7), paste0("Dimension_",1:3), multiple = TRUE)
#  })
  
#  output$testplot <- renderGvis({
#    data <- data.all %>%
#      filter(Country_Name %in% input$country99)
#    gvisColumnChart(data, xvar="Country_Name", yvar=input$dim99)
#  })
  
#  output$testplot2 <- renderPlotly({
    #pdf(NULL) # http://stackoverflow.com/questions/36777416/plotly-plot-not-rendering-on-shiny-server
    ## https://github.com/ropensci/plotly/issues/494
    #if (names(dev.cur()) != "null device") dev.off()
    #pdf(NULL)
#    if(!is.null(input$dim2)) {
#      data <- data.all %>% 
#        filter(Country_Name %in% input$country2) %>%
#        select_("Country_Name", .dots=input$dim2) %>%
#        gather(Dimension, Value, contains("Dimension"))
      
#      p <- ggplot(data, aes(Dimension, Value, fill=Country_Name))
#      p <- p + geom_col(position="dodge") + theme_bw()
      
#      ggplotly(p)
#    }
#  })
  
  
  
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
    size <- ifelse(input$size3=="(none)", "(none)", round(point[,input$size3],2))
    wellPanel(style = style, HTML(paste0("<b>",point$Country_Name,"</b>", "<br>",
                                         "Dim: ", round(point[, xdim],2), "<br>",
                                         "Fac: ", round(point[, yfac],2), "<br>",
                                         "Size: ", size))
    )   
  })
  
})

