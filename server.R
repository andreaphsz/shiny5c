library(shiny)
library(googleVis)
library(ggplot2)
library(dplyr)
library(tidyr)
library(viridis)
library(xtable)
#library(plotly)
#library(RColorBrewer)

source("global.R")
source("helptxt.R")

shinyServer(function(input, output, session) {
    sel1 <- c("Importance (5C Dim)", "Achievement (5C Dim)", "Gap (5C Dim)", "Individual Factors", "Country Factors")

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

        col1 <- paste0("{colors:['", paste(gsub("FF","",rev(viridis(500))), collapse="','"), "']}")
        colAx <- ifelse(input$colorsel1 == "default",
                        col1,  "{colors:['#ABABAB','#9FC7F0']}")

        gmap <- gvisGeoChart(data.all, locationvar="COUNTRY",
                     colorvar = facdim,
                     options = list(projection = "mercator",
                                    width = 800, height = 580,
                                    region = input$region,
                                    legend = "{numberFormat:'#.##'}",
                                    colorAxis = colAx,
                                    defaultColor = "#F5F5F5")
                     )

        output$downloadMap <- downloadHandler(
            filename = function() {
                paste('plot_5c_', format(Sys.time(), "%Y%m%d_%H%M%S"), "_",
                      substr(runif(1), 3, 7), '.html', sep='')
            },
            content = function(con) {
                caption <- ""
                footer <- "<span><a href=\"https://github.com/mages/googleVis\">googleVis</a>  &#8226; <a href=\"https://developers.google.com/terms/\">Google Terms of Use</a> &#8226; <a href=\"https://google-developers.appspot.com/chart/interactive/docs/gallery/motionchart\">Documentation and Data Policy</a><br> &#169; by 5C <a href=\"https://5c.careers/\">www.5c.careers</a></span></div></body></html>"
                gmap$html$caption <- caption
                gmap$html$footer <- footer
                gmap$html$caption <- ""
                print(gmap, tag=NULL, file=con)
            }
        )

        return(gmap)

    })

    output$facdimsel1 <- renderUI({
        radioButtons("facdimsel1", "Dimension/Factor", sel1, selected = sel1[1])
    })

    output$dim11 <- renderUI({
        if(is.null(input$facdimsel1)) return(NULL)
        if(input$facdimsel1 == sel1[1]) {
            selectInput("dim11", "", i.list, "fsu_i")
        }
    })
    output$dim21 <- renderUI({
        if(is.null(input$facdimsel1)) return(NULL)
        if(input$facdimsel1 == sel1[2]) {
            selectInput("dim21", "", a.list, "fsu_a")
        }
    })
    output$dim31 <- renderUI({
        if(is.null(input$facdimsel1)) return(NULL)
        if(input$facdimsel1 == sel1[3]) {
            selectInput("dim31", "", gap.list, "fsu_gap")
        }
    })
    output$fac11 <- renderUI({
        if(is.null(input$facdimsel1)) return(NULL)
        if(input$facdimsel1 == sel1[4]) {
            selectInput("fac11", "", ind.list, "WorkSuc")
        }
    })
    output$fac21 <- renderUI({
        if(is.null(input$facdimsel1)) return(NULL)
        if(input$facdimsel1 == sel1[5]) {

            selectInput("fac21", "", cnt.list, "GDP")
        }
    })
    output$hline11 <- renderText({
        HTML("<hr>")
    })
    output$colorsel <- renderUI({
        radioButtons("colorsel1", "Colors", c("default","colorblind-friendly"), selected = "default")
    })

    ## Dimensions Tab ------------------------------------------
    output$country2 <- renderUI({
        selectInput("country2","Countries", data.all$COUNTRY, c("Switzerland", "Austria"), multiple = TRUE)
    })

    output$dim12 <- renderUI({
        selectInput("dim12","Importance", i.list, "fsu_i", multiple = TRUE)
    })
    output$dim22 <- renderUI({
        selectInput("dim22","Achievement", a.list, "fsu_a", multiple = TRUE)
    })
    output$dim32 <- renderUI({
        selectInput("dim32","Gap", gap.list, "fsu_gap", multiple = TRUE)
    })

    output$xaxis  <- renderUI({
        radioButtons("xaxis", "x-Axis", c("Dimension","Country"), selected = "Dimension")
    })

    output$dimplot <- renderPlot({
        if(is.null(input$dim12) & is.null(input$dim22) & is.null(input$dim32)) return(NULL)
        data <- data.all %>%
            filter(COUNTRY %in% input$country2) %>%
            select_("COUNTRY", .dots=c(input$dim12, input$dim22, input$dim32)) %>%
            gather(Dimension, Value, matches("_i|_a|_gap"))

        ## preserve order of dimensions as in the data
        data$Dimension <- factor(data$Dimension, levels=unique(data$Dimension))

        if(input$xaxis=="Dimension") {
            p <- ggplot(data, aes(Dimension, Value, fill=COUNTRY))
            n.col <- length(unique(data$COUNTRY))
        } else {
            p <- ggplot(data, aes(COUNTRY, Value, fill=Dimension))
            n.col <- length(unique(data$Dimension))
        }

        p <- p + geom_col(position="dodge") + theme_bw() #+ scale_fill_hue(l=50)
        p <- p + theme(text = element_text(size=16), axis.text = element_text(size=16),
                       axis.title=element_blank())
        p <- p + scale_fill_manual(values=viridis(n.col))
        print(p)

        output$downloadDim <- downloadHandler(
            filename = function() {
                paste('plot_5c_', format(Sys.time(), "%Y%m%d_%H%M%S"), "_",
                      substr(runif(1), 3, 7), '.png', sep='')
            },
            content = function(con) {
                png(con, height = 2*500, width = 2*930, res = 144)
                lab <- paste0(sprintf('\u00A9'), " by 5C www.5c.careers")
                p <- p + annotate("text", x = Inf, y = min(p$data$Value), hjust=1.1, vjust=1.8, label = lab,
                                  color="grey50")
                print(p)
                dev.off()
            }
        )
    }, height = 500, width = 930)

    ## Dim x Fac Tab ------------------------------------------
    output$cntorclus3  <- renderUI({
        radioButtons("cntorclus3", "Clusters/Countries", c("Clusters", "Countries"),
                     selected = "Clusters", inline = TRUE)
    })

    output$clus3 <- renderUI({
        if(is.null(input$cntorclus3)) return(NULL)

        if (input$cntorclus3 == "Clusters") {
            all <- unique(data.all$CLUSTER)
            if(is.null(input$cnt3)) {
                selected <- all
            } else {
                selected <- data.all %>%
                    filter(COUNTRY %in% input$cnt3) %>%
                    select(CLUSTER)
                selected  <- do.call(c, selected)
            }
            selectInput("clus3","", all, selected, multiple = TRUE)
        }
    })

  output$cnt3 <- renderUI({
    if(is.null(input$cntorclus3)) return(NULL)

    if (input$cntorclus3 == "Countries") {
      selected <- data.all %>%
        filter(CLUSTER %in% input$clus3) %>%
        select(COUNTRY)
      selected  <- do.call(c, selected)
      selectInput("cnt3","", data.all$COUNTRY, selected, multiple = TRUE)
    }
  })

    output$hline13 <- renderText({
        HTML("<hr>")
    })

    output$xsel3 <- renderUI({
        radioButtons("xsel3", "x-Axis", sel1, selected = sel1[1])
    })

    output$x3 <- renderUI({
        if(is.null(input$xsel3)) return(NULL)
        idx <- which(input$xsel3 == sel1)
        selectInput("x3", "", all.list[[idx]], all.list[[idx]][1])
    })

    output$hline23 <- renderText({
        HTML("<hr>")
    })

    output$ysel3 <- renderUI({
        radioButtons("ysel3", "y-Axis", sel1, selected = sel1[2])
    })

    output$y3 <- renderUI({
        if(is.null(input$ysel3)) return(NULL)
        idx <- which(input$ysel3 == sel1)
        selectInput("y3", "", all.list[[idx]], all.list[[idx]][1])
    })

    output$hline33 <- renderText({
        HTML("<hr>")
    })

    output$zsel3 <- renderUI({
        radioButtons("zsel3", "Size", c("(none)", sel1), selected = "(none)")
    })

    output$z3 <- renderUI({
        if(is.null(input$zsel3)) return(NULL)
        if(input$zsel3 == "(none)") return(NULL)
        idx <- which(input$zsel3 == sel1)
        selectInput("z3", "", all.list[[idx]], all.list[[idx]][1])
    })

    output$dimxfac <- renderPlot({
        if(input$cntorclus3 == "Clusters") {
            data <- data.all %>%
                filter(CLUSTER %in% input$clus3)
        } else {
            data <- data.all %>%
                filter(COUNTRY %in% input$cnt3)
        }

        x <- input$x3
        if(is.null(x)) return(NULL)

        y <- input$y3
        if(is.null(y)) return(NULL)

        z <- input$z3
        #if(is.null(z)) return(NULL)

        if(input$zsel3 != "(none)") {
            p <- ggplot(data, aes_string(x, y, size=z, color="CLUSTER"))
            p <- p + geom_point()
        }else{
            p <- ggplot(data, aes_string(x, y, color="CLUSTER"))
            p <- p + geom_point(size=3)
        }
        p <- p + scale_color_viridis(discrete=TRUE) + theme_bw()
        p <- p + theme(text = element_text(size=16), axis.text = element_text(size=16))


        output$downloadDimFac <- downloadHandler(
            filename = function() {
                paste('plot_5c_', format(Sys.time(), "%Y%m%d_%H%M%S"), "_",
                      substr(runif(1), 3, 7), '.png', sep='')
            },
            content = function(con) {
                png(con,  width = 2*640,  height = 2*500, res = 144)
                lab <- paste0(sprintf('\u00A9'), " by 5C www.5c.careers")
                p <- p + annotate("text", x = Inf, y =  min(p$data[,y], na.rm=TRUE), hjust=1.1, vjust=1.8, label = lab,
                                  color="grey50")
                print(p)
                dev.off()
            }
        )
        ## see http://stackoverflow.com/questions/35570553/nearpoints-not-able-to-automatically-infer-xvar-from-shiny-coordinfo#35571730
        return(p)
    }, width = 640, height = 500)

    ## Help Tab ------------------------------------------
    output$help <- renderUI({
        HTML('
    <ul class="nav nav-pills nav-stacked" data-tabsetid="9999">
      <li class="navbar-brand">Help <i class="fa fa-question" aria-hidden="true"></i></li>
      <li class="active">
        <a href="#tab-9999-1" data-toggle="tab" data-value="map">Map <i class="fa fa-globe" aria-hidden="true"></i></a>
      </li>
      <li>
        <a href="#tab-9999-2" data-toggle="tab" data-value="success">Success Factors <i class="fa fa-bar-chart" aria-hidden="true"></i></a>
      </li>
      <li>
        <a href="#tab-9999-3" data-toggle="tab" data-value="multi">Multidimensional Views <i class="fa fa-line-chart" aria-hidden="true"></i></a>
      </li>
      <li>
        <a href="#tab-9999-4" data-toggle="tab" data-value="infotab">Variables</a>
      </li>
    </ul>
 ')
    })

    output$helptext <- renderUI({
        HTML(help.html)
    })

    ## About Tab ------------------------------------------
    output$about <- renderUI({
        HTML('
    <ul class="nav nav-pills nav-stacked" data-tabsetid="9998">
      <li class="navbar-brand">About <i class="fa fa-info" aria-hidden="true"></i></li>
      <li class="active">
        <a href="#tab-9998-1" data-toggle="tab" data-value="aboutus">About us</a>
      </li>
      <li>
        <a href="#tab-9998-2" data-toggle="tab" data-value="techdet">Technical details</a>
      </li>
    </ul>
 ')
    })

    output$abouttext <- renderUI({
        HTML(about.html)
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
    point <- data.frame(point)
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
    size <- ifelse(input$zsel3=="(none)", "(none)", round(point[, input$z3],2))
    wellPanel(style = style, HTML(paste0("<b>", point$COUNTRY,"</b>", "<br>",
                                         "x: ", round(point[, input$x3],2), "<br>",
                                         "y: ", round(point[, input$y3],2), "<br>",
                                         "Size: ", size))
    )
  })

})

