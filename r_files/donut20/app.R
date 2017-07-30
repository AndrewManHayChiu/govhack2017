#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

## Donut for 20% completion

library(shiny)
library(plotly)
library(dplyr)



ui <- fluidPage(
  fluidRow(
    column(8, 
           align = "center",
           plotlyOutput("plot")
    )
  )
)


server <- function(input, output, session) {
  
  df <- data.frame(comp = c("Complete", "Incomplete"),
                   value = c(20/100, 80/100))
  
  colors <- c('rgb(12, 232, 153)', 'rgb(58, 150, 221)')
  
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

