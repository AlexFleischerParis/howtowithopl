

    range r=1..4;

    float x[r]=[1.5,4.0,2.0001,5.9999];

    dvar int y[r];
    dvar float f[r] in 0..0.99999;

    subject to
    {
    forall(i in r) x[i]==y[i]+f[i];


    }

    execute
    {
    writeln(x," ==> ",y);
    }

    assert forall(i in r) y[i]==floor(x[i]);

//which gives

//    [1.5 4 2.0001 5.9999] ==>  [1 4 2 5]

