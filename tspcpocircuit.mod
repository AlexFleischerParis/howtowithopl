
    using CP;
    int     n       = ...;
    range   Cities  = 0..n-1;

    tuple       edge        {int i; int j;}
    setof(edge) Edges       = {<i,j> | ordered i,j in Cities};

    int         dist[Edges] = ...;
    int         dist2[i in Cities][j in Cities] = (i==j)?0:((i<j)?dist[<i,j>]:dist[<j,i>]);

    execute
    {
    cp.param.TimeLimit=10;
    }

    dvar int x[0..n-1] in 0..n-1;

    dvar int obj;
    minimize obj;

    
    subject to
    { 
    subCircuit(x);
    forall(i in Cities) x[i]!=i;
    obj==sum(i in 0..n-1) dist2[i][x[i]];
    }
