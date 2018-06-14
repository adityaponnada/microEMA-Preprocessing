library(rmcorr)

rmcorr(USER_ID, ACTIVITY_NUMERIC, COUNTS_SUM_ANKLE_BEFORE, combinedFile, CIs = c("analytic",
                                                                                 "bootstrap"), nreps = 50, bstrap.out = F)
