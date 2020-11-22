library(shiny)
library(plotly)

shinyServer(function(input, output) {
  
  # data preprocessing
  data_raw <- read.csv("./Data/Wk4_data.csv", header = TRUE)
  data_raw$Datenew <- as.Date(data_raw$Date, format = "%m/%d/%Y")
  
  data_sub <- reactive({
    data_sub <- as.data.frame(data_raw[(data_raw$Datenew >= input$tf[1] & data_raw$Datenew <= input$tf[2]),])
    data_sub
    })
  
  # data_sub <- data_raw[(data_raw$Datenew >= input$tf[1] & data_raw$Datenew <= input$tf[2]),]
  
  calvarsp <- reactive({
    data_sub <- data_sub()
    1000000*sd(data_sub[, "SP500"])*qnorm(as.numeric(input$conf))
  })
  
  output$varsp <- renderText({
    calvarsp()
  })
  
  calvarhsi <- reactive({
    data_sub <- data_sub()
    1000000*sd(data_sub[, "HKHSI"])*qnorm(as.numeric(input$conf))
  })
  
  output$varhsi <- renderText({
    calvarhsi()
  })
  
  calvarjp <- reactive({
    data_sub <- data_sub()
    1000000*sd(data_sub[, "Nikkei225"])*qnorm(as.numeric(input$conf))
  })
  
  output$varjp <- renderText({
    calvarjp()
  })
  
  output$plot1 <- renderPlotly({
    
    data_sub <- data_sub()
    
    plot_ly(data = data_sub, x = data_sub$Datenew, y = data_sub$SP500,
            name = 'S&P500', type = "scatter", mode = 'lines+markers') %>%
      add_trace(y = data_sub$HKHSI, name = 'Hang Seng Index',
                mode = 'lines+markers') %>%
      add_trace(y = data_sub$Nikkei225, name = 'Nikkei225',
                mode = 'lines+markers') %>%
      layout(title = "Daily return of three indexes",
                          xaxis = list(title = ""),
                          yaxis = list (title = "Daily return"))

  })
  
  
})