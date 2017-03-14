library(shiny)

regions <- c("World" = "world",
             "Africa"= "002", 
             "Europe"="150",
             "Americas"="019",
             "Asia"="142",
             "Oceania"="009")

factors <- paste0("Factor_", 1:10)

dimensions <- paste0("Dimension_", 1:7)

projections <- c("mercator", "albers", "lambert","kavrayskiy-vii")
  
shinyUI(fluidPage(
  titlePanel("5C Visualisations"),
  sidebarLayout(
    sidebarPanel(
      tags$head(
        tags$style(type='text/css', ".col-sm-4 { max-width: 270px; margin-top: 41px;}"),
        tags$style(type='text/css', ".well { background-color: #fafafa; }"),
        tags$style(type='text/css', ".multi  { border-color: #aaa; }"),
        tags$style(type='text/css', ".single { border-color: #aaa; }"),
        tags$style(type='text/css', "h2 { color:red; font-size:0px; background-size: 100px auto;
                   background-image: url(5clogo.jpg); background-repeat: no-repeat;margin: auto; height:75px;}")
      ),
      conditionalPanel(condition="input.conditionedPanels==1",
        selectInput("region", "Region", regions),
        uiOutput("facdimsel1"),
        uiOutput("dim11"),
        uiOutput("dim21"),
        uiOutput("dim31"),
        uiOutput("fac11"),
        uiOutput("fac21")
      ),
      conditionalPanel(condition="input.conditionedPanels==2",
        uiOutput("country2"), 
        uiOutput("dim12"),
        uiOutput("dim22"),
        uiOutput("dim32"),
        uiOutput("xaxis")
      ),
      conditionalPanel(condition="input.conditionedPanels==3",
        uiOutput("cntorclus3"),
        #uiOutput("cntclus3"),
        uiOutput("clus3"),
        uiOutput("cnt3"),
        uiOutput("hline13"),
        uiOutput("dimsel3"),
        uiOutput("dim13"),
        uiOutput("dim23"),
        uiOutput("dim33"),
        uiOutput("hline23"),
        uiOutput("facsel3"),
        uiOutput("fac13"),
        uiOutput("fac23"),
        uiOutput("hline33"),
        uiOutput("size3")
      )
#      conditionalPanel(condition="input.conditionedPanels==99",
#         uiOutput("country99"),
#         uiOutput("dim99")
#      )
    ),
    mainPanel(
      tabsetPanel(
        tabPanel("Map", htmlOutput("gvismap"), icon=icon("globe"), value=1),
        tabPanel("Dimensions",  plotOutput("dimplot"), icon=icon("bar-chart"), value=2),
        tabPanel("Dim x Factor", div(       
          style = "position:relative",       
          plotOutput("dimxfac",                  
                     hover = hoverOpts("plot_hover", 
                                       delay = 100, delayType = "debounce")),       
          uiOutput("hover_info")     
          ), icon=icon("times"), value=3),
        #tabPanel("test",  htmlOutput("test"),  value=99),
        #tabPanel("test2",  plotlyOutput("testplot2"),  value=98),
        id = "conditionedPanels"
      )
    )
  )
)
)
