library(shiny)
library(leaflet)

shinyUI(fluidPage(
  titlePanel("5C"),
  sidebarLayout(
    sidebarPanel(
      selectInput("region", "Region:",
                  c("World" = "world",
                    "Africa"= "002", 
                    "Europe"="150",
                    "Americas"="019",
                    "Asia"="142",
                    "Oceania"="009")),
      selectInput("factor", "Factor:",
                  c("Factor 1" = "Factor_1",
                    "Factor 2" = "Factor_2",
                    "Factor 3" = "Factor_3",
                    "Factor 4" = "Factor_4",
                    "Factor 5" = "Factor_5",
                    "Factor 6" = "Factor_6",
                    "Factor 7" = "Factor_7",
                    "Factor 8" = "Factor_8",
                    "Factor 9" = "Factor_9",
                    "Factor 10" = "Factor_10"
                    )),
      selectInput("projection", "Map Projection:",
                  c("mercator", "albers", "lambert","kavrayskiy-vii")),
      tags$head(
        tags$style(type='text/css', ".col-sm-4 { max-width: 270px; }")
      )
    ),
    mainPanel(
      tabsetPanel(
        #tabPanel("Map", leafletOutput("mymap"), icon = icon("globe")),
        tabPanel("Maps", htmlOutput("gvismap"), icon = icon("globe")),
        tabPanel("Dimensions", uiOutput("csel"), uiOutput("dsel"), plotOutput("dims")),
        tabPanel("test", verbatimTextOutput("test"))
      )
    )
  )
)
)
