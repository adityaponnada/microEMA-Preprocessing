#### Include library

library(psych)
library(MASS)
library(ggplot2)
library(plotly)


#### Read SPADES Ankle data file

spadesAnklePath = "C:/Users/Dharam/Downloads/microEMA/StudyFiles/SPADES_ACTIVITY_COUNT/SPADES_1/Spades_1_JJ_Ankle_Dominant (2015-09-24)1secDataTable.csv"


spadesAnkle <- read.csv(spadesAnklePath, sep = ",", header = TRUE)

head(spadesAnkle)

#### Concatinate date time columns in date time object
spadesAnkle$DATE_TIME_ANKLE <- as.POSIXct(paste(spadesAnkle$Date, spadesAnkle$Time), 
                                              format = "%m/%d/%Y %H:%M:%S")

head(spadesAnkle)



#### Read SPADES Ankle data file

spadesWristPath = "C:/Users/Dharam/Downloads/microEMA/StudyFiles/SPADES_ACTIVITY_COUNT/SPADES_1/Spades_1_Wrist_Dominant (2015-09-24)1secDataTable.csv"


spadesWrist <- read.csv(spadesWristPath, sep = ",", header = TRUE)

head(spadesWrist)

#### Concatinate date time columns in date time object
spadesWrist$DATE_TIME_ANKLE <- as.POSIXct(paste(spadesWrist$Date, spadesWrist$Time), 
                                          format = "%m/%d/%Y %H:%M:%S")

head(spadesWrist)


