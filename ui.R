library(shiny)
library(plotly)
library(ggplot2)
library(dplyr)
library(lubridate)
library(ggmap)
library(viridis)
library(leaflet)
library(mapproj)


load("/Users/jiechen/Downloads/USC/Class/2017 Spring/DSO 530 Applied Modern Statistical Learning Methods/Project/FinalData.rda")

ui = fluidPage(
  sidebarLayout(
    sidebarPanel(
      h5("Please indicate the weight by percentage you would put for each of the following categories: Safety, Vitality, Demographics."),
      sliderInput("Safety", label = h6("Safety (Total Crime)"),
                  min = 0,
                  max = 100,
                  value = 0),
      
      sliderInput("Vitality", label = h6("Vitality (Events, New Constructions, New Commercial Buildings, Walk Score)"),
                  min = 0,
                  max = 100,
                  value = 0),
      
      sliderInput("Demographic", label = h6("Demographic (Race, Age, Income, Occuption, Household)"),
                  min = 0,
                  max = 100,
                  value = 0),
      sliderInput("Age", label = "What is your age?",
                  min = 0,
                  max = 70,
                  value = 0),
      sliderInput("Income", label = "What is your annual household income level?",
                  min = 00000,
                  max = 200000,
                  value = 00000,
                  step = 0),
      sliderInput("Household", label = "How many people is there in your household?",
                  min = 0,
                  max = 10,
                  value = 0),
      selectInput("Race", label = "Which best describes your ethnicity?", 
                  choices = list("White" = 11, 
                                 "Black/African American" = 8, 
                                 "Hispanic/Latino" = 9, 
                                 "Asian" = 7, 
                                 "Other" = 10),
                  selected = 11),
      selectInput("Occupation", label = "Which best describes your occupation?",
                  choices = list("Management, Business, Science and Art" = 13,
                                 "Natural Resources, Construction and Maintence" = 14,
                                 "Production, Transportation and Material Moving" = 15,
                                 "Sales and Office" = 16,
                                 "Service" = 17),
                  selected = 13)
    ),
    
    
    mainPanel(tabsetPanel(
      tabPanel("Score Table",
               dataTableOutput("data_table")),
      tabPanel("Map",
               textOutput("text1"))
    )
    )
  ))