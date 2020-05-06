

// Use CPLEX and logical constraints

    range r=1..100;
    dvar int x in r;;
    dvar int y in r;
    dvar int xy;

    subject to
    {
    xy==169;

    forall(pos in r) (x==pos) => (xy==pos*y);
    }

/*
 // Use logical constraints and dichotomy

    range r=1..100;

    dvar boolean b[0..6];
    dvar int by[0..6];
    dvar int x in r;;
    dvar int y in r;
    dvar int xy;

    subject to
    {
    xy==169;

    x==sum(i in 0..6) ftoi(pow(2,i))*b[i];

    forall(i in 0..6)
    {
    b[i]==1 => by[i]==y*ftoi(pow(2,i));
    b[i]==0 => by[i]==0;
    }

    xy==sum(i in 0..6) by[i];
    }
*/



/*

// constraint programming
using CP;

range r=1..100;
dvar int x in r;;
dvar int y in r;

subject to
{
x*y==169;
} 

*/
