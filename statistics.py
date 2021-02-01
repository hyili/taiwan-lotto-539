#!/usr/bin/env python3

import csv
import datetime
import sys
import matplotlib.pyplot as plt
from math import pi

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

    for date in data:
        dt = datetime.datetime.strptime(date, dt_format)
        if st_dt <= dt and en_dt >= dt:
            result[date] = data[date]

    return result

def printData(data):
    print("Key:{0}, Value:{1}".format(date, str(data[date])))


def cal2Star(data, number=5, reverse=True):
    result = [[0] * 40 for i in range(40)]
    s = 0
    ordered_list = list()

    for date in data:
        for i in range(0, 5, 1):
            for j in range(i+1, 5, 1):
                result[data[date][i]][data[date][j]] += 1

    for i in range(1, 40, 1):
        for j in range(i+1, 40, 1):
            s += result[i][j]
            ordered_list.append((result[i][j], (i, j)))

    def takeFirst(ele):
        return ele[0]

    ordered_list.sort(key=takeFirst, reverse=reverse)
    for i in range(0, min(len(ordered_list), number), 1):
        print(" [-] {0}".format(ordered_list[i]))

    return s


def cal3Star(data, number=5, reverse=True):
    result = [[[0] * 40 for i in range(40)] for j in range(40)]
    s = 0
    ordered_list = list()

    for date in data:
        for i in range(0, 5, 1):
            for j in range(i+1, 5, 1):
                for k in range(j+1, 5, 1):
                    result[data[date][i]][data[date][j]][data[date][k]] += 1

    for i in range(1, 40, 1):
        for j in range(i+1, 40, 1):
            for k in range(j+1, 40, 1):
                s += result[i][j][k]
                ordered_list.append((result[i][j][k], (i, j, k)))

    def takeFirst(ele):
        return ele[0]

    ordered_list.sort(key=takeFirst, reverse=reverse)
    for i in range(0, min(len(ordered_list), number), 1):
        print(" [-] {0}".format(ordered_list[i]))

    return s


def cal4Star(data, number=5, reverse=True):
    result = [[[[0] * 40 for i in range(40)] for j in range(40)] for k in range(40)]
    s = 0
    ordered_list = list()

    for date in data:
        for i in range(0, 5, 1):
            for j in range(i+1, 5, 1):
                for k in range(j+1, 5, 1):
                    for l in range(k+1, 5, 1):
                        result[data[date][i]][data[date][j]][data[date][k]][data[date][l]] += 1

    for i in range(1, 40, 1):
        for j in range(i+1, 40, 1):
            for k in range(j+1, 40, 1):
                for l in range(k+1, 40, 1):
                    s += result[i][j][k][l]
                    ordered_list.append((result[i][j][k][l], (i, j, k, l)))

    def takeFirst(ele):
        return ele[0]

    ordered_list.sort(key=takeFirst, reverse=reverse)
    for i in range(0, min(len(ordered_list), number), 1):
        print(" [-] {0}".format(ordered_list[i]))

    return s


def calFreq(data, filename):
    result = [0] * 40
    maximum = 0

    for date in data:
        for i in range(0, 5, 1):
            result[data[date][i]] += 1

    for i in range(1, 40, 1):
        maximum = max(maximum, result[i])

    # Part 1
    N = 39
    angles = [n / float(N) * 2 * pi for n in range(N)]
    angles += angles[:1]

    ax = plt.subplot(111, polar=True)
    ax.set_theta_offset(pi / 2)
    ax.set_theta_direction(-1)

    plt.xticks(angles[:-1], [i for i in range(1, 40, 1)])

    ax.set_rlabel_position(0)
    plt.ylim(0, maximum)

    # Part 2
    ax.plot(angles, result[1:]+result[1:2], linewidth=1, linestyle="solid", label="counts")
    ax.fill(angles, result[1:]+result[1:2], "b", alpha=0.1)

    # Part 3
    plt.legend(loc="upper right", bbox_to_anchor=(0.1, 0.1))

    # Part 4
    plt.savefig(filename, transparent=True)


if __name__ == "__main__":
    args = sys.argv
    dt_format = "%Y-%m-%d"
    st_dt = datetime.datetime.strptime(args[1], dt_format)
    en_dt = min(datetime.datetime.now(), datetime.datetime.strptime(args[2], dt_format))
    data = filter(read_input("daily-cash-539.csv"), st_dt, en_dt)

    s = len(data)
    print(" [*] 從{0}到{1}，共開出了{2}期.".format(st_dt.strftime(dt_format), en_dt.strftime(dt_format), s))
    print("")
    
    # printData(data, st_dt, en_dt)
    print(" [*] 其中2星出現次數前{0}為".format(args[3]))
    print(" [-] (出現次數, (第一個數, 第二個數))".format(args[3]))
    s = cal2Star(data, number=int(args[3]), reverse=True)
    print(" [*] 期間共出現過{0}組2星".format(s))
    print("")

    print(" [*] 其中3星出現次數前{0}為".format(args[3]))
    print(" [-] (出現次數, (第一個數, 第二個數, 第三個數))".format(args[3]))
    s = cal3Star(data, number=int(args[3]), reverse=True)
    print(" [*] 期間共出現過{0}組3星".format(s)) 
    print("")

    print(" [*] 其中4星出現次數前{0}為".format(args[3]))
    print(" [-] (出現次數, (第一個數, 第二個數, 第三個數, 第四個數))".format(args[3]))
    s = cal4Star(data, number=int(args[3]), reverse=True)
    print(" [*] 期間共出現過{0}組4星".format(s)) 
    print("")

    calFreq(data, args[4])
