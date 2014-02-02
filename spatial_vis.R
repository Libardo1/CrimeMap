## set working directory ## 
setwd("/Users/Vora_Family/Downloads/CommAreas")

## get the data ## 
crime <- read.csv("crime.csv")

## get the shape file ## 
library(maps)
library(maptools)
chicago.mp <- readShapePoly("CommAreas.shp")

## combining the above two ## 
crime_combined <- merge(chicago.mp@data,crime,by.x='AREA_NUM_1',by.y='area')

## plot the crime map ## 
library(RColorBrewer) 
library(classInt) 
intervals <- 5
colors <- brewer.pal(intervals, "Blues")  ## choosing the colors 
brks <- classIntervals(crime_combined$violence, n=intervals, style="quantile") 
brks <- brks$brks
#plot(crime_combined,col=brks(crime_combined$violence/crime_combined$violence))

## Crime map of Chicago ## 
plot(chicago.mp, col=colors[findInterval(crime_combined$violence, brks, all.inside=TRUE)], axes=F)
title(main="Violent Crimes in Chicago per 1000 people (Monthly)")
legend("bottomleft",pch=rep(15,5), col=colors,legend=c("<0.2","between 0.2 and 0.3", "between 0.3 and 0.5","between 0.5 and 1.06", ">1.06"))
