#### Include library

library(psych)
library(MASS)
library(ggplot2)
library(plotly)

### read the annotation file for the participant

annotationPath = "C:/Users/Dharam/Downloads/microEMA/StudyFiles/SPADES_ACTIVITY_COUNT/SPADES_2/SPADES_2_SPADESInLab_merged.csv"


annotationFile <- read.csv(annotationPath, sep = ",", header = FALSE)

colnames(annotationFile) <- c("HEADER_START_TIME", "HEADER_STOP_TIME", "ANNOTATION")

#### Convert date time into date time object

annotationFile$HEADER_START_TIME <- as.POSIXct(annotationFile$HEADER_START_TIME, format = "%m/%d/%Y %H:%M:%S")
annotationFile$HEADER_STOP_TIME <- as.POSIXct(annotationFile$HEADER_STOP_TIME, format = "%m/%d/%Y %H:%M:%S")

##four.digit.year(annotationFile$HEADER_START_TIME, year = 1968)

class(annotationFile$ANNOTATION)

levels(annotationFile$ANNOTATION)

#### Convert the labels to the following categories: Sedentary, Light/Standing, Moderate/Walking, Vigorous

annotationFile$CATEGORY <- NA

for (i in 1:nrow(annotationFile)){
  
  if(grepl("Sitting", annotationFile$ANNOTATION[i]) == TRUE){
    
    annotationFile$CATEGORY[i] <- "Sedentary"
    
  } else if (grepl("Biking", annotationFile$ANNOTATION[i]) == TRUE){
    annotationFile$CATEGORY[i] <- "Vigorous"
    
    
  } else if (grepl("Standing", annotationFile$ANNOTATION[i]) == TRUE){
    annotationFile$CATEGORY[i] <- "Light/Standing"
    
    
  } else if (grepl("Walking", annotationFile$ANNOTATION[i]) == TRUE){
    annotationFile$CATEGORY[i] <- "Moderate/Walking"
    
    
  } else if (grepl("Running", annotationFile$ANNOTATION[i]) == TRUE){
    annotationFile$CATEGORY[i] <- "Vigorous"
    
    
  } else if (grepl("Reclining", annotationFile$ANNOTATION[i]) == TRUE){
    annotationFile$CATEGORY[i] <- "Sedentary"
    
    
  } else if (grepl("Lying", annotationFile$ANNOTATION[i]) == TRUE){
    annotationFile$CATEGORY[i] <- "Sedentary"
    
    
  } else if (grepl("Jumping Jacks", annotationFile$ANNOTATION[i]) == TRUE){
    annotationFile$CATEGORY[i] <- "Vigorous"
    
    
  } else if (grepl("Still", annotationFile$ANNOTATION[i]) == TRUE){
    annotationFile$CATEGORY[i] <- "Sedentary"
    
    
  } else {
    annotationFile$CATEGORY[i] <- "Not Sure"
    
    
    }
    
}


head(annotationFile)

#### Add time difference
annotationFile$DURATION <- as.numeric(difftime(annotationFile$HEADER_STOP_TIME,annotationFile$HEADER_START_TIME, units = "secs" ))
  
### Get subset with only meaningful labels
toBeRemoved<-which(annotationFile$CATEGORY=="Not Sure")
annotationFile<-annotationFile[-toBeRemoved,]
  
