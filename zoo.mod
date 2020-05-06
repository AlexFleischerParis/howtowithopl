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

execute{
 var o=new IloOplOutputFile("output.txt");
 o.writeln(nbBus40, " buses 40 seats");
 o.writeln(nbBus30, " buses 30 seats");
 o.close();
}

