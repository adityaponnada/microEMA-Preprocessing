library(psych)
library(MASS)
library(dplyr)
library(plyr)
options(digits.secs=3)

uEMAParticipantAnsweredPrompts$FINAL_PREDICTED_ACTIVITY <- NA

# headPredictions <- head(predictedActivities, 10000)
# headuEMA <- head(uEMAParticipantAnsweredPrompts, 10)

timeBefore = 600

k = 0

for (i in 1:nrow(uEMAParticipantAnsweredPrompts)){
  print(paste0("uEMA index is: ", i))
  uEMAPickedRow <- uEMAParticipantAnsweredPrompts[i,]
  
  k = k + 1
  
  if (k > nrow(predictedActivities)){
    print("Maxed out in the prediction file ... exiting")
    break
  }
  
  print("Creating a temporary data frame")
  tempDataFrame = data.frame()
  
  for (j in k:nrow(predictedActivities)){
    print(paste0("Prediction index is: ", j, " for uEMA index of ", i))
    
    predictionsPickedRow <- predictedActivities[j,]
    
    timeDifference = difftime(uEMAPickedRow$PROMPT_TIME, predictionsPickedRow$HEADER_START_TIME, units = "secs")
    
    if (timeDifference <= timeBefore & timeDifference >=0){
      print(paste0("Time difference within range ", timeDifference, " for index: ", i))
      #### Add these to a temp data frame
      tempDataFrame <- rbind(tempDataFrame, predictionsPickedRow)
      
      totalRows = nrow(tempDataFrame)
      class1_pred = sum(tempDataFrame$PRED_CLASS_1_PROB)/totalRows
      print(paste0("Class 1: ", class1_pred))
      class2_pred = sum(tempDataFrame$PRED_CLASS_2_PROB)/totalRows
      print(paste0("Class 2: ", class2_pred))
      class3_pred = sum(tempDataFrame$PRED_CLASS_3_PROB)/totalRows
      print(paste0("Class 3: ", class3_pred))
      class4_pred = sum(tempDataFrame$PRED_CLASS_4_PROB)/totalRows
      print(paste0("Class 4: ", class4_pred))
      
      listOfClass = c(class1_pred, class2_pred, class3_pred, class4_pred)
      
      if (which.max(listOfClass) == 1){
        uEMAParticipantAnsweredPrompts$FINAL_PREDICTED_ACTIVITY[i] <- 4
        print("It is 4")
      } else if (which.max(listOfClass) == 2){
        uEMAParticipantAnsweredPrompts$FINAL_PREDICTED_ACTIVITY[i] <- 3
        print("It is 3")
      } else if (which.max(listOfClass) == 3){
        uEMAParticipantAnsweredPrompts$FINAL_PREDICTED_ACTIVITY[i] <- 2
        print("It is 2")
      } else if (which.max(listOfClass) == 4){
        uEMAParticipantAnsweredPrompts$FINAL_PREDICTED_ACTIVITY[i] <- 1
        print("It is 1")
      }
      
      k = j
      
    } else if (timeDifference < 0) {
      
      print("Time difference is negative ... exiting")
      
      break
      
    }
    
    
  }
  
  print(paste0("i is ", i))
}


head(uEMAParticipantAnsweredPrompts)
