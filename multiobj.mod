// Works with CPLEX and CPOptimizer

// using CP;

        int n=10;
        int m=25;

        range position = 1..n;

        dvar boolean x[position][position];
        dvar int obj1 in position;
        dvar int obj2 in position;

        minimize staticLex(obj1,obj2);

        subject to
        {
          sum(i,j in position) x[i][j]==m;
         
          obj1==max(i,j in position) i*x[i][j];
          obj2==max(i,j in position) j*x[i][j];
        }

        execute
        {
        writeln("objectives : ",obj1," ",obj2);

        writeln("-----------------------------");
        writeln();

        for(var i in position)
        {
         for(j in position) write((x[i][j]==1)?"+":" ");
         writeln();
        }
        }

/*     

which gives

    // solution (multi-objective optimal) with objective 3
    objectives : 3 9
    -----------------------------

    +++++++++
    ++++++  +
    +++++++++
    
    */

