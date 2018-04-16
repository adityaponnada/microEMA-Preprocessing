#### Import libraries

library(psych)
library(ggplot2)
library(plotly)
library(MASS)
library(plyr)
options(digits.secs=3)

AnkleCountsAllPlot <- plot_ly(uEMA01AnkleCounts, x = ~DATE_TIME_ANKLE, y= ~COUNTS_MAGNITUDE_ANKLE, name = "ANKLE_COUNTS", 
                               legendgroup = "ANKLE", type = "bar")

WristCoountsAllPlot <- plot_ly(uEMA01WristCounts, x = ~DATE_TIME_ANKLE, y= ~COUNTS_MAGNITUDE_WRIST, name = "WRIST_COUNTS", 
                              legendgroup = "WRIST", type = "bar")


uEMAAllPlot <- plot_ly(uEMA01AnsweredPrompts, x=~ANSWER_TIME, y=~ACTIVITY_NUMERIC, name = "uEMA_RESPONSES", 
                             legendgroup = "uEMA", type = "bar")

subplot(style(AnkleCountsAllPlot, showlegend = TRUE), style(WristCoountsAllPlot, showlegend = TRUE),
        style(uEMAAllPlot, showlegend = TRUE), nrows = 3, margin = 0.05)

uEMAAllPlot

AnkleCountsAllPlot


Ankle_plot <- ggplot(uEMA01AnkleCounts, aes(DATE_TIME_ANKLE, COUNTS_MAGNITUDE_ANKLE)) + 
  geom_bar(stat="identity", fill = "deeppink3") + xlab("Date-Time") + ylab("Ankle counts") +
  ggtitle("Ankle counts 1s interval") + 
  theme(plot.title = element_text(lineheight=.8, face="bold", size = 10)) +
  theme(text = element_text(size=10))

Ankle_plot

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