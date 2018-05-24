#### Import library
library(psych)
library(ggplot2)
library(plotly)
library(MASS)
library(plyr)
options(digits.secs=3)

#### read the actigraph counts file (10 sec epoch intervals): Ankle
Ankle10SecCounts <- read.csv("C:/Users/Dharam/Downloads/microEMA/StudyFiles/VizDataCheck/uema19_activity/ANKLE/MARGEE_ANKLE (2018-04-17)10secDataTable.csv", 
                            sep = ",", header = TRUE)

head(Ankle10SecCounts)

#### Concatinate date time columns in date time object
Ankle10SecCounts$DATE_TIME_ANKLE <- as.POSIXct(paste(Ankle10SecCounts$Date, Ankle10SecCounts$Time), 
                                              format = "%m/%d/%Y %H:%M:%S")

head(Ankle10SecCounts)

#### use only selected columns
Ankle10SecCounts <- Ankle10SecCounts[, c("DATE_TIME_ANKLE", "Vector.Magnitude")]
head(Ankle10SecCounts)


Ankle10SecPlot <- plot_ly(Ankle10SecCounts, x = ~DATE_TIME_ANKLE, y= ~Vector.Magnitude, name = "ANKLE_COUNTS", 
                              legendgroup = "ANKLE", type = "bar")

Ankle10SecPlot
