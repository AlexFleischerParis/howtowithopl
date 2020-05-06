

    dvar int x in 0..2;
    dvar int y in 0..2;

    subject to
    {
    x+y<=3;
    }

    execute
    {
    writeln("x=",x,"   and y=",y);
    }

    main {
    cplex.solnpoolintensity=4;

        thisOplModel.generate();
        cplex.solve();
        if (cplex.populate()) {
          var nsolns = cplex.solnPoolNsolns;
          
          
          writeln("Number of solutions found = ",nsolns);
          writeln();
          for (var s=0; s<nsolns; s++) {
            thisOplModel.setPoolSolution(s);
            thisOplModel.postProcess();
          }
        }
    }

/*

that gives

    Number of solutions found = 8

    x=0   and y=0
    x=2   and y=0
    x=0   and y=1
    x=2   and y=1
    x=0   and y=2
    x=1   and y=1
    x=1   and y=2
    x=1   and y=0
*/

/*
 //And for those who do not want to use the solution pool:

        dvar int xy; // in order to find all solutions

        dvar int x in 0..2;
        dvar int y in 0..2;
            
        maximize xy;

        subject to
        {
          x+y<=3;
            
          xy==1000*x+y;
        }

        execute
        {
         writeln("x=",x,"   and y=",y);
        }

        main {
         var nbsol=0;

         thisOplModel.generate();
         while (1==cplex.solve())
         {
             thisOplModel.postProcess();
             nbsol++;
             thisOplModel.xy.UB=thisOplModel.xy.solutionValue-1;              
         }
                writeln("nb solutions = ",nbsol);
        }

*/

/*

// And with CPOptimizer



    using CP;

    dvar int x in 0..2;
    dvar int y in 0..2;

    subject to
    {
    x+y<=3;
    }

    execute
    {
    writeln("x=",x,"   and y=",y);
    }

    main
    {
    cp.param.SearchType=24;
    cp.param.workers=1;

    thisOplModel.generate();
    cp.startNewSearch();
    while
    (cp.next()) {  thisOplModel.postProcess(); }
    }


*/
