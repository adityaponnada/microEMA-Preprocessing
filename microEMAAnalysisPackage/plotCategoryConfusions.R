library(ggplot2)
library(plotly)
library(corrplot)
library(GGally)
library(caret)


keep <- c("COUNTS_ACTIVITY", "ACTIVITY_TYPE")

sampleData <- combinedFile[keep]

conf_mat_tab <- table(lapply(sampleData, factor))

matrixConf <- confusionMatrix(conf_mat_tab)

plot(matrixConf$table)

