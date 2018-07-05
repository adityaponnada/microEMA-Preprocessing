library(psych)

ankleData$CLASSIFIED_ACTIVITY <- as.factor(ankleData$CLASSIFIED_ACTIVITY)

categoryCounts <- summary(ankleData$CLASSIFIED_ACTIVITY)

categoryCounts <- t(categoryCounts)

categoryCounts <- as.data.frame(categoryCounts)

categoryCounts$USER_ID <- username
