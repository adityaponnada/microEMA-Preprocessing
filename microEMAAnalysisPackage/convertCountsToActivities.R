library(MASS)
library(dplyr)
library(reshape2)



#### for ten seconds #####

## Sedentary: [0.00, 330.1)
## Light/Standing: [330.1, 1096.66)
## Moderate/Walking: [1096.66, 2180.37)
## Vigorous: [2180.37, 5400.00)


combinedFile$COUNTS_ACTIVITY[combinedFile$COUNTS_SUM_ANKLE_BEFORE >= 0.00 & combinedFile$COUNTS_SUM_ANKLE_BEFORE < 330.01] <- "Sedentary"
combinedFile$COUNTS_ACTIVITY[combinedFile$COUNTS_SUM_ANKLE_BEFORE >= 330.01 & combinedFile$COUNTS_SUM_ANKLE_BEFORE < 1096.66] <- "Light/Standing"
combinedFile$COUNTS_ACTIVITY[combinedFile$COUNTS_SUM_ANKLE_BEFORE >= 1096.66 & combinedFile$COUNTS_SUM_ANKLE_BEFORE < 2180.37] <- "Moderate/Walking"
combinedFile$COUNTS_ACTIVITY[combinedFile$COUNTS_SUM_ANKLE_BEFORE >= 2180.37 & combinedFile$COUNTS_SUM_ANKLE_BEFORE < 5400.00] <- "Vigorous"


combinedFile$COUNTS_ACTIVITY <- as.factor(combinedFile$COUNTS_ACTIVITY)
