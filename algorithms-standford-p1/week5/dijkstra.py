#!/usr/bin/python
# Simple implementation of Dijkstra's shortest path algorithm
# https://en.wikipedia.org/wiki/Dijkstra%27s_algorithm
#

import sys

def readGraphIn(f):
    graph = [[]]  #vertice 0 always goes nowhere -- input is 1-based
    for line in f:
        l = line.split()
        curVert = int(l.pop(0))
        if curVert != len(graph):
            # blow up if the current vert isn't the same as the current size of the graph
            # since then our assumption about input ordering is broken
            print "curVert != len(graph): ", curVert, " != ", len(graph)
            sys.exit(1)

        edgeWeightList = []
        for edgeWeight in l:
            (edge, weight) = map(int, edgeWeight.split(','))
            edgeWeightList.append((edge,weight))

        graph.append(edgeWeightList)
    return graph

def djikstra(g, startVertex):
    n = len(g) - 1
    sp = [1000000] * len(g)
    sp[startVertex] = 0 # set cost of path from startVertex to startVertex to 0
    processed = {startVertex}

    while len(processed) < n:
        (bestTail, bestHead, bestWeight) = (None, None, None) #current lowest cost edge from processed to g - processed
        for tailVert in range(len(g)):
            for (headVert, curWeight) in g[tailVert]:
                if tailVert in processed and headVert not in processed:
                    calcWeight = sp[tailVert] + curWeight
                    if bestTail == None or calcWeight < bestWeight:
                        (bestTail, bestHead, bestWeight) = (tailVert, headVert, calcWeight)
        processed.add(bestHead)
        if (bestWeight != None):
            sp[bestHead] = bestWeight
    return sp

def findShortestPath(f, startVertex, endVertices):
    g = readGraphIn(f)
    sp = djikstra(g, startVertex)

    if endVertices == []:
        print "All:", sp
    else:
        costList = '' # output in format that assignment wants
        for endVertex in endVertices:
            print "start vertex:", startVertex, "finish:", endVertex, "cost:", sp[endVertex]
            costList = costList + str(sp[endVertex]) + ","
        print costList[:-1]

def main():
    #f=open('test1.txt', 'r') # [1000000, 0, 3, 3, 5]
    #f=open('test2.txt', 'r') # [1000000, 0, 3, 4, 5]
    #f=open('test3.txt', 'r') # [1000000, 0, 8, 12, 13]
    #f=open('test4.txt', 'r') # [1000000, 0, 8, 16, 13]
    #f=open('test5.txt', 'r') # [1000000, 0, 5, 1, 2]
    #f=open('test6.txt', 'r') # [1000000, 0, 2, 3, 1, 3, 6, 5]

    # use this for first 6 test cases which are small enough to view shortest paths for each vertex
    #findShortestPath(f, 1, [])

    #f=open('test7.txt', 'r') # start vertex 14, finish 6, cost 26
    #findShortestPath(f, 14, [6])
    #f=open('test8.txt', 'r') # start vertex 29, finish 7, cost 9
    #findShortestPath(f, 29, [7])
    f=open('dijkstraData.txt', 'r')
    findShortestPath(f, 1, [7,37,59,82,99,115,133,165,188,197])

if __name__ == "__main__":
    main()
