library(googleVis)
library(shiny)

worker_data = read.csv("worker_data.csv", stringsAsFactors=F)
colnames(worker_data) = gsub("\\.", "", colnames(worker_data))
worker_data[worker_data == "-"] = NA
index = which(colnames(worker_data) != "行業")
for(i in index){
    worker_data[, i] = as.numeric(worker_data[, i])
}
worker_data$時間年 = worker_data$時間年 + 1911
worker_data$平均時薪 = worker_data$平均薪資/worker_data$平均工時
# str(worker_data)

choices = setdiff(colnames(worker_data), c("時間年", "行業"))

gvis_options = list("Motion" = list(),
                    "長條圖" = list(height = 500,
                                 chartArea = "{top:0}"),
                    "圓餅圖" = list(height = 500,
                                 chartArea = "{top:0}"),
                    "表格" = list())

message("outside shinyServer")

shinyServer(function(input, output) {
    message("inside shinyServer")
    output$var = renderUI({
        message("renderUI")
        selectInput("var", "項目", 
                    choices = choices,
                    selected = "平均時薪"
        )
    })
    
    datasetInput = reactive({
        message("reactive")
        year = input$year
        var = input$var
        is_sort = input$is_sort
        sub_data = worker_data[which(worker_data$時間年 == year), 
                               c("行業", var)]
        if (is_sort){
            index = order(sub_data[, var], decreasing=T)
            sub_data = sub_data[index, ]
        }
        data.frame(sub_data)
    })
    
    gvis_type = list("Motion" = gvisMotionChart,
                     "長條圖" = gvisBarChart,
                     "圓餅圖" = gvisPieChart,
                     "表格" = gvisTable)
    
    output$view = renderGvis({
        message("renderGvis")
        if (input$type == "Motion"){
            message(input$type)
            gvis_type[[input$type]](worker_data, 
                                    idvar="行業", 
                                    timevar="時間年",
                                    xvar="受僱員工人數",
                                    yvar="平均時薪",
                                    options = gvis_options[[input$type]])
        } else{
            message(input$type)
            gvis_type[[input$type]](datasetInput(),
                                    options = gvis_options[[input$type]])
        }
    })

})