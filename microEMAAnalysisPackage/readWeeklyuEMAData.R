library(psych)
library(MASS)
library(reshape2)
library(dplyr)
library(plyr)

uEMAWeekly <- read.csv("C:/Users/Dharam/Downloads/microEMA/StudyFiles/CombinedData/uEMACombinedWeekly.csv", sep = ",", header = TRUE)


IPAQWeekly <- read.csv("C:/Users/Dharam/Downloads/microEMA/StudyFiles/CombinedData/WeeklyIPAQSummary.csv", sep = ",", header = TRUE)

colnames(IPAQWeekly)[1] <- "USER_NAME"

weeklyActivity <- cbind(IPAQWeekly, uEMAWeekly)
