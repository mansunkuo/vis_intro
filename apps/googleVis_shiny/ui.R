shinyUI(fluidPage(
    titlePanel("薪資及生產力統計資料"),
    sidebarLayout(
        sidebarPanel(
            selectInput("type", "樣式", 
                        choices = c("Motion", "長條圖", "圓餅圖", "表格"),
                        selected = "Motion"
                        ),
            
            conditionalPanel("input.type != 'Motion'",
                uiOutput("var"),
                                 
                sliderInput("year", "西元年",
                            min=1973, max=2012, value=2012, step=1,
                            format="###0", animate = TRUE
                            ),
                                 
                checkboxInput("is_sort", "排序", T)
            ), 
            
            width = 3
        ),
        
        mainPanel(htmlOutput("view"))
        )
    )
)