library(psych)
library(reshape2)
library(plotly)

#### Get distributions plotted

# plot_ly(alpha = 0.6)%>%
#   add_histogram(x=~sedentaryLab$COUNTS_PER_SECOND)%>%
#   add_histogram(x=~lightLab$COUNTS_PER_SECOND)%>%
#   add_histogram(x=~modWalkLab$COUNTS_PER_SECOND)%>%
#   add_histogram(x=~vigorousLab$COUNTS_PER_SECOND)%>%
#   layout(barmode = "overlay")


sedMin = 0.0
sedMax = 127/5

modMin = 309/5
modMax = 515/5

vigMin = 515/5
#vigMax = 515/5

username = "uema19@micropa_com"

ankleData <- read.csv("C:/Users/Dharam/Downloads/microEMA/StudyFiles/VizDataCheck/uema19_activity/ANKLE/MARGEE_ANKLE (2018-04-17)1secDataTable.csv", 
                                         sep = ",", header = TRUE)

head(ankleData)

ankleData$CLASSIFIED_ACTIVITY[ankleData$Vector.Magnitude >= sedMin & ankleData$Vector.Magnitude <= sedMax] <- "Sedentary"
ankleData$CLASSIFIED_ACTIVITY[ankleData$Vector.Magnitude >= modMin & ankleData$Vector.Magnitude < modMax] <- "Moderate"
ankleData$CLASSIFIED_ACTIVITY[ankleData$Vector.Magnitude >= vigMin] <- "Vigorous"


ankleData$DATE_TIME_ANKLE <- as.POSIXct(paste(ankleData$Date, ankleData$Time), 
                                              format = "%m/%d/%Y %H:%M:%S")

head(ankleData)
