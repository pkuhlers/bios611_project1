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
# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    titlePanel("Beer Consumption in the United States"),
    
    selectInput("state", "State",
                state.abb
    ),
    plotOutput("beerPlot")
)


# Define server logic required to draw a histogram
server <- function(input, output) {

    output$beerPlot <- renderPlot({
        # Generate state beer consumption over time based on input
        x <- read.csv("derived_data/combined_beer_liver.csv")
        x %>% 
            filter(state == input$state) %>%
            ggplot(aes(x = year, y = barrels)) + 
            geom_smooth(se = F)
            
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
