library(MASS)
library(plyr)
library(dplyr)

nonWearFile <- read.csv("C:/Users/Dharam/Downloads/microEMA/StudyFiles/VizDataCheck/uema23_activity/ANKLE/NonWear.csv", skip = 11)

### Conver to date time object
nonWearFile$Date.Time.Start <- as.POSIXct(nonWearFile$Date.Time.Start, format = "%m/%d/%Y %I:%M %p")
nonWearFile$Date.Time.Stop <- as.POSIXct(nonWearFile$Date.Time.Stop, format = "%m/%d/%Y %I:%M %p")


### get non wear subset only

nonWearFile <- subset(nonWearFile, nonWearFile$Wear.or.Non.Wear == "Non-Wear")

nonWearFile$USER_ID <- "uema23@micropa_com"


write.csv("C:/Users/Dharam/Downloads/microEMA/StudyFiles/VizDataCheck/uema23_activity/ANKLE/NonWearOnly.csv", x = nonWearFile, quote = FALSE, row.names = FALSE, col.names = TRUE, sep = ",")
