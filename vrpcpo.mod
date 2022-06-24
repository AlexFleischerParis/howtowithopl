/*

VRP 

*/
using CP;

int visitDuration=1;

tuple Node {
	key string nodeID;
	int x;
	int y;
}
{Node} nodes = ...;	

tuple Visit { 
			key int visitID;
			string nodeID; 
            
              };
{Visit} clientVisits = ...;   

tuple Vehicle {
				key string vehicleID;	
				string firstVisitID;
				string lastVisitID;
				
			}	
{Vehicle} vehicles = ...;							    

int firstDepotVisitID = min(v in clientVisits) v.visitID - 1;
int lastDepotVisitID = max(v in clientVisits) v.visitID + 1;
Visit firstDepotVisit = <firstDepotVisitID,"depot">;
Visit lastDepotVisit = <lastDepotVisitID,"depot">;
{Visit} allVisits = clientVisits union
			// Needs to be generalized for multiple depots
			{firstDepotVisit, lastDepotVisit };
			
int xPerVisit[i in allVisits]=item(nodes,<i.nodeID>).x;	
int yPerVisit[i in allVisits]=item(nodes,<i.nodeID>).y;	



// Create transition distance
tuple triplet { int c1; int c2; int d; };
{triplet} Dist = { 
  	
  		<ord(allVisits,v1), ord(allVisits,v2), 
  		ftoi(round(sqrt(pow(n2.x-n1.x,2)+pow(n2.y-n1.y,2))))> 
           | v1,v2 in allVisits, n1, n2 in nodes : v1.nodeID == n1.nodeID && v2.nodeID == n2.nodeID }; 
  
dvar interval visitInterval[v in clientVisits] size visitDuration;

dvar interval tvisitInterval  [v in allVisits][veh in vehicles] 
                  optional(v.visitID!=firstDepotVisitID && v.visitID!=lastDepotVisitID);
dvar sequence route[veh in vehicles] in all(v in allVisits) tvisitInterval[v][veh] 
                                  types all(v in allVisits) ord(allVisits,v); 
dvar interval truck [veh in vehicles] optional;
 
execute {
  cp.param.TimeLimit               = 100
}


dexpr float travelMaxTime = max(veh in vehicles) endOf(tvisitInterval[lastDepotVisit][veh]);
dexpr int nbUsed = sum(veh in vehicles) presenceOf(truck[veh]);

minimize staticLex(travelMaxTime,nbUsed); 
subject to  {

  
  forall(veh in vehicles) {
  	span (truck[veh], all(v in clientVisits) tvisitInterval[v][veh]);
    noOverlap(route[veh], Dist);          // Travel time
    startOf(tvisitInterval[firstDepotVisit][veh])==0;     // Truck t starts at time 0 from depot
    last (route[veh],tvisitInterval[lastDepotVisit] [veh]); // Truck t returns at depot
    
  }
  forall(v in clientVisits)
    alternative(visitInterval[v], all(t in vehicles) tvisitInterval[v][t]); // Truck selection
}
 
execute {
  writeln(nbUsed + " vehicles are used");
  writeln("Max travelled distance is " + travelMaxTime); 
}

execute {
  
  var o=new IloOplOutputFile("c:\\temp\\paramdisplaypolylines.txt");
  o.writeln(nbUsed);
  var color=0;
  for(veh in vehicles) if (1==Opl.presenceOf(truck[veh]))
  {
    color=color+1;
    var seq=route[veh];
    writeln(seq);
    
    var xstring="";
    var ystring="";
    var cstring="";
   

    //writeln("loop"); 
    var s=seq.first(); 
    
    while (s!=seq.last())
    {
     //writeln(s); 
     
   s=seq.next(s) ; 
   var typ=Opl.typeOfPrev(seq,s,100);
   //writeln(typ);
   xstring=xstring+xPerVisit[Opl.item(allVisits,typ)]+",";
   ystring=ystring+yPerVisit[Opl.item(allVisits,typ)]+",";
   cstring=cstring+color+",";
    } 
     //writeln(s); 
     s=seq.prev(s) ; 
     var typ=Opl.typeOfNext(seq,s,100);
     //writeln(typ);
     xstring=xstring+xPerVisit[Opl.item(allVisits,typ)];
     ystring=ystring+yPerVisit[Opl.item(allVisits,typ)];
     cstring=cstring+color;
     o.write(xstring);
    o.writeln();
    o.write(ystring);
    o.writeln();
    o.write(cstring);
    o.writeln();
   }   
   
   o.close();  
   
   IloOplExec("C:\\Python\\Python39\\python.exe c:\\temp\\displaypolylines.py",false);
    
}


