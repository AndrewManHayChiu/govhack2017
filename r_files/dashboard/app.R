#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(plotly)
library(data.table)

# Define UI for application that draws a histogram
ui <- fluidPage(
   
   # Application title
   titlePanel("Dashboard"),
   
   # Sidebar with a slider input for number of bins 
   
   # Show a plot of the generated distribution
      mainPanel(
         h3("Distribution of Compliance Percentage"),
         p("This is a distribution of compliance against all areas at a high
           level. There appear to be two populations of businesses / prospective
           entrepreneurs using the tool: those who are working towards compliance,
           and those that stop early on."),
         plotlyOutput("completion_dist"),
         br(),
         
         h3("Quartiles of Compliance by Regulation"),
         p("Below is a distribution of level of compliance by regulatory area.
            with than other areas."),
         plotlyOutput("completion_boxplot"),
         br(),
         
         h3("Top 10 incomplete questions"),
         p("Below are the highest areas of non-compliance, and should be 
           investigated to identify root causes."),
         DT::dataTableOutput("table"),
         br()
      )
   )


# Define server logic required to draw a histogram
server <- function(input, output) {
   
  temp <- c(rnorm(n = 1000, mean = 1, sd = 1), 
            rnorm(n = 1000, mean = 6, sd = 2))
  temp <- temp[temp > 0 & temp < 10]
  temp <- temp * 10
  
  colors <- c('rgb(0, 64, 58)')
  
   output$completion_dist <- renderPlotly({
     plot_ly(x = ~temp,
             type = "histogram",
             opacity = 0.7,
             marker = list(line = list(width = 1, 
                                       color = "white"),
                           color = colors)) %>%
       layout(title = "Distribution of compliance percentage",
              xaxis = list(title = "Percentage completion"))
   })
   
   temp2 <- data.frame(regulation = c(rep("AML/CTF", 100),
                                      rep("Export", 100),
                                      rep("Finance", 100)),
                       percentage_completion = c(rnorm(n = 100, mean = 25, sd = 20),
                                                 rnorm(n = 100, mean = 60, sd = 20),
                                                 rnorm(n = 100, mean = 30, sd = 30)))
   temp2 <- data.table(temp2)
   temp2 <- temp2[percentage_completion >= 0 & percentage_completion <= 100, ]
   
   output$completion_boxplot <- renderPlotly({
     plot_ly(type = "box") %>%
       add_trace(data = temp2[regulation == "AML/CTF", ],
                 y = ~percentage_completion,
                 boxpoints = "all",
                 jitter = 0.3,
                 marker = list(color = 'rgb(0, 64, 58)'),
                 line = list(color = 'rgb(0, 64, 58)'),
                 name = "AML/CTF") %>%
       add_trace(data = temp2[regulation == "Export", ],
                 y = ~percentage_completion,
                 boxpoints = "all",
                 jitter = 0.3,
                 marker = list(color = 'rgb(0, 64, 58)'),
                 line = list(color = 'rgb(0, 64, 58)'),
                 name = "Export") %>%
       add_trace(data = temp2[regulation == "Finance", ],
                 y = ~percentage_completion,
                 boxpoints = "all",
                 jitter = 0.3,
                 marker = list(color = 'rgb(0, 64, 58)'),
                 line = list(color = 'rgb(0, 64, 58)'),
                 name = "Finance") %>%
       layout(title = "Quartiles of Compliance Percentage by Regulation",
              xaxis = list(title = "Regulation"),
              yaxis = list(title = "Percentage Completion"),
              showlegend = F)
   })
   
   temp3 <- data.table(question = c("Question 1", "Question 2", "Question 3",
                                   "Question 4", "Question 5", "Question 6",
                                   "Question 7", "Question 8", "Question 9",
                                   "Question 10"),
                      completion_percentage = sample(c(0:100), 
                                                     size = 10, 
                                                     replace = F))
   
   output$table <- DT::renderDataTable(DT::datatable({
     temp3[order(completion_percentage)]
   }))
}

# Run the application 
shinyApp(ui = ui, server = server)

