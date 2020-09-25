/*

Many users know that we can use a decision variable as index for a 1D array
but many ignore that it's the same with multi dimension arrays

*/


using CP;



// v is 1 iff i==2 and j==3 and k==1
int v[i in 1..2][j in 1..3][k in 1..4]=(i==2)&&(j==3)&&(k==1);

// decision variables
dvar int x;
dvar int y;
dvar int z;

subject to
{
  v[x][y][z]==1;
}

execute
{
  writeln("x,y,z = ",x,",",y,",",z);
}

/*

which gives

x,y,z = 2,3,1

*/

// Many other examples
// at https://www.linkedin.com/pulse/how-opl-alex-fleischer/
