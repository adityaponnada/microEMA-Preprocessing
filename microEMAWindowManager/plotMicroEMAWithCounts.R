#### Import libraries

library(psych)
library(ggplot2)
library(plotly)
library(MASS)
library(plyr)
options(digits.secs=3)

#### Convert uEMA responses to numeric forms

countsEMADataFrame$ACTIVITY_CODED[countsEMADataFrame$ACTIVITY_TYPE == "Sedentary"] <- "1000"
countsEMADataFrame$ACTIVITY_CODED[countsEMADataFrame$ACTIVITY_TYPE == "Light/Standing"] <- "1500"
countsEMADataFrame$ACTIVITY_CODED[countsEMADataFrame$ACTIVITY_TYPE == "Moderate/Walking"] <- "4000"
countsEMADataFrame$ACTIVITY_CODED[countsEMADataFrame$ACTIVITY_TYPE == "Vigorous"] <- "8000"

head(countsEMADataFrame)

#### Convert them to mathematical numerals

countsEMADataFrame$ACTIVITY_NUMERIC <- as.numeric(as.character(countsEMADataFrame$ACTIVITY_CODED))
head(countsEMADataFrame)

class(countsEMADataFrame$ACTIVITY_NUMERIC)


#### Static plots of counts and uEMA responses with before and after

multiplot <- function(..., plotlist=NULL, file, rows=1, layout=NULL) {
  library(grid)
  
  # Make a list from the ... arguments and plotlist
  plots <- c(list(...), plotlist)
  
  numPlots = length(plots)
  
  # If layout is NULL, then use 'cols' to determine layout
  if (is.null(layout)) {
    # Make the panel
    # ncol: Number of columns of plots
    # nrow: Number of rows needed, calculated from # of cols
    layout <- matrix(seq(1, rows * ceiling(numPlots/rows)),
                     nrow = rows, ncol = ceiling(numPlots/rows))
  }
  
  if (numPlots==1) {
    print(plots[[1]])
    
  } else {
    # Set up the page
    grid.newpage()
    pushViewport(viewport(layout = grid.layout(nrow(layout), ncol(layout))))
    
    # Make each plot, in the correct location
    for (i in 1:numPlots) {
      # Get the i,j matrix positions of the regions that contain this subplot
      matchidx <- as.data.frame(which(layout == i, arr.ind = TRUE))
      
      print(plots[[i]], vp = viewport(layout.pos.row = matchidx$row,
                                      layout.pos.col = matchidx$col))
    }
  }
}



ggplotAnkleCounts_before <- ggplot(countsEMADataFrame, aes(ANSWER_TIME, COUNTS_AVERAGE_ANKLE_BEFORE)) + 
  geom_bar(stat="identity", fill = "deeppink3") + xlab("Date-Time") + ylab("Ankle counts") +
  ggtitle("Counts 60s before the uEMA prompt | Ankle") + 
  theme(plot.title = element_text(lineheight=.8, face="bold", size = 10)) +
  theme(text = element_text(size=10))

ggplotAnkleCounts_before

ggplotAnkleCounts_after <- ggplot(countsEMADataFrame, aes(ANSWER_TIME, COUNTS_AVERAGE_ANKLE_AFTER)) + 
  geom_bar(stat="identity", fill = "dodgerblue4") + xlab("Date-Time") + ylab("Ankle counts") +
  ggtitle("Counts 60s after the uEMA prompt | Ankle") + 
  theme(plot.title = element_text(lineheight=.8, face="bold", size = 10)) +
  theme(text = element_text(size=10))

ggplotAnkleCounts_after

ggplotuEMAResponses <- ggplot(countsEMADataFrame, aes(ANSWER_TIME, ACTIVITY_NUMERIC)) + 
  geom_bar(stat="identity", fill = "grey14") + xlab("Date-Time") + ylab("uEMA responses") +
  ggtitle("Responses on uEMA prompts") + 
  theme(plot.title = element_text(lineheight=.8, face="bold", size = 10)) +
  theme(text = element_text(size=10))

ggplotuEMAResponses

ggplotWristCounts_before <- ggplot(countsEMADataFrame, aes(ANSWER_TIME, COUNTS_AVERAGE_WRIST_BEFORE)) + 
  geom_bar(stat="identity", fill = "yellowgreen") + xlab("Date-Time") + ylab("Wrist counts") +
  ggtitle("Counts 60s before the uEMA prompt | Wrist") + 
  theme(plot.title = element_text(lineheight=.8, face="bold", size = 10)) +
  theme(text = element_text(size=10))

ggplotWristCounts_before

ggplotWristCounts_after <- ggplot(countsEMADataFrame, aes(ANSWER_TIME, COUNTS_AVERAGE_WRIST_AFTER)) + 
  geom_bar(stat="identity", fill = "brown3") + xlab("Date-Time") + ylab("Wrist counts") +
  ggtitle("Counts 60s after the uEMA prompt | Wrist") + 
  theme(plot.title = element_text(lineheight=.8, face="bold", size = 10)) +
  theme(text = element_text(size=10))

ggplotWristCounts_after


multiplot(ggplotAnkleCounts_before, ggplotAnkleCounts_after, ggplotWristCounts_before, ggplotWristCounts_after, ggplotuEMAResponses, rows = 5)


#### Interactive plots comparing uEMA responses and the counts

mAnkleCounts_before <- plot_ly(countsEMADataFrame, x = ~ANSWER_TIME, y= ~COUNTS_AVERAGE_ANKLE_BEFORE, name = "ANKLE_COUNTS_BEFORE", 
                        legendgroup = "ANKLE", type = "bar")
mAnkleCounts_after <- plot_ly(countsEMADataFrame, x = ~ANSWER_TIME, y= ~COUNTS_AVERAGE_ANKLE_AFTER, name = "ANKLE_COUNTS_AFTER", 
                               legendgroup = "ANKLE", type = "bar")

mWristCounts_before <- plot_ly(countsEMADataFrame, x = ~ANSWER_TIME, y= ~COUNTS_AVERAGE_WRIST_BEFORE, name = "WRIST_COUNTS_BEFORE", 
                               legendgroup = "WRIST", type = "bar")
mWristCounts_after <- plot_ly(countsEMADataFrame, x = ~ANSWER_TIME, y= ~COUNTS_AVERAGE_WRIST_AFTER, name = "WRIST_COUNTS_AFTER", 
                               legendgroup = "WRIST", type = "bar")

mEMAResponsesPlot <- plot_ly(countsEMADataFrame, x=~ANSWER_TIME, y=~ACTIVITY_NUMERIC, name = "uEMA_RESPONSES", 
                             legendgroup = "uEMA", type = "bar")##%>% layout(xaxis = list(range = as.POSIXct(c('2018-02-02 00:00:00', '2018-02-09 23:00:00'))))

subplot(style(mAnkleCounts_before, showlegend = TRUE), style(mAnkleCounts_after, showlegend = TRUE),
        style(mWristCounts_before, showlegend = TRUE), style(mWristCounts_after, showlegend = TRUE),
        style(mEMAResponsesPlot, showlegend = TRUE), nrows = 5, margin = 0.05)


