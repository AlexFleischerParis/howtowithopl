

    using CP;
    int     n       = ...;
    range   Cities  = 1..n;

    int realCity[i in 1..n+1]=(i<=n)?i:1;

     

    // Edges -- sparse set
    tuple       edge        {int i; int j;}
    setof(edge) Edges       = {<i,j> | ordered i,j in 1..n};
    setof(edge) Edges2       = {<i,j> | i,j in 1..n};  // node n+1 is node 1

    int         dist[Edges] = ...;
    int         dist2[i in 1..n][j in 1..n] = (i==j)?0:((i<j)?dist[<i,j>]:dist[<j,i>]);

    execute
    {

    cp.param.TimeLimit=60;

    }

    dvar int x[1..n] in 1..n;

    dvar int obj;

    minimize obj;

    // x means who is on i th position
    subject to
    {
    x[1]==1;
    allDifferent(x);

    obj==sum(i in 1..n-1) dist2[x[i]][x[i+1]]+dist2[x[1]][x[n]];


    }

