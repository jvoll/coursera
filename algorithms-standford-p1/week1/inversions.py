#!/usr/bin/python
#
# Author: jvoll
#
# Using a mergesort variant, calculate the number of inversions
# for a given list of numbers in O(n log n) time.
#
# Input: array A containing the numbers 1,2,3,...,n in some arbitrary order
# Output: number of inversions = number of pairs (i,j) of array indices with
# i<j and A[i] > A[j]
#
# Example: [1, 3, 5, 2, 4, 6] has 3 inversions (3,2), (5,2), (5,4)

def sortAndCountInversions(nums) :
    n = len(nums)
    if n == 0 or n == 1:
        return (nums, 0)
    (leftNums, leftInversions) = sortAndCountInversions(nums[0:(n/2)])
    (rightNums, rightInversions) = sortAndCountInversions(nums[(n/2):n])
    (sortedNums, splitInversions) = mergeAndCountSplitInversions(leftNums, rightNums)

    inversions = leftInversions + rightInversions + splitInversions
    return (sortedNums, inversions)

def mergeAndCountSplitInversions(leftNums, rightNums):
    lenLeft = len(leftNums)
    lenRight = len(rightNums)
    n = lenLeft + lenRight
    sortedNums = []
    inversions = 0
    i = 0
    j = 0

    for k in range(0, n):
        if lenLeft <= i:
            sortedNums.append(rightNums[j])
            j+=1
        elif lenRight <= j:
            sortedNums.append(leftNums[i])
            i+=1
        elif leftNums[i] < rightNums[j]:
            sortedNums.append(leftNums[i])
            i+=1
        else:
            sortedNums.append(rightNums[j])
            j+=1
            # KEY: When we take a number from the right list,
            # it is "inverted with" all remaining numbers in
            # the left list.
            inversions += lenLeft - i

    return (sortedNums, inversions)

def main():
    inputList = []

    f = open('IntegerArray.txt', 'r') # 2407905288 inversions
    #f = open('ShortTest.txt', 'r') # 3 inversions
    #f = open('LongerSortTest.txt', 'r') # 10 inversions
    #f = open('OddLengthTest.txt', 'r') # 4 inversions
    print "Input file:", f

    for line in f:
       inputList.append(int(line.rstrip()))

    #print inputList
    (sortedList, numInversions) = sortAndCountInversions(inputList)
    #print "Sorted list:", sortedList
    print "Inversions:", numInversions

if __name__ == "__main__":
    main()
