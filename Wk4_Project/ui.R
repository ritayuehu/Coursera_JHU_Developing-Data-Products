library(shiny)
library(plotly)

shinyUI(fluidPage(
  titlePanel("Visualize daily Value-at-Risk (VaR) of Three Indexes"),
  sidebarLayout(
    sidebarPanel(
      sliderInput("conf", "Confidence Level", 0.90, 0.99, value = 0.95),
      
      dateRangeInput("tf", "Select start and end days", min = "2018-01-01",
                     max = "2020-06-30", start = "2019-01-01", end = "2019-12-31"),
      
      submitButton("Submit"),
      
      h3("Documentation"),
      
      h5("Value-at-Risk (VaR) is a widely used indicator to measure market risk. It measures
      how much investment might lost within a given period of time, under probability p.
      For example, if a daily 99% VaR of a bank is 1 million, it means the bank will lose
      at most 1 million, with 99% probability, within one day."),
      
      h5("This application calculates daily Value-at-Risk (VaR) of three indexes: S&P 500
      in US market, Hang Seng Index in Hong Kong market, and Nikkei225 Index in 
      Japan market."),
      
      h5("1) Users can choose the confidence level in the slider;"),
      
      h5("2) Users Select the start and end days to estimate the daily return
      volatility, the min and max date are 2018-01-01 and 2020-06-30;"),
      
      h5("3) Assumes the portfolio investment is 1 millioni USD.
         The VaR of three portfolios will be displayed at the right.")
    ),
    mainPanel(
      plotlyOutput("plot1"),
      h4("Daily VaR for 1 million USD S&P500 portfolio:"),
      textOutput("varsp"),
      h4("Daily VaR for 1 million USD Hang Seng Index portfolio:"),
      textOutput("varhsi"),
      h4("Daily VaR for 1 million USD Nikkei225 portfolio:"),
      textOutput("varjp"),
      
    )
  )
))