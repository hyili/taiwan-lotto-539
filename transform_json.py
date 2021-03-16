#!/usr/bin/env python3

import csv
import datetime
import sys
import json
import matplotlib.pyplot as plt
from math import pi

dt_format = "%Y-%m-%d"

def read_input(filename):
    data = dict()

    with open(filename, "r", newline="") as f:        
        rows = csv.DictReader(f)

        # Draw,Date,Winning Number 1,2,3,4,5,From Last,Same As Day,Odd,Even, 1-10, 11-20, 21-30, 31-40,Division 1 Winners,Division 1 Prize,Division 2 Winners,Division 2 Prize,Division 3 Winners,Division 3 Prize,Division 4 Winners,Division 4 Prize
        for row in rows:
            data[row["Date"]] = list()
            data[row["Date"]].append(int(row["Winning Number 1"]))
            data[row["Date"]].append(int(row["2"]))
            data[row["Date"]].append(int(row["3"]))
            data[row["Date"]].append(int(row["4"]))
            data[row["Date"]].append(int(row["5"]))

    return data

def filter(data, st_dt, en_dt):
    result = dict()
    newest = st_dt

    for date in data:
        dt = datetime.datetime.strptime(date, dt_format)
        if st_dt <= dt and en_dt >= dt:
            result[date] = data[date]
            if newest < dt:
                newest = dt

    return result, newest.strftime(dt_format)

def printData(data):
    print("Key:{0}, Value:{1}".format(date, str(data[date])))


if __name__ == "__main__":
    args = sys.argv
    st_dt = datetime.datetime.strptime(args[1], dt_format)
    en_dt = min(datetime.datetime.now(), datetime.datetime.strptime(args[2], dt_format))
    data, newest = filter(read_input("daily-cash-539.csv"), st_dt, en_dt)
    with open("data_json/{0}_{1}.json".format(args[1], args[2]), "w") as f:
        jso = json.dumps(data)
        f.write(str(jso))
