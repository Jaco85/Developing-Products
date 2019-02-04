library(shiny)

# Import Data
Weather <- as.data.frame(read.csv("Dutch Weather final.csv", sep = ";"))
names(Weather)

# Define UI for application that draws a histogram
ui <- fluidPage(
  titlePanel("Historic Dutch Weather (Temperature) by weeknumber"),
  sidebarLayout(
    sidebarPanel(
      radioButtons("Variable", "Select the mean of Min, Avg or Max Temperature",
                   choices = c("Temperature_min", "Temperature_avg", "Temperature_max"),
                   selected = "Temperature_avg"),
      selectInput("placeInput1", "Place1:",  
                  choices=unique(Weather$NAME),
                  selected = "LEEUWARDEN"),
      selectInput("placeInput2", "Place2:",  
                  choices=unique(Weather$NAME),
                  selected = "MAASTRICHT")
    ),
    mainPanel(
      plotOutput("Weather_plot"),
      br(), br(),
      tableOutput("results")
    )
  )
)
