## Check data visually for each subject and generate a subject level data frame with uEMA, Predictions, and Counts

## Import libraries

library(psych)
library(ggplot2)
library(plotly)
library(MASS)
library(plyr)
options(digits.secs=3)

## Read all files

#### Read the uEMA response file, actigraph counts file for ankle and wrist, and prediction files for ankle and wrist for seven days.

#### Read counts file for ankle

ActigraphCountsAnkle <- read.csv("C:/Users/Dharam/Downloads/microEMA/StudyFiles/VizDataCheck/uema01_activity/ANKLE/YASEEN_ANKLE (2018-02-02)RAW60secDataTable.csv", 
                                 sep = ",", header = TRUE)

head(ActigraphCountsAnkle)

#### Combine date and time columns into single column and then convert that into a date time object.

ActigraphCountsAnkle$DATE_TIME_ANKLE <- as.POSIXct(paste(ActigraphCountsAnkle$Date, ActigraphCountsAnkle$Time), 
                                             format = "%m/%d/%Y %H:%M:%S")

head(ActigraphCountsAnkle)

#### Read counts file for wrist

ActigraphCountsWrist <- read.csv("C:/Users/Dharam/Downloads/microEMA/StudyFiles/VizDataCheck/uema01_activity/WRIST/YASEEN_WRIST (2018-02-02)RAW60secDataTable.csv", sep = ",", header = TRUE)

head(ActigraphCountsWrist)

#### Combine date and time columns into single column and then convert that into a date time object.

ActigraphCountsWrist$DATE_TIME_WRIST <- as.POSIXct(paste(ActigraphCountsWrist$Date, ActigraphCountsWrist$Time), format = "%m/%d/%Y %H:%M:%S")

head(ActigraphCountsWrist)

#### Read prediction and lab clean trans file for ankle

PredictionAnkle <- read.csv("C:/Users/Dharam/Downloads/microEMA/StudyFiles/VizDataCheck/uema01_activity/ANKLE/ankle_uEMA_prediction_samples_on_SPADES_model.csv", 
                            sep = ",", header = TRUE)

head(PredictionAnkle)

lab_clean_trans_ankle <- read.csv("C:/Users/Dharam/Downloads/microEMA/StudyFiles/VizDataCheck/uema01_activity/ANKLE/lab_clean_trans.csv",
                                  sep = ",", header = TRUE)

head(lab_clean_trans_ankle)

#### Assign the date time from lab_clean_trans to the prediction file

#### This is required to assign the correct date and time for predicted probabilities and the predictions


PredictionAnkle$HEADER_START_TIME_ANKLE <- lab_clean_trans_ankle$HEADER_START_TIME
PredictionAnkle$HEADER_STOP_TIME_ANKLE <- lab_clean_trans_ankle$HEADER_STOP_TIME

head(PredictionAnkle)
tail(PredictionAnkle)

#### Read predictions on the wrist and the lab_clean_trans files
PredictionWrist <- read.csv("C:/Users/Dharam/Downloads/microEMA/StudyFiles/VizDataCheck/uema01_activity/WRIST/dominant_wrist_uEMA_prediction_samples_on_SPADES_model.csv", 
                            sep = ",", header = TRUE)

head(PredictionWrist)

lab_clean_trans_wrist <- read.csv("C:/Users/Dharam/Downloads/microEMA/StudyFiles/VizDataCheck/uema01_activity/WRIST/lab_clean_trans.csv",
                                  sep = ",", header = TRUE)

head(lab_clean_trans_wrist)

#### Assign the date time from lab_clean_trans to the prediction file

#### This is required to assign the correct date and time for predicted probabilities and the predictions

PredictionWrist$HEADER_START_TIME_WRIST <- lab_clean_trans_wrist$HEADER_START_TIME
PredictionWrist$HEADER_STOP_TIME_WRIST <- lab_clean_trans_wrist$HEADER_STOP_TIME

head(PredictionWrist)
tail(PredictionWrist)

#### Read uEMA responses

uEMAResponses <- read.csv("C:/Users/Dharam/Downloads/microEMA/StudyFiles/Responses_uEMA/uEMAPromptResponses.csv", 
                          sep = ",", header = TRUE)

head(uEMAResponses)
tail(uEMAResponses)

#### Filter out the desired participant data from uEMAResponses and then get the first week responses from it.
#### For instance, if interested in participant one, use label uEMA01.

uEMA01 <- uEMAResponses[uEMAResponses$USER_ID == "uema01@micropa_com",]
head(uEMA01)
tail(uEMA01)
nrow(uEMA01)

#### Remove all the dismissed and missed prompts

uEMA01 <- uEMA01[!uEMA01$ACTIVITY_TYPE == "MISSED", ]
uEMA01 <- uEMA01[!uEMA01$ACTIVITY_TYPE == "DISMISSED", ]

levels(uEMA01$ACTIVITY_TYPE)

head(uEMA01)
tail(uEMA01)

#### Convert date time columns into date time objects


uEMA01$ANSWER_TIME <- as.POSIXct(uEMA01$ANSWER_TIME, format = "%m/%d/%Y %H:%M:%OS")

head(uEMA01)
tail(uEMA01)

#### Convert responses to scale factors. [ Sedentary = 1000, Light/Standing = 1500, Moderate/Walking = 4000, Vigorous = 8000 ]

uEMA01$ACTIVITY_CODED[uEMA01$ACTIVITY_TYPE == "Sedentary"] <- "1000"
uEMA01$ACTIVITY_CODED[uEMA01$ACTIVITY_TYPE == "Light/Standing"] <- "1500"
uEMA01$ACTIVITY_CODED[uEMA01$ACTIVITY_TYPE == "Moderate/Walking"] <- "4000"
uEMA01$ACTIVITY_CODED[uEMA01$ACTIVITY_TYPE == "Vigorous"] <- "8000"

levels(uEMA01$ACTIVITY_CODED)
levels(uEMA01$ACTIVITY_TYPE)

head(uEMA01)
tail(uEMA01)

#### Recode to numeric only for plotting purposes

class(uEMA01$ACTIVITY_CODED)
uEMA01$ACTIVITY_NUMERIC <- as.numeric(as.character(uEMA01$ACTIVITY_CODED))
head(uEMA01)

class(uEMA01$ACTIVITY_NUMERIC)

## Recode predicted activities - Ankle

#### 1: sedentary, 2:Light/standing, 3:Moderate/walking, 4:Vigorous, 0: Transition, 5: Unknown

#### These are recoded to: Sedentary = 1000, Light/Standing = 1500, Moderate/Walking = 4000, Vigorous = 8000

class(PredictionAnkle$PRED_CLASS_ID)
PredictionAnkle$PRED_CLASS_ID_ANKLE <- as.numeric(PredictionAnkle$PRED_CLASS_ID)
class(PredictionAnkle$PRED_CLASS_ID)

PredictionAnkle$PRED_CLASS_CODED_ANKLE[PredictionAnkle$PRED_CLASS_ID_ANKLE == 1] <- 1000
PredictionAnkle$PRED_CLASS_CODED_ANKLE[PredictionAnkle$PRED_CLASS_ID_ANKLE == 2] <- 1500
PredictionAnkle$PRED_CLASS_CODED_ANKLE[PredictionAnkle$PRED_CLASS_ID_ANKLE == 3] <- 4000
PredictionAnkle$PRED_CLASS_CODED_ANKLE[PredictionAnkle$PRED_CLASS_ID_ANKLE == 4] <- 8000

PredictionAnkle$PRED_CLASS_CODED_ANKLE[PredictionAnkle$PRED_CLASS_ID_ANKLE == 0] <- 0
PredictionAnkle$PRED_CLASS_CODED_ANKLE[PredictionAnkle$PRED_CLASS_ID_ANKLE == 5] <- 500

head(PredictionAnkle)
tail(PredictionAnkle)

#### Convert header start time to a date time object

PredictionAnkle$HEADER_START_TIME_ANKLE <- as.POSIXct(PredictionAnkle$HEADER_START_TIME, format = "%Y-%m-%d %H:%M:%OS")

head(PredictionAnkle)
tail(PredictionAnkle)

## Recode predicted activities - Wrist

#### 1: sedentary, 2:Light/standing, 3:Moderate/walking, 4:Vigorous, 0: Transition, 5: Unknown

#### These are recoded to: Sedentary = 1000, Light/Standing = 1500, Moderate/Walking = 4000, Vigorous = 8000

class(PredictionWrist$PRED_CLASS_ID)
PredictionWrist$PRED_CLASS_ID_WRIST <- as.numeric(PredictionWrist$PRED_CLASS_ID)
class(PredictionWrist$PRED_CLASS_ID_WRIST)

PredictionWrist$PRED_CLASS_CODED_WRIST[PredictionWrist$PRED_CLASS_ID_WRIST == 1] <- 1000
PredictionWrist$PRED_CLASS_CODED_WRIST[PredictionWrist$PRED_CLASS_ID_WRIST == 2] <- 1500
PredictionWrist$PRED_CLASS_CODED_WRIST[PredictionWrist$PRED_CLASS_ID_WRIST == 3] <- 4000
PredictionWrist$PRED_CLASS_CODED_WRIST[PredictionWrist$PRED_CLASS_ID_WRIST == 4] <- 8000

PredictionWrist$PRED_CLASS_CODED_WRIST[PredictionWrist$PRED_CLASS_ID_WRIST == 0] <- 0
PredictionWrist$PRED_CLASS_CODED_WRIST[PredictionWrist$PRED_CLASS_ID_WRIST == 5] <- 500

head(PredictionWrist)
tail(PredictionWrist)

#### Convert header start time to a date time object

PredictionWrist$HEADER_START_TIME_WRIST <- as.POSIXct(PredictionWrist$HEADER_START_TIME_WRIST, format = "%Y-%m-%d %H:%M:%OS")

head(PredictionWrist)
tail(PredictionWrist)




#### Interactive - Raw plots with unmapped data: using plotly

pAnkleCounts <- plot_ly(ActigraphCountsAnkle, x = ~DATE_TIME_ANKLE, y= ~VECTOR_MAGNITUDE_ANKLE, name = "ANKLE_COUNTS", 
                        legendgroup = "ANKLE_COUNTS", type = "bar")

pAnklePredictions <- plot_ly(PredictionAnkle, x = ~HEADER_START_TIME_ANKLE, y= ~PRED_CLASS_CODED_ANKLE, name = "PREDICTIONS_ANKLE", 
                             legendgroup = "PREDICTIONS_ANKLE", type = "bar")
pWristCounts <- plot_ly(ActigraphCountsWrist, x = ~DATE_TIME_WRIST, y= ~VECTOR_MAGNITUDE_WRIST, name = "WRIST_COUNTS", 
                        legendgroup = "WRIST_COUNTS", type = "bar")

pWristPredictions <- plot_ly(PredictionWrist, x = ~HEADER_START_TIME_WRIST, y= ~PRED_CLASS_CODED_WRIST, name = "PREDICTIONS_WRIST", 
                             legendgroup = "PREDICTIONS_WRIST", type = "bar")

#### Note: please be careful when selecting the date time range

pResponses <- plot_ly(uEMA01, x=~ANSWER_TIME, y=~ACTIVITY_NUMERIC, name = "uEMA_RESPONSES", 
                      legendgroup = "uEMA", type = "bar")%>% layout(xaxis = list(range = as.POSIXct(c('2018-02-02 00:00:00', 
                                                                                                      '2018-02-09 23:00:00'))))

subplot(style(pAnkleCounts, showlegend = TRUE), style(pAnklePredictions, showlegend = TRUE), style(pWristCounts, showlegend = TRUE),
        style(pWristPredictions, showlegend = TRUE),style(pResponses, showlegend = TRUE), nrows = 5, margin = 0.05) 

#### Raw static plots of unpammped data



## Create a combo data frame
head(uEMA01)
head(PredictionAnkle)
head(ActigraphCountsAnkle)
head(PredictionWrist)
head(ActigraphCountsWrist)

##Change the names of vector magnitude columns
colnames(ActigraphCountsAnkle)[8]<-"VECTOR_MAGNITUDE_ANKLE"
colnames(ActigraphCountsWrist)[8]<-"VECTOR_MAGNITUDE_ANKLE"

head(ActigraphCountsAnkle)
head(ActigraphCountsWrist)

#### Find closest date time points in actigraph predictions

## start with each row in the uEMA response file
totalMatches = 0
#combinedDataframe_1 <- combinedDataframe_1[c(),]

#combinedDataframe_1 <- as.data.frame()
combinedDataframe_1 = data.frame()

k = 0
for(i in 1:nrow(uEMA01)){
  print(paste0("Starting with the uEMA index: ", i))
  
  ## Get the row for index i
  uEMARow <- uEMA01[i,]
  k = k+1
  
  if (k > nrow(PredictionAnkle)){
    break
    
  }
  ## start with each row in predictions file
  for(j in k:nrow(PredictionAnkle)){
    print(paste0("Inside the predictions table at index: ", j))
    
    ## Get the row j from prediction file
    PredictionRow <- PredictionAnkle[j,]
    
    ## Get the time difference between the date time and header time from the two files
    deltaTime = difftime(uEMARow$ANSWER_TIME, PredictionRow$HEADER_START_TIME_ANKLE,   units = "secs")
    print(paste0("Got the time difference to be: ", deltaTime))
    
    ## Check if the header time stamp is after the date time in uEMA responses
    if (deltaTime <= 12.8 & deltaTime >= 0) {
      print("Delta time is within the range")
      ## stop the operation
      ## Save the latest row and append it to a dataframe of uEMARow
      combinedColumns <- cbind(uEMARow, PredictionRow)
      print("Combine the columns")
      combinedDataframe_1 <- rbind(combinedDataframe_1,combinedColumns)
      ##combinedDataframe_1[[i]] <- combinedColumns
      print("Append to the dataframe")
      k = j
      totalMatches = totalMatches + 1
      break
      
    } else if (deltaTime < 0){
      
      break
    } 
    
    
  }
  
}

print("About to create a data frame")
print("Total matches found: ")
totalMatches
#combinedDataframe_1 <- as.data.frame(do.call("rbind", combinedColumns))
nrow(combinedDataframe_1)


#### Find the closest date time points in the counts file with respect to the uEMA responses

totalMatches = 0
# <- combinedDataframe_2[c(),]
combinedDataframe_2 = data.frame()

print("Starting mathcing uEMA and Actigraph counts for ankle")

k = 0
for(i in 1:nrow(uEMA01)){
  print(paste0("Starting with the uEMA index: ", i))
  
  ## Get the row for index i
  uEMARow <- uEMA01[i,]
  k = k+1
  
  if (k > nrow(ActigraphCountsAnkle)){
    break
    
  }
  ## start with each row in predictions file
  for(j in k:nrow(ActigraphCountsAnkle)){
    print(paste0("Inside the counts table at index: ", j))
    
    ## Get the row j from prediction file
    PredictionRow <- ActigraphCountsAnkle[j,]
    
    ## Get the time difference between the date time and header time from the two files
    deltaTime = difftime(uEMARow$ANSWER_TIME, PredictionRow$DATE_TIME_ANKLE,   units = "secs")
    print(paste0("Got the time difference to be: ", deltaTime))
    
    ## Check if the header time stamp is after the date time in uEMA responses
    if (deltaTime <= 60 & deltaTime >= 0) {
      print("Delta time is within the range")
      ## stop the operation
      ## Save the latest row and append it to a dataframe of uEMARow
      combinedColumns <- cbind(uEMARow, PredictionRow)
      print("Combine the columns")
      combinedDataframe_2 <- rbind(combinedDataframe_2,combinedColumns)
      ##combinedDataframe_1[[i]] <- combinedColumns
      print("Append to the dataframe")
      k = j
      totalMatches = totalMatches + 1
      break
      
    } else if (deltaTime < 0){
      
      break
    } 
    
    
  }
  
}
print("About to create a data frame")
print("Total matches found: ")
totalMatches
#combinedDataframe_1 <- as.data.frame(do.call("rbind", combinedColumns))
nrow(combinedDataframe_2)

#### Combine the uEMA, counts and predictions data frames
names(combinedDataframe_1)
names(combinedDataframe_2)

#### Perform data mathcing on the wrist files

#### Find closest date time points in actigraph predictions

## start with each row in the uEMA response file
totalMatches = 0
#combinedDataframe_1 <- combinedDataframe_1[c(),]

#combinedDataframe_1 <- as.data.frame()
combinedDataframe_3 = data.frame()

k = 0
for(i in 1:nrow(uEMA01)){
  print(paste0("Starting with the uEMA index: ", i))
  
  ## Get the row for index i
  uEMARow <- uEMA01[i,]
  k = k+1
  
  if (k > nrow(PredictionWrist)){
    break
    
  }
  ## start with each row in predictions file
  for(j in k:nrow(PredictionWrist)){
    print(paste0("Inside the predictions table at index: ", j))
    
    ## Get the row j from prediction file
    PredictionRow <- PredictionWrist[j,]
    
    ## Get the time difference between the date time and header time from the two files
    deltaTime = difftime(uEMARow$ANSWER_TIME, PredictionRow$HEADER_START_TIME_WRIST,   units = "secs")
    print(paste0("Got the time difference to be: ", deltaTime))
    
    ## Check if the header time stamp is after the date time in uEMA responses
    if (deltaTime <= 12.8 & deltaTime >= 0) {
      print("Delta time is within the range")
      ## stop the operation
      ## Save the latest row and append it to a dataframe of uEMARow
      combinedColumns <- cbind(uEMARow, PredictionRow)
      print("Combine the columns")
      combinedDataframe_3 <- rbind(combinedDataframe_3,combinedColumns)
      ##combinedDataframe_1[[i]] <- combinedColumns
      print("Append to the dataframe")
      k = j
      totalMatches = totalMatches + 1
      break
      
    } else if (deltaTime < 0){
      
      break
    } 
    
    
  }
  
}

print("About to create a data frame")
print("Total matches found: ")
totalMatches
#combinedDataframe_1 <- as.data.frame(do.call("rbind", combinedColumns))
nrow(combinedDataframe_3)


#### Find the closest date time points in the counts file with respect to the uEMA responses

totalMatches = 0
# <- combinedDataframe_2[c(),]
combinedDataframe_4 = data.frame()

print("Starting mathcing uEMA and Actigraph counts for ankle")

k = 0
for(i in 1:nrow(uEMA01)){
  print(paste0("Starting with the uEMA index: ", i))
  
  ## Get the row for index i
  uEMARow <- uEMA01[i,]
  k = k+1
  
  if (k > nrow(ActigraphCountsWrist)){
    break
    
  }
  ## start with each row in predictions file
  for(j in k:nrow(ActigraphCountsWrist)){
    print(paste0("Inside the counts table at index: ", j))
    
    ## Get the row j from prediction file
    PredictionRow <- ActigraphCountsWrist[j,]
    
    ## Get the time difference between the date time and header time from the two files
    deltaTime = difftime(uEMARow$ANSWER_TIME, PredictionRow$DATE_TIME_WRIST,   units = "secs")
    print(paste0("Got the time difference to be: ", deltaTime))
    
    ## Check if the header time stamp is after the date time in uEMA responses
    if (deltaTime <= 60 & deltaTime >= 0) {
      print("Delta time is within the range")
      ## stop the operation
      ## Save the latest row and append it to a dataframe of uEMARow
      combinedColumns <- cbind(uEMARow, PredictionRow)
      print("Combine the columns")
      combinedDataframe_4 <- rbind(combinedDataframe_4,combinedColumns)
      ##combinedDataframe_1[[i]] <- combinedColumns
      print("Append to the dataframe")
      k = j
      totalMatches = totalMatches + 1
      break
      
    } else if (deltaTime < 0){
      
      break
    } 
    
    
  }
  
}
print("About to create a data frame")
print("Total matches found: ")
totalMatches
#combinedDataframe_1 <- as.data.frame(do.call("rbind", combinedColumns))
nrow(combinedDataframe_4)



testMerge1_2 <- merge(combinedDataframe_1, combinedDataframe_2)

head(testMerge1_2)
names(testMerge1_2)

testMerge3_4 <- merge(combinedDataframe_3, combinedDataframe_4)

head(testMerge3_4)
names(testMerge3_4)

testMerge1_2 <-testMerge1_2[, c("USER_ID", "ANSWER_TIME", "RESPONSE_TIME", "ACTIVITY_TYPE", "ACTIVITY_CODED", 
                                "ACTIVITY_NUMERIC", "PRED_CLASS_ID_ANKLE", "HEADER_START_TIME_ANKLE", "PRED_CLASS_CODED_ANKLE", 
                                "DATE_TIME_ANKLE","VECTOR_MAGNITUDE_ANKLE")]

names(testMerge1_2)

head(testMerge1_2)

#### Rename column names for readability
names(testMerge1_2) <- c("USER_ID", "UEMA_TIME_STAMP", "UEMA_RESPONSE_TIME", "UEMA_RESPONSE_STRING", "UEMA_RESPONSE_CODED", 
                         "UEMA_RESPONSE_NUMERIC", "PREDICTED_ACTIVITY_CLASS_ANKLE", "PREDICTION_TIME_STAMP_ANKLE", 
                         "PREDICTED_ACTIVITY_CODED_ANKLE", "COUNTS_ANKLE_TIME_STAMP", "COUNTS_ANKLE_MAGNITUDE")

head(testMerge1_2)

#### Do the same for the wrist
colnames(testMerge3_4)[31]<-"VECTOR_MAGNITUDE_WRIST"

names(testMerge3_4)


testMerge3_4 <-testMerge3_4[, c("USER_ID", "ANSWER_TIME", "RESPONSE_TIME", "ACTIVITY_TYPE", "ACTIVITY_CODED", 
                                "ACTIVITY_NUMERIC", "PRED_CLASS_ID_WRIST", "HEADER_START_TIME_WRIST", "PRED_CLASS_CODED_WRIST", 
                                "DATE_TIME_WRIST","VECTOR_MAGNITUDE_WRIST")]

names(testMerge3_4)

head(testMerge3_4)

#### Rename column names for readability
names(testMerge3_4) <- c("USER_ID", "UEMA_TIME_STAMP", "UEMA_RESPONSE_TIME", "UEMA_RESPONSE_STRING", "UEMA_RESPONSE_CODED", 
                         "UEMA_RESPONSE_NUMERIC", "PREDICTED_ACTIVITY_CLASS_WRIST", "PREDICTION_TIME_STAMP_WRIST", 
                         "PREDICTED_ACTIVITY_CODED_WRIST", "COUNTS_WRIST_TIME_STAMP", "COUNTS_WRIST_MAGNITUDE")

head(testMerge3_4)

## Write the merged file to csv

#### Pending ...

sapply(testMerge1_2, class)
sapply(testMerge3_4, class)


#### Do final merge of the data frames
finalDataFrame <- merge(testMerge1_2,testMerge3_4)
head(finalDataFrame)

#### Interactive - combined plots of one to one mapping between uEMA, counts, and predictions
AnkleCountsPlot <- plot_ly(testMerge1_2, x = ~COUNTS_ANKLE_TIME_STAMP, y= ~COUNTS_ANKLE_MAGNITUDE, name = "ANKLE_COUNTS", 
                           legendgroup = "ANKLE", type = "bar")

AnklePredictionsPlot <- plot_ly(testMerge1_2, x = ~PREDICTION_TIME_STAMP_ANKLE, y= ~PREDICTED_ACTIVITY_CODED, name = "PREDICTIONS_ANKLE", 
                                legendgroup = "PREDICTIONS_ANKLE", type = "bar")

EMAResponsesPlot <- plot_ly(testMerge1_2, x=~UEMA_TIME_STAMP, y=~UEMA_RESPONSE_NUMERIC, name = "uEMA_RESPONSES", 
                            legendgroup = "uEMA", type = "bar")%>% layout(xaxis = list(range = as.POSIXct(c('2018-02-02 00:00:00', '2018-02-09 23:00:00'))))

subplot(style(AnkleCountsPlot, showlegend = TRUE), style(AnklePredictionsPlot, showlegend = TRUE), 
        style(EMAResponsesPlot, showlegend = TRUE), nrows = 3, margin = 0.05)


#### Get raw and unmapped plots on ggplot2

## Mapped plots
ggplotAnkleCounts <- ggplot(finalDataFrame, aes(COUNTS_ANKLE_TIME_STAMP, COUNTS_ANKLE_MAGNITUDE)) + 
  geom_bar(stat="identity", fill = "deeppink3") + xlab("Date-Time") + ylab("Activity counts") +
  ggtitle("Ankle counts from Actigraph") + 
  theme(plot.title = element_text(lineheight=.8, face="bold", size = 10)) +
  theme(text = element_text(size=10))

ggplotAnkleCounts

ggplotPredictionAnkle <- ggplot(finalDataFrame, aes(PREDICTION_TIME_STAMP_ANKLE, PREDICTED_ACTIVITY_CODED_ANKLE)) + 
  geom_bar(stat="identity", fill = "dodgerblue4") + xlab("Date-Time") + ylab("Activity prediction") +
  ggtitle("Activity prediction on ankle") + 
  theme(plot.title = element_text(lineheight=.8, face="bold", size = 10)) +
  theme(text = element_text(size=10))

ggplotPredictionAnkle

ggplotuEMAResponses <- ggplot(finalDataFrame, aes(UEMA_TIME_STAMP, UEMA_RESPONSE_NUMERIC)) + 
  geom_bar(stat="identity", fill = "grey14") + xlab("Date-Time") + ylab("uEMA responses") +
  ggtitle("Responses on uEMA prompts") + 
  theme(plot.title = element_text(lineheight=.8, face="bold", size = 10)) +
  theme(text = element_text(size=10))

ggplotuEMAResponses

ggplotWristCounts <- ggplot(finalDataFrame, aes(COUNTS_WRIST_TIME_STAMP, COUNTS_WRIST_MAGNITUDE)) + 
  geom_bar(stat="identity", fill = "yellowgreen") + xlab("Date-Time") + ylab("Activity counts") +
  ggtitle("Wrist counts from Actigraph") + 
  theme(plot.title = element_text(lineheight=.8, face="bold", size = 10)) +
  theme(text = element_text(size=10))

ggplotWristCounts

ggplotPredictionWrist <- ggplot(finalDataFrame, aes(PREDICTION_TIME_STAMP_WRIST, PREDICTED_ACTIVITY_CODED_WRIST)) + 
  geom_bar(stat="identity", fill = "brown3") + xlab("Date-Time") + ylab("Activity prediction") +
  ggtitle("Activity prediction on wrist") + 
  theme(plot.title = element_text(lineheight=.8, face="bold", size = 10)) +
  theme(text = element_text(size=10))

ggplotPredictionWrist

#### get multiple plots into one

#### define the multiplot function

# Multiple plot function
#
# ggplot objects can be passed in ..., or to plotlist (as a list of ggplot objects)
# - cols:   Number of columns in layout
# - layout: A matrix specifying the layout. If present, 'cols' is ignored.
#
# If the layout is something like matrix(c(1,2,3,3), nrow=2, byrow=TRUE),
# then plot 1 will go in the upper left, 2 will go in the upper right, and
# 3 will go all the way across the bottom.
#
multiplot <- function(..., plotlist=NULL, file, rows=1, layout=NULL) {
  library(grid)
  
  # Make a list from the ... arguments and plotlist
  plots <- c(list(...), plotlist)
  
  numPlots = length(plots)
  
  # If layout is NULL, then use 'cols' to determine layout
  if (is.null(layout)) {
    # Make the panel
    # ncol: Number of columns of plots
    # nrow: Number of rows needed, calculated from # of cols
    layout <- matrix(seq(1, rows * ceiling(numPlots/rows)),
                     nrow = rows, ncol = ceiling(numPlots/rows))
  }
  
  if (numPlots==1) {
    print(plots[[1]])
    
  } else {
    # Set up the page
    grid.newpage()
    pushViewport(viewport(layout = grid.layout(nrow(layout), ncol(layout))))
    
    # Make each plot, in the correct location
    for (i in 1:numPlots) {
      # Get the i,j matrix positions of the regions that contain this subplot
      matchidx <- as.data.frame(which(layout == i, arr.ind = TRUE))
      
      print(plots[[i]], vp = viewport(layout.pos.row = matchidx$row,
                                      layout.pos.col = matchidx$col))
    }
  }
}

multiplot(ggplotAnkleCounts, ggplotPredictionAnkle, ggplotWristCounts,ggplotPredictionWrist, ggplotuEMAResponses, rows = 5)

#### Interactive plots for mapped responses

mAnkleCounts <- plot_ly(finalDataFrame, x = ~COUNTS_ANKLE_TIME_STAMP, y= ~COUNTS_ANKLE_MAGNITUDE, name = "ANKLE_COUNTS", 
                           legendgroup = "ANKLE", type = "bar")

mWristCounts <- plot_ly(finalDataFrame, x = ~COUNTS_WRIST_TIME_STAMP, y= ~COUNTS_WRIST_MAGNITUDE, name = "WRIST_COUNTS", 
                        legendgroup = "WRIST", type = "bar")

mAnklePredictionsPlot <- plot_ly(finalDataFrame, x = ~PREDICTION_TIME_STAMP_ANKLE, y= ~PREDICTED_ACTIVITY_CODED_ANKLE, name = "PREDICTIONS_ANKLE", 
                                legendgroup = "PREDICTIONS_ANKLE", type = "bar")

mWristPredictionsPlot <- plot_ly(finalDataFrame, x = ~PREDICTION_TIME_STAMP_WRIST, y= ~PREDICTED_ACTIVITY_CODED_WRIST, name = "PREDICTIONS_WRIST", 
                                 legendgroup = "PREDICTIONS_WRIST", type = "bar")

mEMAResponsesPlot <- plot_ly(finalDataFrame, x=~UEMA_TIME_STAMP, y=~UEMA_RESPONSE_NUMERIC, name = "uEMA_RESPONSES", 
                            legendgroup = "uEMA", type = "bar")%>% layout(xaxis = list(range = as.POSIXct(c('2018-02-02 00:00:00', '2018-02-09 23:00:00'))))

subplot(style(mAnkleCounts, showlegend = TRUE), style(mAnklePredictionsPlot, showlegend = TRUE),
        style(mWristCounts, showlegend = TRUE), style(mWristPredictionsPlot, showlegend = TRUE),
        style(mEMAResponsesPlot, showlegend = TRUE), nrows = 5, margin = 0.05)



