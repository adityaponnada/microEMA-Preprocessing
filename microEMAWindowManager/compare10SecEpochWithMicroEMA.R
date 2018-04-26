#### Include libraries

library(psych)
library(ggplot2)
library(plotly)
library(MASS)
library(plyr)
options(digits.secs=3)

#### Read 10 sec actigraph file

Ankle10Sec <- read.csv("C:/Users/Dharam/Downloads/microEMA/StudyFiles/VizDataCheck/uema01_activity/ANKLE/YASEEN_ANKLE (2018-02-02)RAW10secDataTable.csv", 
                                            sep = ",", header = TRUE)

#### Use only selected columns

keepColumns <- c("Date", "Time", "Vector.Magnitude")

Ankle10Sec <- Ankle10Sec[, keepColumns]

#### Combine date and time columns into a POSIXct object
Ankle10Sec$DATE_TIME_ANKLE <- as.POSIXct(paste(Ankle10Sec$Date, Ankle10Sec$Time), 
                                                format = "%m/%d/%Y %H:%M:%S")
#### Rename columns

colnames(Ankle10Sec)[3] <- "ANKLE_COUNTS"

Ankle10SecCountsPlot <- plot_ly(Ankle10Sec, x = ~DATE_TIME_ANKLE, y= ~ANKLE_COUNTS, name = "ANKLE_COUNTS", 
                              legendgroup = "ANKLE", type = "bar")%>% layout(title = "uEMA01 Ankle Counts")

Ankle10SecCountsPlot

uEMAAllPlot <- plot_ly(countsEMADataFrame, x=~ANSWER_TIME, y=~ACTIVITY_NUMERIC, name = "uEMA_RESPONSES", 
                       legendgroup = "uEMA", type = "bar")%>% layout(title = "uEMA01 responses")

uEMAAllPlot

subplot(style(Ankle10SecCountsPlot, showlegend = TRUE), style(uEMAAllPlot, showlegend = TRUE)
        , nrows = 2, margin = 0.05)
