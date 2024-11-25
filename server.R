shinyServer(function(input, output) {

  output$Recommendation_page <- renderUI({  
    rmd2UI("www/Movie_Recommendation.Rmd")
  })
  
  output$Predicting_page <- renderUI({  
    rmd2UI("www/Predicting_Car_Prices.Rmd")
  })
  
})
