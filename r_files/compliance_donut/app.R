#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

## Donut for 80% completion

library(shiny)
library(plotly)
library(dplyr)



ui <- fluidPage(
  plotlyOutput("plot")
  
)


server <- function(input, output, session) {
  
  df <- data.frame(comp = c("Complete", "Incomplete"),
                   value = c(80/100, 20/100))
  
  colors <- c('rgb(0, 255, 134)', 'rgb(0, 64, 58)')
  
  output$plot <- renderPlotly({
    plot_ly(df,
            labels = ~comp,
            values = ~value,
            marker = list(colors = colors)) %>%
      add_pie(hole = 0.6) %>%
      layout(title = "Completion %",
             showlegend = F,
             xaxis = list(showgrid = F, zeroline = F, showticklabels = F),
             yaxis = list(showgrid = F, zeroline = F, showticklabels = F))
  })
}

# Run the application 
shinyApp(ui = ui, server = server)

