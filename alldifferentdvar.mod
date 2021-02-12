/*

How to use allDifferent for decision variables that are not in an array ?

*/

    using CP;

    range r=1..3;

    dvar int x in r;
    dvar int y in r;
    dvar int z in r;

    subject to
    {
    allDifferent(append(x,y,z));
    } 

    /*
    
     which gives

    x = 1;
    y = 3;
    z = 2; 

and that is more compact than

    using CP;

    range r=1..3;

    dvar int x in r;
    dvar int y in r;
    dvar int z in r;

    dvar int v[1..3];

    subject to
    {
    v[1]==x;
    v[2]==y;
    v[3]==z;

    allDifferent(v);
    } 

which uses 6 decision variables instead of 3 

*/