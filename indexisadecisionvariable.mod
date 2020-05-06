

    range r=1..5;

    float value[r]=[2,3,4.5,1,0];
    dvar int i in 1..5;

    maximize sum(k in r) value[k]*(k==i);
    subject to
    {

    }

    execute
    {
    writeln("i=",i);
    }
    
/*

// With CP we could write



    using CP;
    range r=1..5;

    float value[r]=[2,3,4.5,1,0];
    dvar int i in 1..5;

    maximize value[i];
    subject to
    {

    }

    execute
    {
    writeln("i=",i);
    }


*/   

