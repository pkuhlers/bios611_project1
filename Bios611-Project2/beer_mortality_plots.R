#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(tidyverse)
library(plotly)
# Define UI for application that draws a scatterplot
ui <- fluidPage(

    # Application title
    titlePanel("Beer Consumption and Liver Mortality in the United States"),
    
    p("Here we can look at each state's beer production over time individually or compare them to each other."),
    p("We can also look at each state's liver mortality rate and see how well it tracks with beer production
      on a state-by-state basis."),
    p("Since we previously observed a correlation between liver disease mortality and beer production nationally
      this can give us an idea of what states are driving the increase."),
    
    sidebarPanel(
    ## State by state beer production
    selectInput(inputId = "state", label = "State",
                choices = c("Choose State(s)" = "",state.abb),
                multiple = T
    )),
    
    mainPanel(
    plotlyOutput(outputId = "beerPlot"),
    plotlyOutput(outputId = "mortalityPlot")
    ),
)

# Define server logic required to draw a scatterplot
server <- function(input, output) {
    x <- read.csv("derived_data/combined_beer_liver.csv")
    
    output$beerPlot <- renderPlotly({
        # Generate state beer consumption over time based on state input
        if (is.null(input$state)){
            ggplot(x, aes(x = year, y = barrels, col = state)) + 
                geom_smooth(se = F, show.legend = F) + 
                ggtitle("All States Beer Production") + 
                theme(plot.title = element_text(hjust = 0.5, size = 24)) -> p
            ggplotly(p) %>% hide_legend()
            
        } else {
            print(input$state)
            x %>%
                filter(state %in% input$state) %>%
                ggplot(aes(x = year, y = barrels, col = state)) +
                geom_smooth(se = F) +
                ggtitle(c(paste(
                    paste(input$state,collapse = ", "), "Beer Production"))) + 
                theme(plot.title = element_text(hjust = 0.5,size = 24)) -> p
            ggplotly(p)
        }
        
        
    })
    
    output$mortalityPlot <- renderPlotly({
        ## Generate state mortality
        if (is.null(input$state)){
            ggplot(x, aes(x = year, y = crude.rate, col = state)) + 
                geom_smooth(se = F, show.legend = F) + 
                ggtitle("All States Liver DiseaseMortality") + 
                theme(plot.title = element_text(hjust = 0.5, size = 24)) -> p
            ggplotly(p) %>% hide_legend()
            
        } else {
            x %>%
                filter(state %in% input$state) %>%
                ggplot(aes(x = year, y = crude.rate, col = state)) +
                geom_smooth(se = F) +
                ggtitle(c(paste(
                    paste(input$state,collapse = ", "), "Liver Disease Mortality"))) + 
                theme(plot.title = element_text(hjust = 0.5,size = 24)) -> p
            ggplotly(p)
        }
    })
}

# Run the application 
shinyApp(ui = ui, server = server,options = list(port=8788, host="0.0.0.0"))
