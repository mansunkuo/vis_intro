library(rCharts)
library(yaml)
his = yaml.load_file("data/history.yaml")
m = Timeline$new()
m$main(
    headline =  '<a href="http://tw.linkedin.com/pub/mansun-kuo/82/3b4/344/" style="color: #000047">Mansun Kuo</a>',
    type = 'default',
    text = "Education and Experience",
    startDate =  "1982,03,13",
    asset = list(
        media = "https://www.youtube.com/watch?v=YSYmg6Bhukc"
    )
)
m$config(font = "Merriweather-Newscycle")
m$event(his)

# copy related library
rcharts_local = "charts/libraries/timeline"
rcharts_lib = file.path(find.package("rCharts"), 
                        "libraries/timeline")
dir.create(dirname(rcharts_local))
file.copy(rcharts_lib, dirname(rcharts_local), recursive = TRUE)
m$LIB$url = "libraries/timeline"

m$save("charts/timeline.html")
