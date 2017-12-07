#!/usr/bin/env python
# -*- coding: utf-8 -*-
# author: zhiguohong@tencent.com

import sys
import operator

skip=3

# bytes MB/s us
# 64 43.1 200
def load_data(file):
    tb = []
    lines = [line.rstrip('\n') for line in open(file)]
    for line in lines:
        if "%" in line:
            continue
        if "Average" in line:
            continue
        if line.startswith("Linux"):
            continue
        line = line.strip()
        if len(line) == 0:
            continue;
        tokens = line.split()
        data = [0.0, 0.0, 0.0, 0.0]
        # usr
        data[0] = float(tokens[3])
        # sys
        data[1] = float(tokens[5])
        #si
        data[2] = float(tokens[8])
        #idle
        data[3] = float(tokens[12])
	tb.append(data)
    return tb

def sum(tbl, sum):
    n = len(tbl)
    for i in range(n):
        for j in range(4):
            sum[i][j] = sum[i][j] + tbl[i][j]

if __name__ == '__main__':
    avg = []
    files = sys.argv[1:]
    for file in files:
        tb = load_data(file)
        if not avg:
            avg = tb
            continue
        if len(avg) < len(tb):
            tb = tb[:len(avg)] 
        if len(avg) > len(tb):
            avg = avg[:len(tb)]
        # now they are same length
        sum(tb, avg)


    n = len(files)
    for i in range(len(avg)):
        for j in range(4):
            avg[i][j] = avg[i][j] / n
    

    print "# sec usr sys si idle "
    for i in range(len(avg)):
        print i+1, " ",
        for j in range(4):
            str = "%.2f " % (avg[i][j])
	    print str,
        print ""
	


