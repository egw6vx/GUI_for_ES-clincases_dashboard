#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(shinyjs)

# Define UI for application that draws a histogram
ui <- navbarPage("COVID-19 Dashboard Builder",
                 tabPanel("File Input",
                            
                            sidebarLayout(
                              
                              sidebarPanel(
                                selectInput("data_preview", label = h4("Data to preview"), 
                                            choices = list("data1" = 1), 
                                            selected = 1),
                                
                                checkboxInput("checkbox", label = "Rename dataset", value = FALSE),
                                
                                
                                # Copy the line below to make a select box 
                                selectInput("select", label = h4("File input of type:"), 
                                            choices = list("csv" = 1, "xlsx" = 2, "xls" = 3), 
                                            selected = 1),
                                
                                fileInput("file", label = h4(""))
                                
                              ),
                              
                              mainPanel(
                                tabsetPanel(
                                  tabPanel("Viral Load Data",
                                           
                                           h3("Step 1) Set data parameters"),
                                           tags$head(tags$style("h3 {color: blue;
                                                 font-size: 25px;
                                                 font-style: bold;
                                                 }"
                                           )
                                           ),
                                           
                                           numericInput("vl_levels", label = h4("Number of geographic stratificaitons"), value = 1),
                                           
                                           HTML('<hr style="color: black;">'),
                                           
                                           h3("Step 2) Download viral load template  \n"),
                                           
                                           # Button
                                           downloadButton("downloadData", "Download"),
                                           
                                           HTML('<hr style="color: black;">'),
                                           
                                           h3("Step 3) Fill out data template and Import Data"),
                                           
                                           HTML('<hr style="color: black;">'),
                                           
                                           h2("Data Preview"),
                                           
                                           textOutput("vl_level_num")
                                           
                                           
                                           ), 
                                  tabPanel("Case Data",
                                           
                                           numericInput("cs_levels", label = h3("Number of geographic stratificaitons"), value = 1),
                                           
                                           h2("Data Preview")
                                           
                                           ), 
                                  tabPanel("Shape files",
                                           h2("Data Preview")
                                           
                                           )
                                )
                              )
                            )
                          
                          ),
                 tabPanel("Design Settings",
                          tabsetPanel(
                            tabPanel("Main settings",
                                     
                                     sidebarPanel(),
                                     
                                     mainPanel(
                                     
                                     h2("Main Settings")
                                     )
                                     ),
                            tabPanel("Map",
                                     sidebarPanel(
                                       
                                       selectInput("select", label = h3("Color palette"), 
                                                   choices = list("Pal1" = 1, "Pal2" = 2), 
                                                   selected = 1),
                                       
                                       selectInput("select", label = h3("Label text"), 
                                                   choices = list("txt1" = 1, "txt2" = 2, "txt3" = 3), 
                                                   selected = 1)
                                       
                                     ),
                                     
                                     mainPanel(
                                     h2("Tab Preview")
                                     )
                                     ),
                            tabPanel("Data tables",
                                     sidebarPanel(),
                                     
                                     mainPanel(
                                     h2("Tab Preview")
                                     )
                                     ),
                            tabPanel("Longitudinal plots",
                                     sidebarPanel(),
                                     
                                     mainPanel(
                                     h2("Tab Preview")
                                     )
                                     )
                          )
                          
                          
                          ),
                 tabPanel("Dashboard Export"),
                 tabPanel("Help"),
                 tabPanel("About")
)

# Define server logic required to draw a histogram
server <- function(input, output) {
  
  #Data input ---------
  #sidebar panel -------
  
  #File input --------
  
  #file to preview
  
  
  #rename
  output$value <- renderPrint({ input$checkbox })
  
  output$value <- renderPrint({ input$select })


  # You can access the value of the widget with input$file, e.g.
  output$value <- renderPrint({
    str(input$file)
  })
  
  
  # Downloadable csv of selected dataset ----
  output$downloadData <- downloadHandler(
    filename = function() {
      paste(input$dataset, ".csv", sep = "")
    },
    content = function(file) {
      write.csv(datasetInput(), file, row.names = FALSE)
    }
  )
  
  
  
  #Viral load Data ---------
  output$vl_level_num <- renderPrint({ input$vl_levels })
  
  #maybe a for loop? is numeric  input ==3, n=3, then create text box 3 times?
  #need to build a reactive and renderUI (build more text box UIs), but I want to base this on the numeric box input 
  
  
}

# Run the application 
shinyApp(ui = ui, server = server)
