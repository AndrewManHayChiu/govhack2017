#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

ui <- fluidPage(
  sidebarPanel(
    radioButtons("TransferorIsNonIndividual", 
                 "Transfer or is for non-individual?",
                 c("Yes" = "yes",
                   "No" = "no"),
                 selected = FALSE),
    br(),
    radioButtons("TransmittedIsIndividual",
                 "Transmitted is individual?",
                 c("Yes" = "yes",
                   "No" = "no"),
                 selected = FALSE),
    br(),
    radioButtons("TransmittedIsNonIndividual",
                 "Transmitted is non-individual?",
                 c("Yes" = "yes",
                   "No" = "no"),
                 selected = FALSE),
    br(),
    radioButtons("Transmitted_isOtherTHanNonFinancierSender",
                 "Transmitter is other than non-financier sender?",
                 c("Yes" = "yes",
                   "No" = "no"),
                 selected = FALSE),
    br()
  ),
  
  mainPanel(
    # verbatimTextOutput('x')
  )
)
  

server <- function(input, output, session) {
  
  # observe({
    # output$x <- sum(input$TransferorIsNonIndividual)
        
  # })
  

  
  # output$distPlot <- renderPlot({
  #   dist <- switch(input$dist,
  #                  norm = rnorm,
  #                  unif = runif,
  #                  lnorm = rlnorm,
  #                  exp = rexp,
  #                  rnorm)
  #
  #   hist(dist(500))
  # })
}

# ui <- fluidPage(
#   p("The first radio button group controls the second"),
#   radioButtons("inRadioButtons", "Input radio buttons",
#                c("Item A", "Item B", "Item C")),
#   radioButtons("inRadioButtons2", "Input radio buttons 2",
#                c("Item A", "Item B", "Item C"))
# )
# 
# server <- function(input, output, session) {
#   observe({
#     x <- input$inRadioButtons
#     
#     # Can also set the label and select items
#     updateRadioButtons(session, "inRadioButtons2",
#                        label = paste("radioButtons label", x),
#                        choices = x,
#                        selected = x
#     )
#   })
# }

# Run the application 
shinyApp(ui = ui, server = server)

