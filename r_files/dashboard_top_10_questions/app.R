#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(data.table)

# Define UI for application that draws a histogram
ui <- fluidPage(

    ## Create a row  in the UI for the selectInput
    fluidRow(
      column(4,
             selectInput("reg",
                         "Regulation Area:",
                         c("All",
                           "Anti-Money Laundering and Counter-Terrorism Funding",
                           "Export Control",
                           "Finance"))
             )
    ),
    
    ## Create a new row for the table
    fluidRow(
      DT::dataTableOutput("table")
    )
  )


# Define server logic required to draw a histogram
server <- function(input, output) {
  
  
  temp3 <- data.table(regulation = c(rep("Anti-Money Laundering and Counter-Terrorism Funding", 10),
                                     rep("Export Control", 10),
                                     rep("Finance", 10)),
                      question = c("Customer is the Account Holder", 
                                   "The Customer is a signatory to the account", 
                                   "The Customer's telephone number is known",
                                   "The customer of the designated service involves a threshold transaction", 
                                   "The designated service is of a kind ordinarily provided by the entity", 
                                   "Entity allow person conduct transaction in relation to the account",
                                   "Entity delivers physical currency (including pay-rolls) to a person", 
                                   "Entity is a registered remittance affiliate", 
                                   "Entity is an reporting entity",
                                   "Entity provide a designated service",
                                   "Animal has a device that permanently idenfies it",
                                   "Animal is treated with HGP",
                                   "Animal is EU eligible",
                                   "Property has PIC",
                                   "Property is Abattoir EU listed",
                                   "Property is accredited",
                                   "Animal has marker indicative of HGP treatment - e.g. HGP pellet in the ear",
                                   "Animals are physicallt separated to avoid any mixing",
                                   "Farm is accredited for requirements of cl.52",
                                   "Property is a farm",
                                   "Has an amount of money been invested under section 58 of the PGPA Act?",
                                   "Is an amount payable to the Commonwealth under subsection 67(1) of the PGPA Act?",
                                   "Is an amount payable to the Commonwealth under subsection 68(1) of the PGPA Act?",
                                   "Is an amount payable to the Commonwealth under subsection 69(1) of the PGPA Act?",
                                   "Is an amount owing to the Commonwealth by a person?",
                                   "Has a person (the appointer) appointed another person (the appointee) to a position in the entity?",
                                   "Have the entity's annual performance statements been attached?",
                                   "Has the Auditor-General prepared an Audit Report?",
                                   "Does the Auditor General have access to the contractor's premises?",
                                   "Has the Auditor-General examined the statements?"),
                      completion_percentage = sample(c(0:100),
                                                     size = 30,
                                                     replace = F))

  output$table <- DT::renderDataTable(DT::datatable({
    data <- temp3
    
    if(input$reg == "All") {
      data <- data
    } else if (input$reg == "Anti-Money Laundering and Counter-Terrorism Funding") {
      data <- data[regulation == "Anti-Money Laundering and Counter-Terrorism Funding", ]
    } else if (input$reg == "Export Control") {
      data <- data[regulation == "Export Control", ]
    } else if (input$reg == "Finance") {
      data <- data[regulation == "Finance", ]
    }
    
      data
    }))
}

# Run the application 
shinyApp(ui = ui, server = server)

