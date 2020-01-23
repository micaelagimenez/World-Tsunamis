#Import necessary libraries
library(ggplot2)
library(plotly)

#Load file
tsunamis <- read.csv("C:/Users/micae/Documents/dataset/tsunamis.csv",
                     header=T,
                     stringsAsFactors = F)

#Organize by columns needed
tsunamis1 = tsunamis[c("YEAR","LATITUDE","LONGITUDE","LOCATION_N","COUNTRY",
                       "RUNUP_HT")]
tsunamis2 <- tsunamis1[tsunamis1$YEAR >=0,]

#Settings for the map
g <- list(projection = list(type = 'orthographic'),
          framewidth=0,
          coastlinecolor = "#c9c9c5",
          showland = TRUE,
          landcolor = "#e2e2d7",
          showcountries = TRUE,
          showocean = TRUE,
          oceancolor = "#bed9e0",
          countrywidth = 0.2)

    
#Plot world map with needed data
p <- plot_geo(tsunamis2, marker = list(opacity=1,
                                       line=list(width=0))) %>%
  add_markers(x=~LONGITUDE,
              y=~LATITUDE,
              frame=~YEAR,
              color=~RUNUP_HT,
              colors=c("#6b8ec6","#4d7ecc","122a4f"),
              size=~1.0,
              hoverinfo = "text",
              text= ~paste("Country:", COUNTRY,
                           "<br />Location:", LOCATION_N,
                           "<br />Runap Height:", RUNUP_HT)) %>%
  layout(geo = g, title = "World Tsunamis",
         margin=list(t=90))

#Observe results
print(p)
