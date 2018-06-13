library(plotly)
library(ggplot2)

data <- as.data.frame(combinedFile$COUNTS_SUM_ANKLE_BEFORE)


ankleBeforePlot <- plot_ly(x = combinedFile$COUNTS_SUM_ANKLE_BEFORE, type = "histogram", color = ~combinedFile$ACTIVITY_TYPE) %>% layout(xaxis = list('10 second counts'), yaxis = list('Frequency'))
