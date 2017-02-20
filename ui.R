library(shiny)
library(leaflet)

regions <- c("World" = "world",
             "Africa"= "002", 
             "Europe"="150",
             "Americas"="019",
             "Asia"="142",
             "Oceania"="009")

factors <- c("Factor 1" = "Factor_1",
             "Factor 2" = "Factor_2",
             "Factor 3" = "Factor_3",
             "Factor 4" = "Factor_4",
             "Factor 5" = "Factor_5",
             "Factor 6" = "Factor_6",
             "Factor 7" = "Factor_7",
             "Factor 8" = "Factor_8",
             "Factor 9" = "Factor_9",
             "Factor 10" = "Factor_10")

projections <- c("mercator", "albers", "lambert","kavrayskiy-vii")
  
shinyUI(fluidPage(
  titlePanel("5C"),
  sidebarLayout(
    sidebarPanel(
      tags$head(
        tags$style(type='text/css', ".col-sm-4 { max-width: 270px; }")
      ),
      conditionalPanel(condition="input.conditionedPanels==1",
        selectInput("region", "Region:", regions),
        selectInput("factor", "Factor:", factors),
        selectInput("projection", "Map Projection:", projections)
      ),
      conditionalPanel(condition="input.conditionedPanels==2",
        uiOutput("csel"), 
        uiOutput("dsel")
      )
    ),
    mainPanel(
      tabsetPanel(
        tabPanel("Maps", htmlOutput("gvismap"), icon = icon("globe"), value=1),
        tabPanel("Dimensions",  plotOutput("dims"), value=2),
        tabPanel("test", verbatimTextOutput("test")),
        id = "conditionedPanels"
      )
    )
  )
)
)
