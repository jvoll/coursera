#!/usr/bin/python
#
# Calculate stronly connected components of a given graph using Kosarju's algorithm.
# https://en.wikipedia.org/wiki/Strongly_connected_component
#

import time

def readGraphIn(f):
    start=time.clock()
    graph = []
    for line in f:
        l = map(int, line.split())
        curVert = l.pop(0)

        ## though the file is sorted, not all indices exist so drop an empty set there
        while len(graph) <= curVert:
            graph.append(None)

        if graph[curVert] == None:
            graph[curVert] = [l[0]]
        else:
            graph[curVert].append(l[0])
    end=time.clock()
    graph[0] = None
    print "read in time: ", end-start
    #print graph

    return graph

# depth first search on graph g, node i
# use iterative approach as don't want to hit max recursion depth on large input file
def dfs(g, i, explored, t, s, f, leaders):

    unexplored = [i] #stack
    leaders[i] = s
    #explored.add(i)
    #print "start: ", i

    while (len(unexplored) > 0):
        v = unexplored[len(unexplored)-1]

        if v == None:
            unexplored.pop()
        elif v not in explored:
            explored.add(v)
            if g[v] != None:
                for x in g[v]:
                    if x not in explored:
                        leaders[x] = s
                        unexplored.append(x)

                #unexplored.extend(g[v])
                #print "v: ", v
                #print "unexplored: ", unexplored
        else:
            unexplored.pop()
            if f[v] == None and v != 0:
                t+=1
                #print "v: ", v
                #print "fCur: ", f
                #print "t index: ", t
                f[v] = t

    return t


#global t, s, explored, f

def dfsLoop(g, iterationOrder):
    t = 0 # number of nodes processed so far -- used for finishing times in first pass
    s = None # current source vertex, used in second pass
    explored = set() # vertices explored thus far
    f = [None]*(len(g)) # finishing times for each vertice
    leaders = [None]*(len(g)) # finishing times for each vertice

    if iterationOrder == None:
        iterationOrder = range(len(g))

    #print "itOrder:", iterationOrder
    for i in iterationOrder:
        if i not in explored: # and len(g[i]) > 0: # empty vertices don't exist in these graphs, just the way I built the graph
            s = i
            t = dfs(g,i, explored, t, s, f, leaders)

    f.pop(0)
    #print "finishing times: ", f
    return (f, leaders)

def reverseGraph(g):
    #print "g: ", g
    gRev = [None] * (len(g))
    gRev[0] = []
    for i in range(len(g)):
        if g[i] != None:
            for adjV in g[i]:
                if gRev[adjV] == None:
                    gRev[adjV] = [i]
                else:
                    gRev[adjV].append(i)

    #for j in range(len(gRev)):
    #    if gRev[j] == None:
    #        gRev[j] == []
    gRev[0] = None
    #print "grev:", gRev
    return gRev

def findSCC(g):
    start=time.clock()

    gRev = reverseGraph(g)
    (f, leaders) = dfsLoop(gRev, None)
    #print "fInv: ", fInv
    # invert f
    #print "f: ", f
    fInv = [None] * (len(f) + 1)
    for j in range(len(f)):
        fInv[f[j]] = j + 1
    #print "fInv: ", fInv
    fInv.pop(0)

    fInv.reverse()
    (fInv, leaders) = dfsLoop(g, fInv)

    sccs = {}
    leaders.pop(0)
    for i in range(len(leaders)):
        sccLeader = leaders[i]
        if sccLeader not in sccs:
            sccs[sccLeader] = []
        sccs[sccLeader].append(i+1)

    end=time.clock()
    print "algorithm timing: ", end-start
    #print "leaders: ", leaders
    print "num SCCs: ", len(sccs)
    sizes = []
    for key in sccs:
        sizes.append(len(sccs[key]))

    sizes.sort(None, None, True)
    print "5 biggest sizes: ", sizes[:5]
    #print "SCCs: ", sccs

def main():
    #f=open('sccCompleteGraph.txt', 'r') # 1 SCC of size 4, contains all 4 nodes
    #f=open('sccSmall.txt', 'r') # 3 SCC's of size 6,3,3 containing nodes (3,6,9,12,10,11), (2,5,8), (1,4,7)
    #f=open('sccTest1.txt','r') # 3,3,3,0,0
    #f=open('sccTest2.txt','r') # 3,3,2,0,0
    #f=open('sccTest3.txt','r') # 3,3,1,1,0
    #f=open('sccTest4.txt','r') # 7,1,0,0,0
    #f=open('sccTest5.txt','r') # 6,3,2,1,0
    #f=open('sccTest6.txt','r') # 6,1,1,0,0 #BROKEN...but only sort of, just appends a bunch of 1's to the correct answer, not making it fail the HWK
    #f=open('sccTest7.txt','r') # 3,2,2,2,1,1
    #f=open('sccTest8.txt','r') # 6,3,3
    #f=open('sccTest9.txt','r') # 35, 7, 1, 1, 1, 1, 1, 1, 1, 1
    #f=open('sccTest10.txt','r') # 3, 3
    #f=open('sccTest11.txt','r') # 5, 4, 2, 1, 1

    f=open('SCC.txt','r')

    graph=readGraphIn(f)
    #reverseGraph(graph)
    #dfsLoop(graph)
    findSCC(graph)


if __name__ == "__main__":
    main()
