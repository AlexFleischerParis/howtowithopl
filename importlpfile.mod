main
{
  cplex.importModel("zoo.lp");
  cplex.solve();
  writeln("objective = ",cplex.getObjValue());
  
}
