// dettilemilit is said as not available in documentation so here we see
// how we can set it

execute {
// 1127 is dettimelimit
    cplex.params[1127] = 10.0;
} 



execute {
// 1132 is clone log in parallel optimization
cplex.params[1132] = 1;
} 

execute
{
// 1021 is constraint (row) read limit  
cplex.params[1021] = 10000000; 
}


