#!/usr/bin/python
#
# Uses two heaps to find the rolling median from a stream of integers (read in via file).
# Outputs the total of the medians (and the total mod 1000 as required by the homework).
#
# http://stackoverflow.com/questions/10657503/find-running-median-from-a-stream-of-integers
#

import heapq

def medianOfMedians(f):
    hLow = [] # a max-heap (take inverse of all input and just use built in min-heap)
    hHigh = [] # a min-heap
    medianSums = 0
    for line in f:
        x = int(line)

        # put the element in the appropriate heap based on current median
        if len(hLow) == 0:
            heapq.heappush(hLow, -x)
        elif len(hHigh) == 0:
            # might have to insert into hLow depend on x
            maxLeft = -heapq.nsmallest(1, hLow)[0]
            if (x < maxLeft):
                heapq.heappop(hLow)
                heapq.heappush(hLow, -x)
                heapq.heappush(hHigh, maxLeft)
            else:
                heapq.heappush(hHigh, x)
        else:
            maxLeft = -heapq.nsmallest(1, hLow)[0]
            minRight = heapq.nsmallest(1, hHigh)[0]
            if x < minRight:
                heapq.heappush(hLow, -x)
            else:
                heapq.heappush(hHigh, x)

        # balance appropriately (left half heap should be no more than one bigger than right half heap)
        if len(hLow) > len(hHigh) + 1:
            elInv = heapq.heappop(hLow)
            heapq.heappush(hHigh, -elInv)
        elif len(hHigh) > len(hLow):
            el = heapq.heappop(hHigh)
            heapq.heappush(hLow, -el)

        curMedian = -heapq.nsmallest(1, hLow)[0]
        #print hLow, hHigh, curMedian
        medianSums += curMedian

    print "Total sum of medians:", medianSums
    print "Sum mod 10000:", medianSums % 10000

def main():
    f = open('Median.txt', 'r') #expected result: 46831213 (1213)
    #f = open('medianTest1.txt', 'r') #expected result: 54
    #f = open('medianTest2.txt', 'r') #expected result: 23
    #f = open('medianTest3.txt', 'r') #expected result: 82
    #f = open('medianTest4.txt', 'r') #expected result: 31468 (1468)
    medianOfMedians(f)

if __name__ == "__main__":
    main()
