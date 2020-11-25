// --------------------------------------------------------------------------
// Licensed Materials - Property of IBM
//
// 5725-A06 5725-A29 5724-Y48 5724-Y49 5724-Y54 5724-Y55
// Copyright IBM Corporation 1998, 2013. All Rights Reserved.
//
// Note to U.S. Government Users Restricted Rights:
// Use, duplication or disclosure restricted by GSA ADP Schedule
// Contract with IBM Corp.
// --------------------------------------------------------------------------

/*****************************************************************************
 *
 * OPL model and script for Symmetric Travelling Salesman Problem
 * 
 *****************************************************************************/

/*****************************************************************************
 *
 * DATA
 * 
 *****************************************************************************/
 
 // With some addition to see the graph

// Cities
int     n       = ...;
range   Cities  = 1..n;

// Edges -- sparse set
tuple       edge        {int i; int j;}
setof(edge) Edges       = {<i,j> | ordered i,j in Cities};
int         dist[Edges] = ...;

// Decision variables
dvar boolean x[Edges];

tuple Subtour { int size; int subtour[Cities]; }
{Subtour} subtours = ...;

// Added to see the graph
int posx[Cities]=...;
int posy[Cities]=...;
// end of added



/*****************************************************************************
 *
 * MODEL
 * 
 *****************************************************************************/

// Objective
minimize sum (<i,j> in Edges) dist[<i,j>]*x[<i,j>];
subject to {
   
   // Each city is linked with two other cities
   forall (j in Cities)
        sum (<i,j> in Edges) x[<i,j>] + sum (<j,k> in Edges) x[<j,k>] == 2;
        
   // Subtour elimination constraints.
   forall (s in subtours)
       sum (i in Cities : s.subtour[i] != 0)
          x[<minl(i, s.subtour[i]), maxl(i, s.subtour[i])>]
           <= s.size-1;
          
};

// POST-PROCESSING to find the subtours

// Solution information
int thisSubtour[Cities];
int newSubtourSize;
int newSubtour[Cities];

// Auxiliary information
int visited[i in Cities] = 0;
setof(int) adj[j in Cities] = {i | <i,j> in Edges : x[<i,j>] == 1} union
                              {k | <j,k> in Edges : x[<j,k>] == 1};
execute {

  newSubtourSize = n;
  for (var i in Cities) { // Find an unexplored node
    if (visited[i]==1) continue;
    var start = i;
    var node = i;
    var thisSubtourSize = 0;
    for (var j in Cities)
      thisSubtour[j] = 0;
    while (node!=start || thisSubtourSize==0) {
      visited[node] = 1;
      var succ = start; 
      for (i in adj[node]) 
        if (visited[i] == 0) {
          succ = i;
          break;
        }
                        
      thisSubtour[node] = succ;
      node = succ;
      ++thisSubtourSize;
    }

    writeln("Found subtour of size : ", thisSubtourSize);
    if (thisSubtourSize < newSubtourSize) {
      for (i in Cities)
        newSubtour[i] = thisSubtour[i];
        newSubtourSize = thisSubtourSize;
    }
  }
  if (newSubtourSize != n)
    writeln("Best subtour of size ", newSubtourSize);
}



/*****************************************************************************
 *
 * SCRIPT
 * 
 *****************************************************************************/

main {
    var opl = thisOplModel
    var mod = opl.modelDefinition;
    var dat = opl.dataElements;

    var status = 0;
    var it =0;
    while (1) {
        var cplex1 = new IloCplex();
        opl = new IloOplModel(mod,cplex1);
        opl.addDataSource(dat);
        opl.generate();
        it++;
        writeln("Iteration ",it, " with ", opl.subtours.size, " subtours.");
        if (!cplex1.solve()) {
            writeln("ERROR: could not solve");
            status = 1;
            opl.end();
            break;
        }
        opl.postProcess();
        writeln("Current solution : ", cplex1.getObjValue());

        if (opl.newSubtourSize == opl.n) {
          //opl.end();
          //cplex1.end();
          break; // not found
        }
          
        dat.subtours.add(opl.newSubtourSize, opl.newSubtour);
		opl.end();
		cplex1.end();
    }

    status;
    
    // Added to see the graph
    var o=new IloOplOutputFile("c:\\temp\\paramdisplaypoints.txt");

    var kcity=opl.thisSubtour[1];
    var xstring="";
    var ystring="";
    var cstring="";
    for(var k=1;k<=opl.n;k++)
    {
              writeln(kcity);
              xstring=xstring+opl.posx[kcity];
              if (k!=opl.n) xstring=xstring+",";
              ystring=ystring+opl.posy[kcity];
              if (k!=opl.n) ystring=ystring+",";
              cstring=cstring+"2";
              if (k!=opl.n) cstring=cstring+",";
              kcity=opl.thisSubtour[kcity]; 
              
              
                      
    }
    o.write(xstring);
    o.writeln();
    o.write(ystring);
    o.writeln();
    o.write(cstring);
    o.writeln();
    o.close();

    IloOplExec("C:\\Python36\\python.exe c:\\temp\\displaylines.py",false);
    // end of added
}

