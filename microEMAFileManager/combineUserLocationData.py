import pandas as pd
# from datetime import datetime
import datetime
import numpy as np
import glob,os
from copy import deepcopy


def mhealth_timestamp_parser(str):
    MHEALTH_TIMESTAMP_FORMAT = "%m/%d/%Y %H:%M:%S.%f"
    return datetime.datetime.strptime(str, MHEALTH_TIMESTAMP_FORMAT)

inPath = "C:/Users/Dharam/Downloads/Wockets-win32-x64_updated_v1/Wockets-win32-x64/resources/app/src/srv/MICROPA/uema30@micropa_com/"

##uEMAInFile = "Watch-PromptActivity.log.csv" ## Use it when concatinating uEMA responses
##undoInFile = "Watch-UndoActionLogs.log.csv" ## Use it when concatinating UndoResponse Files
##undoOutFile = "uEMAUndoResponses.csv" ## Use it when concatinating UndoResponse Files
##uEMAOutFile = "uEMAPromptResponses.csv" ## Use it when concatinating uEMA responses

user_name = "uema30@micropa_com"

outPath = "C:/Users/Dharam/Downloads/microEMA/StudyFiles/Responses_uEMA/Location/uema30_loc/"

count = 0

first = True
for path in glob.glob(os.path.join(inPath,"data/*/*/GPS.csv")):
    #subNow=os.path.basename(path)
    #print(subNow)
    print('Reading ...' + path)

    # df = pd.read_csv(path, header=None, sep=',', compression="infer", quotechar='"', parse_dates=[3,4], date_parser=mhealth_timestamp_parser)
    try:
        df = pd.read_csv(path, header=None, sep=',', compression="infer", quotechar='"')
        if first:
            first = False
            relevant_df = df
        else:
            relevant_df = pd.concat([relevant_df, df], axis=0, join='outer', ignore_index=True)

    except:
        continue


relevant_df.columns = ['LOG_TIME','HEADER_TIME','LAT','LONG','ACC']
relevant_df = relevant_df[['LOG_TIME','HEADER_TIME','LAT','LONG','ACC']]
relevant_df.insert(0, 'USER_ID', user_name)
relevant_df.to_csv(os.path.join(outPath,"location.csv"),index=False)


