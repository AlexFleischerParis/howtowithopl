// IloOplExec calls an external program and will wait for this program to return

execute
{
 // call OPL
IloOplExec("C:\\ILOG\\CPLEX_Studio1210\\opl\\bin\\x64_win64\\oplrun.exe c:/temp/zoo.mod");

// display the result by importing output.txt
writeln("result");
var f=new IloOplInputFile("c://temp//output.txt");
while (!f.eof) {
      s=f.readline();
      writeln(s);
     }

f.close();
} 

// which gives
// result
// 6 buses 40 seats
// 2 buses 30 seats

