#### Import libraries

library(psych)
library(ggplot2)
library(plotly)
library(MASS)
library(plyr)
options(digits.secs=3)

AnkleCountsAllPlot <- plot_ly(uEMA01AnkleCounts, x = ~DATE_TIME_ANKLE, y= ~COUNTS_MAGNITUDE_ANKLE, name = "ANKLE_COUNTS", 
                               legendgroup = "ANKLE", type = "bar")%>% layout(xaxis = list(range = as.POSIXct(c('2018-02-02 00:00:00', 
                                                                                                                '2018-02-02 23:59:59'))))

WristCoountsAllPlot <- plot_ly(uEMA01WristCounts, x = ~DATE_TIME_ANKLE, y= ~COUNTS_MAGNITUDE_WRIST, name = "WRIST_COUNTS", 
                              legendgroup = "WRIST", type = "bar")%>% layout(xaxis = list(range = as.POSIXct(c('2018-02-02 00:00:00', 
                                                                                                               '2018-02-02 23:00:00'))))


uEMAAllPlot <- plot_ly(uEMA01AnsweredPrompts, x=~ANSWER_TIME, y=~ACTIVITY_NUMERIC, name = "uEMA_RESPONSES", 
                             legendgroup = "uEMA", type = "bar")

subplot(style(AnkleCountsAllPlot, showlegend = TRUE), style(WristCoountsAllPlot, showlegend = TRUE),
        style(uEMAAllPlot, showlegend = TRUE), nrows = 3, margin = 0.05)

uEMAAllPlot

AnkleCountsAllPlot


Ankle_plot1 <- ggplot(uEMA01AnkleCounts, aes(DATE_TIME_ANKLE, COUNTS_MAGNITUDE_ANKLE)) + 
  geom_bar(stat="identity", fill = "deeppink3") + xlab("Date-Time") + ylab("Ankle counts") +
  ggtitle("Ankle counts 1s interval") + 
  theme(plot.title = element_text(lineheight=.8, face="bold", size = 10)) +
  theme(text = element_text(size=10)) +
  scale_x_datetime(limits = as.POSIXct(c('2018-02-02 00:00:00', '2018-02-02 23:59:59')))

#Ankle_plot1

uEMAPlot1 <- ggplot(countsEMADataFrame, aes(ANSWER_TIME, ACTIVITY_NUMERIC)) + 
  geom_bar(stat="identity", fill = "grey14") + xlab("Date-Time") + ylab("uEMA responses") +
  ggtitle("Responses on uEMA prompts") + 
  theme(plot.title = element_text(lineheight=.8, face="bold", size = 10)) +
  theme(text = element_text(size=10))+
  scale_x_datetime(limits = as.POSIXct(c('2018-02-02 00:00:00', '2018-02-02 23:59:59')))

#uEMA_plot1

Ankle_plot2 <- ggplot(uEMA01AnkleCounts, aes(DATE_TIME_ANKLE, COUNTS_MAGNITUDE_ANKLE)) + 
  geom_bar(stat="identity", fill = "deeppink3") + xlab("Date-Time") + ylab("Ankle counts") +
  ggtitle("Ankle counts 1s interval") + 
  theme(plot.title = element_text(lineheight=.8, face="bold", size = 10)) +
  theme(text = element_text(size=10)) +
  scale_x_datetime(limits = as.POSIXct(c('2018-02-03 00:00:00', '2018-02-03 23:59:59')))

#Ankle_plot2

uEMAPlot2 <- ggplot(countsEMADataFrame, aes(ANSWER_TIME, ACTIVITY_NUMERIC)) + 
  geom_bar(stat="identity", fill = "grey14") + xlab("Date-Time") + ylab("uEMA responses") +
  ggtitle("Responses on uEMA prompts") + 
  theme(plot.title = element_text(lineheight=.8, face="bold", size = 10)) +
  theme(text = element_text(size=10))+
  scale_x_datetime(limits = as.POSIXct(c('2018-02-03 00:00:00', '2018-02-03 23:59:59')))

#uEMA_plot2

Ankle_plot3 <- ggplot(uEMA01AnkleCounts, aes(DATE_TIME_ANKLE, COUNTS_MAGNITUDE_ANKLE)) + 
  geom_bar(stat="identity", fill = "deeppink3") + xlab("Date-Time") + ylab("Ankle counts") +
  ggtitle("Ankle counts 1s interval") + 
  theme(plot.title = element_text(lineheight=.8, face="bold", size = 10)) +
  theme(text = element_text(size=10)) +
  scale_x_datetime(limits = as.POSIXct(c('2018-02-04 00:00:00', '2018-02-04 23:59:59')))

#Ankle_plot3

uEMAPlot3 <- ggplot(countsEMADataFrame, aes(ANSWER_TIME, ACTIVITY_NUMERIC)) + 
  geom_bar(stat="identity", fill = "grey14") + xlab("Date-Time") + ylab("uEMA responses") +
  ggtitle("Responses on uEMA prompts") + 
  theme(plot.title = element_text(lineheight=.8, face="bold", size = 10)) +
  theme(text = element_text(size=10))+
  scale_x_datetime(limits = as.POSIXct(c('2018-02-04 00:00:00', '2018-02-04 23:59:59')))

#uEMA_plot3

Ankle_plot4 <- ggplot(uEMA01AnkleCounts, aes(DATE_TIME_ANKLE, COUNTS_MAGNITUDE_ANKLE)) + 
  geom_bar(stat="identity", fill = "deeppink3") + xlab("Date-Time") + ylab("Ankle counts") +
  ggtitle("Ankle counts 1s interval") + 
  theme(plot.title = element_text(lineheight=.8, face="bold", size = 10)) +
  theme(text = element_text(size=10)) +
  scale_x_datetime(limits = as.POSIXct(c('2018-02-05 00:00:00', '2018-02-05 23:59:59')))

#Ankle_plot4

uEMAPlot4 <- ggplot(countsEMADataFrame, aes(ANSWER_TIME, ACTIVITY_NUMERIC)) + 
  geom_bar(stat="identity", fill = "grey14") + xlab("Date-Time") + ylab("uEMA responses") +
  ggtitle("Responses on uEMA prompts") + 
  theme(plot.title = element_text(lineheight=.8, face="bold", size = 10)) +
  theme(text = element_text(size=10))+
  scale_x_datetime(limits = as.POSIXct(c('2018-02-05 00:00:00', '2018-02-05 23:59:59')))

#uEMA_plot4

Ankle_plot5 <- ggplot(uEMA01AnkleCounts, aes(DATE_TIME_ANKLE, COUNTS_MAGNITUDE_ANKLE)) + 
  geom_bar(stat="identity", fill = "deeppink3") + xlab("Date-Time") + ylab("Ankle counts") +
  ggtitle("Ankle counts 1s interval") + 
  theme(plot.title = element_text(lineheight=.8, face="bold", size = 10)) +
  theme(text = element_text(size=10)) +
  scale_x_datetime(limits = as.POSIXct(c('2018-02-06 00:00:00', '2018-02-06 23:59:59')))

#Ankle_plot5

uEMAPlot5 <- ggplot(countsEMADataFrame, aes(ANSWER_TIME, ACTIVITY_NUMERIC)) + 
  geom_bar(stat="identity", fill = "grey14") + xlab("Date-Time") + ylab("uEMA responses") +
  ggtitle("Responses on uEMA prompts") + 
  theme(plot.title = element_text(lineheight=.8, face="bold", size = 10)) +
  theme(text = element_text(size=10))+
  scale_x_datetime(limits = as.POSIXct(c('2018-02-06 00:00:00', '2018-02-06 23:59:59')))

#uEMA_plot5

Ankle_plot6 <- ggplot(uEMA01AnkleCounts, aes(DATE_TIME_ANKLE, COUNTS_MAGNITUDE_ANKLE)) + 
  geom_bar(stat="identity", fill = "deeppink3") + xlab("Date-Time") + ylab("Ankle counts") +
  ggtitle("Ankle counts 1s interval") + 
  theme(plot.title = element_text(lineheight=.8, face="bold", size = 10)) +
  theme(text = element_text(size=10)) +
  scale_x_datetime(limits = as.POSIXct(c('2018-02-07 00:00:00', '2018-02-07 23:59:59')))

#Ankle_plot6

uEMAPlot6 <- ggplot(countsEMADataFrame, aes(ANSWER_TIME, ACTIVITY_NUMERIC)) + 
  geom_bar(stat="identity", fill = "grey14") + xlab("Date-Time") + ylab("uEMA responses") +
  ggtitle("Responses on uEMA prompts") + 
  theme(plot.title = element_text(lineheight=.8, face="bold", size = 10)) +
  theme(text = element_text(size=10))+
  scale_x_datetime(limits = as.POSIXct(c('2018-02-07 00:00:00', '2018-02-07 23:59:59')))

#uEMA_plot6

Ankle_plot7 <- ggplot(uEMA01AnkleCounts, aes(DATE_TIME_ANKLE, COUNTS_MAGNITUDE_ANKLE)) + 
  geom_bar(stat="identity", fill = "deeppink3") + xlab("Date-Time") + ylab("Ankle counts") +
  ggtitle("Ankle counts 1s interval") + 
  theme(plot.title = element_text(lineheight=.8, face="bold", size = 10)) +
  theme(text = element_text(size=10)) +
  scale_x_datetime(limits = as.POSIXct(c('2018-02-08 00:00:00', '2018-02-08 23:59:59')))

#Ankle_plot7

uEMAPlot7 <- ggplot(countsEMADataFrame, aes(ANSWER_TIME, ACTIVITY_NUMERIC)) + 
  geom_bar(stat="identity", fill = "grey14") + xlab("Date-Time") + ylab("uEMA responses") +
  ggtitle("Responses on uEMA prompts") + 
  theme(plot.title = element_text(lineheight=.8, face="bold", size = 10)) +
  theme(text = element_text(size=10))+
  scale_x_datetime(limits = as.POSIXct(c('2018-02-08 00:00:00', '2018-02-08 23:59:59')))

#uEMA_plot7

Ankle_plot8 <- ggplot(uEMA01AnkleCounts, aes(DATE_TIME_ANKLE, COUNTS_MAGNITUDE_ANKLE)) + 
  geom_bar(stat="identity", fill = "deeppink3") + xlab("Date-Time") + ylab("Ankle counts") +
  ggtitle("Ankle counts 1s interval") + 
  theme(plot.title = element_text(lineheight=.8, face="bold", size = 10)) +
  theme(text = element_text(size=10)) +
  scale_x_datetime(limits = as.POSIXct(c('2018-02-09 00:00:00', '2018-02-09 23:59:59')))

#Ankle_plot8

uEMAPlot8 <- ggplot(countsEMADataFrame, aes(ANSWER_TIME, ACTIVITY_NUMERIC)) + 
  geom_bar(stat="identity", fill = "grey14") + xlab("Date-Time") + ylab("uEMA responses") +
  ggtitle("Responses on uEMA prompts") + 
  theme(plot.title = element_text(lineheight=.8, face="bold", size = 10)) +
  theme(text = element_text(size=10))+
  scale_x_datetime(limits = as.POSIXct(c('2018-02-09 00:00:00', '2018-02-09 23:59:59')))

#uEMA_plot8

multiplot(Ankle_plot1, uEMAPlot1, rows = 2)

Wrist_plot <- ggplot(uEMA01WristCounts, aes(DATE_TIME_ANKLE, COUNTS_MAGNITUDE_ANKLE)) + 
  geom_bar(stat="identity", fill = "dodgerblue4") + xlab("Date-Time") + ylab("Wrist counts") +
  ggtitle("Wrist counts 1s interval") + 
  theme(plot.title = element_text(lineheight=.8, face="bold", size = 10)) +
  theme(text = element_text(size=10))

Wrist_plot

uEMA_plot <- ggplot(uEMA01AnsweredPrompts, aes(ANSWER_TIME, ACTIVITY_NUMERIC)) + 
  geom_bar(stat="identity", fill = "grey14") + xlab("Date-Time") + ylab("uEMA responses") +
  ggtitle("Responses on uEMA prompts") + 
  theme(plot.title = element_text(lineheight=.8, face="bold", size = 10)) +
  theme(text = element_text(size=10))

uEMA_plot

multiplot(Ankle_plot, Wrist_plot, uEMA_plot, rows = 3)

Ankle_segment <- ggplot(uEMA01AnkleCounts, aes(DATE_TIME_ANKLE, COUNTS_MAGNITUDE_ANKLE)) + 
  geom_bar(stat="identity", fill = "deeppink3") + xlab("Date-Time") + ylab("Ankle counts") +
  ggtitle("Ankle counts 1s interval") + 
  theme(plot.title = element_text(lineheight=.8, face="bold", size = 10)) +
  theme(text = element_text(size=10)) +
  scale_x_datetime(limits = as.POSIXct(c('2018-02-07 10:15:00', '2018-02-07 10:45:00')))

uEMAPlot_segment <- ggplot(countsEMADataFrame, aes(ANSWER_TIME, ACTIVITY_NUMERIC)) + 
  geom_bar(stat="identity", fill = "grey14") + xlab("Date-Time") + ylab("uEMA responses") +
  ggtitle("Responses on uEMA prompts") + 
  theme(plot.title = element_text(lineheight=.8, face="bold", size = 10)) +
  theme(text = element_text(size=10))+
  scale_x_datetime(limits = as.POSIXct(c('2018-02-07 10:15:00', '2018-02-07 10:45:00')))


multiplot(Ankle_segment, uEMAPlot_segment, rows = 2)





