import pandas as pd
# from datetime import datetime
import datetime
import numpy as np
import glob,os
from copy import deepcopy


def mhealth_timestamp_parser(str):
    MHEALTH_TIMESTAMP_FORMAT = "%m/%d/%Y %H:%M:%S.%f"
    return datetime.datetime.strptime(str, MHEALTH_TIMESTAMP_FORMAT)

inPathLab = "C:/Users/Dharam/Downloads/microEMA/StudyFiles/CombinedData/"



outPathLab = "C:/Users/Dharam/Downloads/microEMA/StudyFiles/CombinedData/"

count = 0

first = True
for path in glob.glob(os.path.join(inPathLab,"uema*/mappedPredictions_600.csv")):
    #subNow=os.path.basename(path)
    #print(subNow)
    print('Reading ...' + path)

    # df = pd.read_csv(path, header=None, sep=',', compression="infer", quotechar='"', parse_dates=[3,4], date_parser=mhealth_timestamp_parser)
    try:
        print('before reading')
        df = pd.read_csv(path, header=0, sep=',', compression="infer", quotechar='"')
        print('done reading')
        if first:
            first = False
            relevant_df = df
        else:
            relevant_df = pd.concat([relevant_df, df], axis=0, join='outer', ignore_index=True)

    except:
        continue

relevant_df.columns = ['USER_ID','PROMPT_TIME','ANSWER_TIME','RESPONSE_TIME','ACTIVITY_TYPE','FINAL_PREDICTED_ACTIVITY','PREDICTED_ACTIVITY_TYPE']
relevant_df = relevant_df[['USER_ID','PROMPT_TIME','ANSWER_TIME','RESPONSE_TIME','ACTIVITY_TYPE','FINAL_PREDICTED_ACTIVITY','PREDICTED_ACTIVITY_TYPE']]
relevant_df.to_csv(os.path.join(outPathLab,"predictions_600.csv"),index=False)


