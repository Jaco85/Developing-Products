
library(shiny)
library(ggplot2)
library(dplyr) # %>% filtering

Weather <- as.data.frame(read.csv("Dutch Weather final.csv", sep = ";"))

server <- function(input, output) {
  output$Weather_plot <- renderPlot({
    
    filtered1 <-
      Weather %>%
      filter(NAME == input$placeInput1) %>%
      select(NAME,Weeknr,Y = input$Variable)
    Place1 = input$placeInput1
    
    filtered2 <-
      Weather %>%
      filter(NAME == input$placeInput2) %>%
      select(NAME,Weeknr,Y = input$Variable)
    Place2 = input$placeInput2
    Y_label = input$Variable
    
    ggplot() +
      geom_line(data = filtered1, aes(x = Weeknr, y= Y,color=Place1)) +
      geom_line(data = filtered2, aes(x = Weeknr, y= Y,color=Place2)) +
      xlab("Week number")+
      ylab(Y_label)
  })
  
  output$results <- renderText({
    filtered1 <-
      Weather %>%
      filter(NAME == input$placeInput1) %>%
      select(NAME,Weeknr,Y = input$Variable)
    avg1 <- round(mean(filtered1$Y),1)
    
    filtered2 <-
      Weather %>%
      filter(NAME == input$placeInput2) %>%
      select(NAME,Weeknr,Y = input$Variable)
    avg2 <- round(mean(filtered2$Y),1)
    
    
    paste("You have selected ",input$placeInput1, "(red line) and ", input$placeInput2," (blue line). The total average of", input$Variable, " of", input$placeInput1, " is ", avg1, " and ", avg2, ' degrees Celsius for ',input$placeInput2,". This is a difference of",abs(round(avg1-avg2,2))," degrees")
  })
}
shinyApp(ui=ui, server = server)