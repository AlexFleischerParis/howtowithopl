/*

 the earlier you know about issues the better.

Modeling assistance really helps. https://www.ibm.com/support/knowledgecenter/SSSA5P_12.8.0/ilog.odms.cplex.help/CPLEX/UsrMan/topics/progr_consid/modelingAssistance/introModelingAssistance.html

But many OPL users seem to ignore how easy to use that feature is.

So let me give you an example: 

*/

execute
{
cplex.datacheck=2;
}

dvar float x;
maximize x;
subject to
{
ct:x+0.3333333333<=2;
} 

/*

in the engine log you will get

CPLEX Warning  1036: Decimal part of coefficient for right-hand side in constraint 'ct' looks like 2/3 in single precision.

which is quite helpful

*/
