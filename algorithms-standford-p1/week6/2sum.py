#!/usr/bin/python
#
# Solves a variant of the 2Sum problem.
#
# 2Sum problem: given a list of integers a, and an integer t, does a contain two (distinct) integers
# x and y such that x + y = t. This algorithm solves this by dropping the integers into a
# dictionary and iterating over it to find possible x values. It then checks to see if the dictionary
# contains t-x (which is y). This is the twoSum function below and runs in O(n).
#
# For the coursera assignment, we want to count how many of the target values t [-10000,10000] can be
# summed to via two integers x and y in the given input file. See the twoSumOverRange function below.
#
# The given code solved this problem in 106 minutes for the given input required by the coursera assignment,
# this was expected for python solutions based on feedback on the course forum. The overall runtime for this
# is O(20000*n) = O(n)...just with a big constant which slows it down.
#

import time

def readInput(f):
    l = {}
    for line in f:
        l[int(line)] = 1
    return l

def twoSum(a, t):
    for x in a:
        y = t - x
        if y!=x and y in a:
            #print "t=", t, "(", x, ",", y, ")"
            return True
    return False

def twoSumOverRange(a, t1, t2):
    start = time.clock()
    numSuccessfulTargets = 0
    for i in range(t1, t2 + 1):
        if twoSum(a, i):
            numSuccessfulTargets += 1
        if i % 1000 == 0:
            lap = time.clock()
            minutes = (lap-start)/60
            print "current t finished:", i, "current run time:", minutes, "current successful targets:", numSuccessfulTargets

    end = time.clock()
    minutes = (end-start)/60
    print "DONE"
    print "total algorithm time:", minutes
    print "number of successful targets t for values of t in [", t1, ",", t2, "]:", numSuccessfulTargets

def main():

    f = open('2sum-input.txt', 'r') # expected result: 427
    l = readInput(f)
    twoSumOverRange(l, -10000, 10000)


if __name__ == '__main__':
    main()
