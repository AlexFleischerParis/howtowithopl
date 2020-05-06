// suppose we want b * x <= 7 

    dvar int x in 2..10;
    dvar boolean b;

    dvar int bx;

    maximize x;
    subject to
    {
      
    // Linearization  
    bx<=7;

     

    2*b<=bx;
    bx<=10*b;

    bx<=x-2*(1-b);
    bx>=x-10*(1-b);
    
    // if we use CP we could write directly
    // b*x<=7
    
    // or rely on logical constraints within CPLEX
    // (b==1) => (bx==x);
    // (b==0) => (bx==0);
    }

