

pacman::p_load(shiny, tidyverse, shinythemes, tools, jsonlite, ggraph,
               visNetwork, lubridate)

mc2_graph<- readRDS("data/mc2_graph.rds")

ui <- navbarPage(
  title = "ShinyNet: Exploring, Visualizing and Analysing Network Data",
  fluid = TRUE,
  theme=shinytheme("flatly"),
  id = "navbarID",
  tabPanel("Introduction"),
  navbarMenu("Static Network",
             tabPanel("Basic",
                      sidebarLayout(
                        sidebarPanel(width = 3,
                                     selectInput(inputId = "layOut",
                                                 label = "Select Layout",
                                                 choices = c("Fruchterman and Reigngold" = "fr",
                                                             "Kamada and Kawai" = "kk"),
                                                 selected = "fr")),
                        mainPanel(width = 9,
                                  plotOutput("net1",
                                             height = "500px"))
                      )
                 ),
             tabPanel("Network graph 2", "H graph")
               )
           )

server <- function(input, output) {
  output$net1 <- renderPlot({
    set.seed(1234)
    
    ggraph(mc2_graph, 
           layout = input$layOut) +
      geom_edge_link(aes()) +
      geom_node_point(aes()) +
      theme_graph()
  })
}

shinyApp(ui = ui, server = server)
