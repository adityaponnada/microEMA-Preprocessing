library(psych)
library(reshape2)
library(plotly)

wakingHoursData <- data.frame()

startTime = as.POSIXct("2018-04-17 07:00:00")
endTime = as.POSIXct("2018-04-17 23:00:00")

startTime = strftime(startTime, format = "%H:%M:%OS")
endTime = strftime(endTime, format = "%H:%M:%OS")

# for (i in 1:nrow(ankleData)){
#   
#   t = strftime(ankleData$DATE_TIME_ANKLE[i], format = "%H:%M:%OS")
#   
#   if (t >= startTime & t <= endTime) {
#     
#     wakingHoursData <- rbind(wakingHoursData, ankleData[i,])
#     print(paste0("Found the time at: ", i))
#     
#   }
#   
#   
# }

ankleData$TIME_ONLY <- strftime(ankleData$DATE_TIME_ANKLE, format = "%H:%M:%OS")
head(ankleData)


wakingHoursData <- subset(ankleData, ankleData$TIME_ONLY >= startTime & ankleData$TIME_ONLY <= endTime)

head(wakingHoursData)
