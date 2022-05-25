// hybrid CPOptimizer and CPLEX to solve lifegame
//
// warmstart between CPO and CPLEX to use them both
// 
// the objective is maximize
//
// And in 60s
//
// we get 
// 396 hybrid (hybrid.mod)
// 379 cplex alone (lifegameip.mod)
// 280 cpo alone (lifegamecp.mod)

int nbiter=3;
int n=30;

int values[0..(n+2)*(n+2)-1];
main {

	var n=thisOplModel.n;
   var nbiter=thisOplModel.nbiter;

  var source1 = new IloOplModelSource("lifegameip.mod");
  var cplex = new IloCplex();
  var def1 = new IloOplModelDefinition(source1);
  
  
  var source2 = new IloOplModelSource("lifegamecp.mod");
  var cp = new IloCP();
  var def2 = new IloOplModelDefinition(source2);
  
  var opl1 = new IloOplModel(def1,cplex);
  var opl2 = new IloOplModel(def2,cp);
  opl1.generate();
  opl2.generate();
  
  var objValues=new Array(2*5);
  
  for(var iter=1;iter<=nbiter;iter++)
  {
  
  writeln("iter ",iter);
  
  // start with CPLEX
  cplex.tilim=10;
  cplex.solve();
  writeln("cplex objective = ",cplex.getObjValue());
  
  objValues[iter*2-1]=cplex.getObjValue();
  
  cp.param.timelimit=10;
  
  // Warmstart in CPO
  var sol=new IloOplCPSolution();
  for(var i=0;i<=(n+2)*(n+2)-1;i++) sol.setValue(opl2.x[i],opl1.x[i]);
  cp.setStartingPoint(sol);
  
 
  // CP Solve
  cp.solve();
  writeln("cpo objective =",cp.getObjValue());
  objValues[iter*2]=cp.getObjValue();
  
  // And warmstart CPLEX
  var vectors = new IloOplCplexVectors();
  // We attach the values (defined as data) as starting solution
  // for the variables x.
  
  for(var i=0;i<=(n+2)*(n+2)-1;i++) thisOplModel.values[i]=opl2.x[i];
  vectors.attach(opl1.x,thisOplModel.values);
  vectors.setStart(cplex);   
}  
  
 writeln("list of objectives") ;
 for(var i=1;i<=2*nbiter;i++) writeln(objValues[i]);
  
}  