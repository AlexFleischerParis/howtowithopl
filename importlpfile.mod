/*

zoo.lp

\ENCODING=ISO-8859-1
\Problem name: Configuration1

Minimize
 obj1: 500 nbBus40 + 400 nbBus30
Subject To
 c1: 40 nbBus40 + 30 nbBus30 >= 300
Bounds
      nbBus40 >= 0
      nbBus30 >= 0
Generals
 nbBus40  nbBus30 
End

*/

main
{
  cplex.importModel("zoo.lp");
  cplex.solve();
  writeln("objective = ",cplex.getObjValue());
  
}

/*

which gives

objective = 3800

*/
