library(psych)
library(MASS)
library(dplyr)
library(plyr)
library(caret)
library(irr)
options(digits.secs=3)


keepColumns <- c("ACTIVITY_TYPE", "PREDICTED_ACTIVITY_TYPE")

activityData <- testFrame[keepColumns]

# conf_mat_tab <- table(lapply(activityData, factor))
# 
# matrixConf <- confusionMatrix(conf_mat_tab)
# 
# plot(matrixConf$table)


kappa2(activityData, "unweighted")


u <- union(testFrame$ACTIVITY_TYPE, testFrame$PREDICTED_ACTIVITY_TYPE)
t <- table(factor(testFrame$ACTIVITY_TYPE, u), factor(testFrame$PREDICTED_ACTIVITY_TYPE, u))
confusionMatrix(t)
