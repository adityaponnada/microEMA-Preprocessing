library(rmcorr)

reactDataFrame <- combinedFile

reactDataFrame$DIFF_ANKLE_COUNTS <- reactDataFrame$COUNTS_SUM_ANKLE_BEFORE - reactDataFrame$COUNTS_SUM_ANKLE_AFTER


rmcorr(USER_ID, DIFF_ANKLE_COUNTS, RESPONSE_TIME, reactDataFrame, CIs = c("analytic",
                                                                                 "bootstrap"), nreps = 100, bstrap.out = F)
