/*

Max flox in OPL

https://en.wikipedia.org/wiki/Maximum_flow_problem

*/

{string} nodes={"source","a","b","c","e","sink"};

tuple edge
{
  key string origin;
  key string destination;
  float capacity;
}

{edge} edges with origin,destination in nodes=
{
  <"source","a",1>, 
  <"source","b",9>, 
  <"source","c",9.5>,
  <"a","e",2>, 
  <"b","e",5>, 
  <"b","sink",4>, 
  <"c","b",2>, 
  <"c","sink",3.5>, 
  <"e","sink",3>
};

// flow per edge
dvar float+ flow[e in edges] in 0..e.capacity;

// maximize flow
maximize sum(e in edges:e.origin=="source") flow[e];

subject to
{
  // flow conservation
  forall(n in nodes diff {"source","sink"}) 
    flowConservation:
      sum(e in edges:e.origin==n) 
        flow[e]==sum(e in edges:e.destination==n) flow[e];
}

// Display
execute
{
  for(var e in edges)
   writeln(e.origin," -> ",e.destination," : ",flow[e]);
}

/*

// solution (optimal) with objective 10.5
source -> a : 0
source -> b : 7
source -> c : 3.5
a -> e : 0
b -> e : 3
b -> sink : 4
c -> b : 0
c -> sink : 3.5
e -> sink : 3

*/
