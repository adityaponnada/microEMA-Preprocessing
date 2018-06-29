library(psych)
library(MASS)
library(dplyr)
library(plyr)
options(digits.secs=3)

predictedActivities <- cbind(labCleanTrans, predictionFile)
