#!/usr/bin/python
#
# Author: jvoll
#
# Basic quicksort algorithm. Sorts the input array and keeps track of the number
# of comparisons made using (less the number of comparisons made to choose the pivot).
# The number of comparisons at each level of recursion is m-1 where m is the length
# of the subarray being operated on in that recursive call.
#
# Input: array A containing the numbers 1,2,3,...,n in some arbitrary order
# Output: the number of comparisons made to sort the array (and the sorted array if code uncommented)
#

# Chooses a pivot and swaps it to arr[start]
def positionPivotToStart(arr, start, end):
    # Q1 -- use first element as pivot
    # # of comparisons for Q1 = 162085
    # no-op

    # Q2 -- use last element as pivot
    # # of comparisons for Q2 = 164123
    # swap(arr, start, end)

    # Q3 -- use the median of three pivot rule
    # # of comparisons for Q3 = 138382
    swap(arr, start, findMedianOfThreeIndex(arr, start, end))

    return  # keep the interpreter happy for Q1 -- unsurprisingly it doesn't like empty functions :)

def findMedianOfThreeIndex(arr, i, j):
    size = j - i  # want to select the lower index for even sized arrays (I know that this is actually len-1)
    mid = (size/2) + i
    lookup = {arr[i]:i, arr[j]:j, arr[mid]:mid}
    a = min(arr[i], arr[j], arr[mid])
    c = max(arr[i], arr[j], arr[mid])
    b = (arr[i] + arr[j] + arr[mid]) - (a + c)
    return lookup[b]

def swap(arr, i, j):
    arr[i], arr[j] = arr[j], arr[i]

def partition(arr, start, end):

    # Base case (array of size m<=1)
    if (end <= start):
        return 0

    positionPivotToStart(arr, start, end)
    splitIndex = start + 1

    for j in range(start + 1, end + 1):
        if (arr[j] < arr[start]):
            swap(arr, j, splitIndex)
            splitIndex += 1

    # Swap pivot into position
    swap(arr, start, splitIndex - 1)

    # Recurse and count # of comparisons (at each step this is len(arr[start : (end + 1)]) - 1 which is equal to end - start)
    comparisons = end - start
    comparisons += partition(arr, start, splitIndex - 2)
    comparisons += partition(arr, splitIndex, end)
    return comparisons

def quicksort(arr):
    comparisons = partition(arr, 0, len(arr) - 1)
    print "# Comparisons: ", comparisons

def main():
    inputList = []

    f = open('QuickSortInput.txt', 'r')
    #f = open('OddLengthTest.txt', 'r')
    #f = open('First20.txt', 'r')
    print "Input file:", f

    for line in f:
       inputList.append(int(line.rstrip()))

    #print inputList
    quicksort(inputList)
    #print "Sorted list:", inputList

if __name__ == "__main__":
    main()
