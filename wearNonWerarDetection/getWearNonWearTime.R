library(psych)
library(MASS)
library(dplyr)
library(plyr)
library(accelerometry)

countsData <- read.csv("C:/Users/Dharam/Downloads/microEMA/StudyFiles/VizDataCheck/uema19_activity/ANKLE/MARGEE_ANKLE (2018-04-17)1secDataTable.csv", 
                       sep = ",", header = TRUE)

