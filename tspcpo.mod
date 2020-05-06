 /*
 
 in the example CPLEX_Studio\opl\examples\opl\models\TravelingSalesmanProblem the TSP problem 
 is solved with Integer Programming

https://en.wikipedia.org/wiki/Travelling_salesman_problem

I provide here a skeleton that does the same but with CPO (Constraint Programming)

Why could that be interesting ?

    This can be a starting point to add more business constraints 
    that would be harder to add with a linear model
    This shows again the expressiveness of CPO
    Unlike the linear approach, we have a solution any time and do not have to wait for the end of the remove circuit algorithm 
*/

using CP; 
int     n       = ...;
range   Cities  = 1..n;

int realCity[i in 1..n+1]=(i<=n)?i:1;



// Edges -- sparse set
tuple       edge        {int i; int j;}
setof(edge) Edges       = {<i,j> | ordered i,j in 1..n};
setof(edge) Edges2       = {<i,j> | i,j in 1..n+1};  // node n+1 is node 1

int         dist[Edges] = ...;
int 		dist2[<i,j> in Edges2]=(realCity[i]==realCity[j])?0:
((realCity[i]<realCity[j])?dist[<realCity[i],realCity[j]>]:dist[<realCity[j],realCity[i]>]);


dvar interval itvs[1..n+1] size 1;


dvar sequence seq in all(i in 1..n+1) itvs[i]; 

execute
{

cp.param.TimeLimit=60;
var f = cp.factory;
  cp.setSearchPhases(f.searchPhase(seq));
}

tuple triplet { int c1; int c2; int d; };
{triplet} Dist = { 
  	<i-1,j-1,dist2[<i ,j >]>
           |  i,j in 1..n+1};
           
           
minimize endOf(itvs[n+1]) - (n+1);           
subject to
{
	startOf(itvs[1])==0; // break sym
	noOverlap(seq,Dist,true);	// nooverlap with a distance matrix
	last(seq, itvs[n+1]); // last node
}
          
          
 int  x[<i,j> in Edges]=prev(seq,itvs[i],itvs[j])+prev(seq,itvs[j],itvs[i]); 
 int  isPrevFromNPlus1[i in 1..n]=prev(seq,itvs[i],itvs[n+1]);
 int l=first({i | i in 1..n : isPrevFromNPlus1[i]==1});
 edge el=<1,l>;
 
 execute
 {
 isPrevFromNPlus1;
 x; 
 x[el]=1;
 }
 
 // Let us check here that the constraints of the IP model are ok
 assert forall (j in Cities)
        as:sum (<i,j> in Edges) x[<i,j>] + sum (<j,k> in Edges) x[<j,k>] == 2;
        
// Let us compute here the objective the IP way
int cost=sum (<i,j> in Edges) dist[<i,j>]*x[<i,j>];

execute
{
writeln(cost);
}        
        