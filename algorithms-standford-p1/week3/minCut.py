#!/usr/bin/python
#
# Author: jvoll
#
# Implementation of Karger's min cut algorithm
# https://en.wikipedia.org/wiki/Karger%27s_algorithm
#

import copy
import random

def readGraphIn(f):
    vertices = {}
    edges = set()
    for line in f:
        l = map(int, line.split())
        curVert = l.pop(0)
        vertices[curVert] = l
        for vert in l:
            addEdgeToSet(edges, (curVert, vert))
    return (vertices, list(edges))

def addUnique(l, item):
    if item not in l:
        l.append(item)
    return l

def orderEdge((a, b)):
    if (a < b):
        return (a,b)
    else:
        return (b,a)

def addEdgeToSet(edges, unorderedEdge):
    edges.add(orderEdge(unorderedEdge))

def addEdge(edges, unorderedEdge):
    edges.append(orderEdge(unorderedEdge))

# return (<new set of edges>, <number of edges removed>)
def removeEdges(edges, unorderedEdge):
    if (unorderedEdge[0] < unorderedEdge[1]):
        edgeToRemove = unorderedEdge
    else:
        edgeToRemove = (unorderedEdge[1], unorderedEdge[0])

    newEdges = []
    removed = 0
    for edge in edges:
        if edge == edgeToRemove:
            removed += 1
        else:
            newEdges.append(edge)
    return (newEdges, removed)

def collapseEdge(vertices, edges):
    #print "num edges:", len(edges)
    randInd = random.randint(0, len(edges) -1)
    edge = edges[randInd]
    #print "randomInd:", randInd, "edge:", edge

    startNode = edge[0]
    endNode = edge[1]
    endNeighbours = vertices.pop(endNode)
    #print "edges after remove:", edges
    #print "endNeighbours:", endNeighbours


    # replace all edges from endNode to endNeighbour n
    # with edge from startNode to n
    for n in endNeighbours:

        (edges, removed) = removeEdges(edges, (endNode, n))

        if n != startNode:
            for i in range(0, removed):
                addEdge(edges, (startNode, n))

        if n != startNode:
            vertices[startNode] = addUnique(vertices[startNode], n)
            vertices[n] = addUnique(vertices[n], startNode)
        if n != endNode:
            vertices[n].remove(endNode)

    (edges,x) = removeEdges(edges, edge)
    return (vertices, edges)

def minCutSingle(vertices, edges):
    while len(vertices) > 2:
        (vertices, edges) = collapseEdge(vertices, edges)
        #print "verts:", vertices
        #print "edges:", edges
    return len(edges)

def minCut(vertices, edges):
    minimumCut = len(edges)
    for i in range(0, 20000):
        curCut = minCutSingle(copy.deepcopy(vertices), edges)
        minimumCut = min(curCut, minimumCut)
        print "Attempt:", i, "minCut:", minimumCut, "cut:", curCut
    return minimumCut

def main():
    inputList = []

    #f = open('smallTest.txt', 'r')
    #f = open('smallTestJumbled.txt', 'r')
    #f = open('expectedCutOne.txt', 'r')
    #f = open('longerTest.txt', 'r')
    #f = open('anotherTest.txt', 'r')
    f = open('kargerMinCut.txt', 'r') # answer = 17
    print "Input file:", f
    (vertices, edges) = readGraphIn(f)
    #print "verts:", vertices
    #print "edges:", edges

    random.seed()
    minimumCut = minCut(vertices, edges)
    print "Minimum cut:", minimumCut

    #print "verts:", vertices
    #print "edges:", edges


if __name__ == "__main__":
    main()
