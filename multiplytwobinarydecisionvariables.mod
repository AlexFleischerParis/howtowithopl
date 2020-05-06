


    dvar boolean x;
    dvar boolean y;
    dvar boolean z;

    subject to
    {
    x+y<=1+z;
    z<=x;
    z<=y;
    
    // we could also write
    // z==((x==1) && (y==1));
    
    // or even
    // z==minl(x,y);
    
    // or is we use CPOptimizer 
    // z==x*y;
    }
