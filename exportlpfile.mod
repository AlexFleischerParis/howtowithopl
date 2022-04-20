int nbKids=300;
float costBus40=500;
float costBus30=400;
 
dvar int+ nbBus40;
dvar int+ nbBus30;
 
minimize
 costBus40*nbBus40  +nbBus30*costBus30;
 
subject to
{
 40*nbBus40+nbBus30*30>=nbKids;
} 


main
{
  thisOplModel.generate();
  cplex.exportModel("c:\\temp\\zoo.lp");
}

/*

and in zoo.lp we get

\ENCODING=ISO-8859-1
\Problem name: exportlpfile

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