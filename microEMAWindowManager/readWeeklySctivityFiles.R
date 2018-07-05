library(plyr)
library(dplyr)
library(MASS)

readWeeklyCountData <- read.csv("C:/Users/Dharam/Downloads/microEMA/StudyFiles/CombinedData/weeklyActivities.csv", sep = ",", header = TRUE)

readWeeklyIPAQData <- read.csv("C:/Users/Dharam/Downloads/microEMA/StudyFiles/CombinedData/WeeklyIPAQSummary.csv", sep = ",", header = TRUE)

#### Club light and moderate

readWeeklyIPAQData$MODERATE_IPAQ <- readWeeklyIPAQData$MODERATE_IPAQ + readWeeklyIPAQData$LIGHT_IPAQ


IPAQData <- data.frame()

j = 1


  
  IPAQData <- rbind(IPAQData, readWeeklyIPAQData[1,])
  IPAQData <- rbind(IPAQData, readWeeklyIPAQData[5,])
  IPAQData <- rbind(IPAQData, readWeeklyIPAQData[9,])
  IPAQData <- rbind(IPAQData, readWeeklyIPAQData[13,])
  IPAQData <- rbind(IPAQData, readWeeklyIPAQData[17,])
  IPAQData <- rbind(IPAQData, readWeeklyIPAQData[21,])
  IPAQData <- rbind(IPAQData, readWeeklyIPAQData[25,])
  IPAQData <- rbind(IPAQData, readWeeklyIPAQData[29,])
  IPAQData <- rbind(IPAQData, readWeeklyIPAQData[33,])
  IPAQData <- rbind(IPAQData, readWeeklyIPAQData[37,])
  IPAQData <- rbind(IPAQData, readWeeklyIPAQData[41,])
  IPAQData <- rbind(IPAQData, readWeeklyIPAQData[45,])
  IPAQData <- rbind(IPAQData, readWeeklyIPAQData[49,])
  
  
summary(IPAQData)
summary(weeklyActivity)

  
cor.test(weeklyActivity$SED_MIN, IPAQData$SEDENTARY_IPAQ, method = "pearson")
cor.test(weeklyActivity$MOD_MIN, IPAQData$MODERATE_IPAQ, method = "pearson")
cor.test(weeklyActivity$VIG_MIN, IPAQData$VIGOROUS_IPAQ, method = "pearson")
