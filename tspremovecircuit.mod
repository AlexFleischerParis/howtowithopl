// This is NOT the right way at all 
 
 // Cities
int     n       = ...;
range   Cities  = 1..n;

// Edges -- sparse set
tuple       edge        {int i; int j;}
setof(edge) Edges       = {<i,j> | ordered i,j in Cities};
int         dist[Edges] = ...;

// Decision variables
dvar boolean x[Edges];

 {int} nodes={i.i | i in Edges} union {i.j | i in Edges};

range r=1..-2+ftoi(pow(2,card(nodes)));


{int} nodes2 [k in r] = {i | i in nodes: ((k div (ftoi(pow(2,(ord(nodes,i))))) mod 2) == 1)};

 

 

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
 
   
forall(k in r)  // all subsets but empty and all
    sum(e in Edges:(e.i in nodes2[k]) && (e.j in nodes2[k])) x[e]<=card(nodes2[k])-1;  

 }    
