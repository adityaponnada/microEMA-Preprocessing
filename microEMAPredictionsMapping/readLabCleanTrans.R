library(psych)
library(MASS)
library(dplyr)
library(plyr)
options(digits.secs=3)

labCleanTrans <- read.csv("C:/Users/Dharam/Downloads/microEMA/StudyFiles/VizDataCheck/uema01_activity/Predictions/lab_clean_trans.csv", 
                     sep = ",", header = TRUE)

keepColumns <- c("PARTICIPANT_ID", "HEADER_START_TIME", "HEADER_STOP_TIME")

labCleanTrans <- labCleanTrans[, keepColumns]

labCleanTrans$HEADER_START_TIME <- as.POSIXct(labCleanTrans$HEADER_START_TIME, format = "%Y-%m-%d %H:%M:%OS")
labCleanTrans$HEADER_STOP_TIME <- as.POSIXct(labCleanTrans$HEADER_STOP_TIME, format = "%Y-%m-%d %H:%M:%OS")

class(labCleanTrans$HEADER_START_TIME)
class(labCleanTrans$HEADER_STOP_TIME)

### Remove last line - not relevant

labCleanTrans <- labCleanTrans[-nrow(labCleanTrans),]
