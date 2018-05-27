#### Use this script to get count values from windows before a prompt in uEMA

#### Import libraries
library(psych)
library(ggplot2)
library(plotly)
library(MASS)
library(plyr)
options(digits.secs=3)


timeBefore = 10

combinedAnkleEMA <- uEMAParticipantAnsweredPrompts
combinedAnkleEMA$COUNTS_AVERAGE_ANKLE_BEFORE <- NA
#combinedAnkleEMA[1,]$COUNTS_AVERAGE_ANKLE_BEFORE <- 0


###################### Raw code ###################

k=0

for (i in 1:nrow(uEMAParticipantAnsweredPrompts)){
  print(paste0("Starting with the uEMA index: ", i))
  uEMAPickedRow <- uEMAParticipantAnsweredPrompts[i,]
  
  k = k+1
  
  if (k > nrow(uEMAAnkleCounts)){
    print("Maxed out in the second file ... exiting")
    break
    
  }
  print("creating a temporary data frame")
  tempDataFrame = data.frame()
  
  for (j in k:nrow(uEMAAnkleCounts)){
    print(paste0("Starting with the second file index: ", j, " and k is: ", k))
    
    countsPickedRow <- uEMAAnkleCounts[j,]
    
    timeDifference = difftime(uEMAPickedRow$PROMPT_TIME, countsPickedRow$DATE_TIME_ANKLE,   units = "secs")
    print(paste0("The time difference is: ", timeDifference))
    
    if (timeDifference <= timeBefore & timeDifference >= 0){
      
      print(paste0("Time difference is within the range at ", "j = ", j, " k = ", k, " for i = ", i))
      
      ## Add all these rows in a temporary data frame
      tempDataFrame <- rbind(tempDataFrame, countsPickedRow)
      print("Get average counts")
      
      countsSum = sum(tempDataFrame$COUNTS_MAGNITUDE_ANKLE)
      print("Assign average as a new column")
      
      print(paste0("CountsAverage is: ", countsSum))
      
      combinedAnkleEMA$COUNTS_AVERAGE_ANKLE_BEFORE[i] <- countsSum
      #tempAverages[i,] <- i
      k = j
     
      
    } else if (timeDifference < 0) {
      print("Time difference negative ... exiting")
      
      break
    }
    
    
  }
  
  print(paste0("i is: ", i))
  
}

#tempMicroEMA$COUNTS_AVERAGE_ANKLE_BEFORE <- tempAverages

head(combinedAnkleEMA)

#### get windows for wrist counts
#### get windowed avergaes from the time before the promt - Ankle
timeBefore = 10

combinedWristEMA <- uEMAParticipantAnsweredPrompts
combinedWristEMA$COUNTS_AVERAGE_WRIST_BEFORE <- NA
#combinedAnkleEMA[1,]$COUNTS_AVERAGE_ANKLE_BEFORE <- 0


###################### Raw code ###################

k=0

for (i in 1:nrow(uEMAParticipantAnsweredPrompts)){
  print(paste0("Starting with the uEMA index: ", i))
  uEMAPickedRow <- uEMAParticipantAnsweredPrompts[i,]
  
  k = k+1
  
  if (k > nrow(uEMAWristCounts)){
    print("Maxed out in the second file ... exiting")
    break
    
  }
  print("creating a temporary data frame")
  tempDataFrame = data.frame()
  
  for (j in k:nrow(uEMAWristCounts)){
    print(paste0("Starting with the second file index: ", j, " and k is: ", k))
    
    countsPickedRow <- uEMAWristCounts[j,]
    
    timeDifference = difftime(uEMAPickedRow$PROMPT_TIME, countsPickedRow$DATE_TIME_ANKLE,   units = "secs")
    print(paste0("The time difference is: ", timeDifference))
    
    if (timeDifference <= timeBefore & timeDifference >= 0){
      
      print(paste0("Time difference is within the range at ", "j = ", j, " k = ", k, " for i = ", i))
      
      ## Add all these rows in a temporary data frame
      tempDataFrame <- rbind(tempDataFrame, countsPickedRow)
      print("Get average counts")
      
      countsSum = sum(tempDataFrame$COUNTS_MAGNITUDE_WRIST)
      print("Assign average as a new column")
      
      print(paste0("CountsAverage is: ", countsSum))
      
      combinedWristEMA$COUNTS_AVERAGE_WRIST_BEFORE[i] <- countsSum
      #tempAverages[i,] <- i
      k = j
      
      
    } else if (timeDifference < 0) {
      print("Time difference negative ... exiting")
      
      break
    }
    
    
  }
  
  print(paste0("i is: ", i))
  
}

#tempMicroEMA$COUNTS_AVERAGE_ANKLE_BEFORE <- tempAverages

head(combinedWristEMA)




