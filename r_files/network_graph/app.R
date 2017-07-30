#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(networkD3)

# Define UI for application that draws a histogram
ui <- fluidPage(
   
   # # Application title
   # titlePanel("Old Faithful Geyser Data"),
   # 
   # # Sidebar with a slider input for number of bins 
   # sidebarLayout(
   #    sidebarPanel(
   #       sliderInput("bins",
   #                   "Number of bins:",
   #                   min = 1,
   #                   max = 50,
   #                   value = 30)
   #    ),
   #    
   #    # Show a plot of the generated distribution
   #    mainPanel(
   #       plotOutput("distPlot")
   #    )
   # )
   
  simpleNetworkOutput("network")
)

# Define server logic required to draw a histogram
server <- function(input, output) {
   
   # output$distPlot <- renderPlot({
   #    # generate bins based on input$bins from ui.R
   #    x    <- faithful[, 2] 
   #    bins <- seq(min(x), max(x), length.out = input$bins + 1)
   #    
   #    # draw the histogram with the specified number of bins
   #    hist(x, breaks = bins, col = 'darkgray', border = 'white')
   # })
   
  output$network <- renderSimpleNetwork({
    ## Create fake data
    src = c("Entity is registered remittance affiliate",
            "End of March after reporting period",
            "Entity provides no other designated service",
            "First business day of January after reporting period",
            "today",
            "Entity accepts transfer or remittance",
            "Entity provides no other designated service",
            "D10 after threshold transacion",
            "D10 after International Fund Trasnfer Instruction")
    
    target <- c(rep("Within AML/CTF Compliange Report Lodgement Period", 6),
                rep("Pay civil penalty", 3))
    
    ## Gather into data frame
    networkData <- data.frame(src, target)
    
    ## basic plot
    simpleNetwork(networkData)
  })
}

# Run the application 
shinyApp(ui = ui, server = server)

