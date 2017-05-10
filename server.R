library(shiny)
library(plotly)
library(ggplot2)
library(dplyr)
library(lubridate)
library(ggmap)
library(viridis)
library(leaflet)
library(maps)
library(zipcode)



load("/Users/jiechen/Downloads/USC/Class/2017 Spring/DSO 530 Applied Modern Statistical Learning Methods/Project/FinalData.rda")


server = function(input, output){
  
  output$text1 <- renderText({ 
    paste("You are", input$Age, "years old. Your annual income is", input$Income, 
          ".Your household size is", input$Household, 
          ".Your race is", if (input$Race == 11) {print ("White")
          } else if (input$Race == 10) {print ("Other")
          } else if (input$Race == 9) {print ("Hispanic/Latino")
          }else if (input$Race == 8) {print ("Black/African American")
          }else {print ("Asian")}, 
          ".Your occupation is", if (input$Occupation == 13) {print ("Management, Business, Science and Art")
          } else if (input$Occupation == 14) {print ("Natural Resources, Construction and Maintence")
          } else if (input$Occupation == 15) {print ("Production, Transportation and Material Moving")
          }else if (input$Occupation == 16) {print ("Sales and Office")
          }else {print ("Service")}, ".")
  })
  
  data_for_plot <- reactive({
    Age.score = rank(-abs(data$Median.Age - input$Age))
    Income.score = rank(-abs(data$MedianIncome2013 - input$Income))
    Household.score = rank(-abs(data$Average.Household.Size - input$Household))
    Occup.score = data[ ,as.numeric(input$Occupation)]
    Race.score = data[ ,as.numeric(input$Race)]
    Rent.score = rank(-abs(data$Avg..Price * 12 / input$Income))
    Walkscore = rank(-abs(data$Walkscore))
    
    rank = as.data.frame(data[, 1:3])
    rank$safety = round(rank(data$X2016.Total.Crime.Index))
    rank$vitality = round(rank(order(data$NewComBldg * 0.2 + data$NewCons * 0.2 + data$Events * 0.4 + Walkscore * 0.2, decreasing = TRUE)))
    rank$demo = round(rank(-abs(Race.score * 0.2 + Income.score * .15 + Rent.score * 0.4 + Occup.score * 0.05 + ((Age.score + Household.score) * 0.2))))

    rank$score = round(rank(-rank$safety *input$Safety - rank$vitality *input$Vitality - rank$demo *input$Demographic - 105))
    rank$rank = round(rank(-rank$score))
    rank = rank[order(rank$rank),]
    top_rank = rank[1:105,]
    
    return(top_rank)
  })
  
  output$data_table <- renderDataTable({
    data_for_plot()
  })
}