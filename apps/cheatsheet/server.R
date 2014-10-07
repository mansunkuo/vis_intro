# outside of shinyServer: run once

shinyServer(function(input, output) { 
    # run once pre user
    
    output$text <- renderText({
        # run whenever input$title changes
        input$title
    })
    
    output$plot <- renderPlot({
        # run whenever input$x or input$y changes
        x <- mtcars[ , input$x]
        y <- mtcars[ , input$y]
        plot(x, y, pch = 16) 
    })
})