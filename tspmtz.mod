// What is better and relies on CPLEX is the MTZ model ( Miller-Tucker-Zemlin formulation )

    // Cities
    int     n       = ...;
    range   Cities  = 1..n;

    // Edges -- sparse set
    tuple       edge        {int i; int j;}
    setof(edge) Edges       = {<i,j> | ordered i,j in Cities};
    int         dist[Edges] = ...;

    setof(edge) Edges2       = {<i,j> | i,j in Cities : i!=j};
    int         dist2[<i,j> in Edges2] = (<i,j> in Edges)?dist[<i,j>]:dist[<j,i>];

    // Decision variables
    dvar boolean x[Edges2];

    dvar int u[1..n] in 1..n;

     

    /*****************************************************************************
     *
     * MODEL
     *
     *****************************************************************************/

    // Objective
    minimize sum (<i,j> in Edges2) dist2[<i,j>]*x[<i,j>];
    subject to {
       
       // Each city is linked with two other cities
       forall (j in Cities)
         {
            sum (<i,j> in Edges2) x[<i,j>]==1;
            sum (<j,k> in Edges2) x[<j,k>] == 1;
       }  
        
     
     // MTZ
 
u[1]==1;
forall(i in 2..n) 2<=u[i]<=n;
forall(e in Edges2:e.i!=1 && e.j!=1) (u[e.j]-u[e.i])+1<=(n-1)*(1-x[e]);
       
};

{edge} solution={e | e in Edges2 : x[e]==1};
int follower[Cities];
{int} sol;

execute
{
//writeln("path ",solution);
for(var e in solution) follower[e.i]=e.j;
var k=1;
for(var i in Cities)
{
  sol.add(k);
  k=follower[k];
}
writeln("sol = ",sol);
}    

/*

which gives

// solution (optimal) with objective 7542
sol =  {1 22 31 18 3 17 21 42 7 2 30 23 20 50 29 16 46 44 34 35 36 39 40 37 38 48
     24 5 15 6 4 25 12 28 27 26 47 13 14 52 11 51 33 43 10 9 8 41 19 45 32
     49}
     
     */