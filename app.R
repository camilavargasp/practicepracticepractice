## intor to shiny

library(tidyverse)
library(shiny)
library(shinythemes)

## Read data
spooky <- read_csv("https://raw.githubusercontent.com/allisonhorst/shiny-basics-sb-r-ladies/master/spooky_data.csv")


## Step 1 - create a user interface ui

ui <- fluidPage(
  titlePanel("My awsome Halloween app"),
  sidebarLayout(
    sidebarPanel("These are my widgets:",
                 selectInput(
                  inputId = "state_select",
                  label = "Choose a state:",
                  choices = unique(spooky$state)
                 ),
                 radioButtons(inputId = "region_select",
                              label = "Choose a region:",
                              choices = unique(spooky$region_us_census))
                 ),
    mainPanel("These are my outputs",
              tableOutput(outputId = "candy_table"))
  )
)

## Create the server ** Note if you are in a function you do not need comas to separate things.
#calling a reactive data, it always need a parenthesis after the name: state_candy()
server <- function(input, output){
  
  state_candy <- reactive({
    spooky %>% 
      filter(state == input$state_select)
  })
  output$candy_table <- renderTable({
    state_candy()
  })
  
  
}

## Call the app indicating what is your ui and what is your server
shinyApp(ui = ui, server = server)
