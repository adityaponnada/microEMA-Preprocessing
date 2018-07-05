library(psych)

wakingHoursData$CLASSIFIED_ACTIVITY <- as.factor(wakingHoursData$CLASSIFIED_ACTIVITY)

categoryCounts <- summary(wakingHoursData$CLASSIFIED_ACTIVITY)

categoryCounts <- t(categoryCounts)

categoryCounts <- as.data.frame(categoryCounts)

categoryCounts$USER_ID <- username
