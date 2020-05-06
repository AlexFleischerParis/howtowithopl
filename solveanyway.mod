// within Decision Optimization Center  , solveAnyway  is a very powerful algorithm
//
//    SolveAnyway is the default algorithm run by Decision Optimization Center when CPLEX® is the solving engine, and enables it to handle infeasible problems. The solution found by this algorithm is the optimal solution that maximizes the objective while minimizing the relaxation of constraints. To do this, SolveAnyway uses a CPLEX algorithm named feasopt.
//
//Some want to use that even without Decision Optimization Center so let me give an example:

    int prefsolveanyway1[1..1]=[0];
    int prefsolveanyway2[1..1]=[0];
    int prefsolveanyway3[1..1]=[0];


    int priority[1..3]=[1,2,3];


    dvar int x;
    dvar int y;
    dvar int z;

    subject to
    {
    0<=x<=20;
    0<=y<=20;
    0<=z<=20;

    forall(i in 1..1) ct1:y-x>=7;
    forall(i in 1..1) ct2:z-y>=9;
    forall(i in 1..1) ct3:z-x<=10;


    }

     

    main {

    function writeRelaxation(opl)
    {
        var iter = opl.relaxationIterator;  
       for(var c in iter)
       {
         var constraint=c.ct;
         writeln(constraint.name);
         writeln("LB             = ",c.LB);
         writeln("UB             = ",c.UB);
         writeln("relaxedLB      = ",c.relaxedLB);
         writeln("relaxedUB      = ",c.relaxedUB);
         
       }
    }

     

       thisOplModel.generate();
       var def = thisOplModel.modelDefinition;   
       // Default behavior
       writeln("Default Behavior");
       writeln();
       
       var cplex1 = new IloCplex();
       var opl1 = new IloOplModel(def, cplex1);
       opl1.settings.relaxationLevel=1;
       opl1.generate();
       writeln(opl1.printRelaxation());   
       writeln("cplex status = ",cplex1.getCplexStatus());  
       
       writeln("Solve Anyway");
          

     // Priority 1 : ct1
     // Priority 2 : ct2
     // Priority 3 : ct3
     
     
      var currentPriority = 1;
      var noSolution=1;
      while (noSolution==1)
      {
       writeln();
       var cplex2 = new IloCplex();
       var opl2 = new IloOplModel(def, cplex2);
       opl2.generate();  
     
         writeln("relaxing priority less than ",currentPriority)  ;
        
         if (opl2.priority[1]<=currentPriority) opl2.prefsolveanyway1[1]=1; else opl2.prefsolveanyway1[1]=0;
         if (opl2.priority[2]<=currentPriority) opl2.prefsolveanyway2[1]=1; else opl2.prefsolveanyway2[1]=0;
         if (opl2.priority[3]<=currentPriority) opl2.prefsolveanyway3[1]=1; else opl2.prefsolveanyway3[1]=0;
         
         opl2.relaxationIterator.attach(opl2.ct1, opl2.prefsolveanyway1);
            opl2.relaxationIterator.attach(opl2.ct2, opl2.prefsolveanyway2);
            opl2.relaxationIterator.attach(opl2.ct3, opl2.prefsolveanyway3);
     
            writeRelaxation(opl2);
           
           writeln("cplex status = ",cplex2.getCplexStatus());
           if (cplex2.getCplexStatus()==14)
           {
            noSolution=0;
            writeln("x,y,z = ",opl2.x," ",opl2.y," ",opl2.z);
        }       
           
           currentPriority++;
      }
              
       opl2.end();
       cplex2.end();
    }
    
    /*

which gives

    Default Behavior

    ct2[1] at 20:1-30 C:\poc\solveanyway\solveanyway.mod
        relax [9,Infinity] to [3,Infinity] value is 3

    cplex status = 14
    Solve Anyway

    relaxing priority less than 1
    ct1[1]
    LB             = 7
    UB             = Infinity
    relaxedLB      = 1
    relaxedUB      = 1
    cplex status = 14
    x,y,z = 0 1 10

 

This shows that with default relaxation ct2 is relaxed whereas with solveanyway where we say first relax ct1 then ct2 then ct3, ct1 is relaxed 

*/