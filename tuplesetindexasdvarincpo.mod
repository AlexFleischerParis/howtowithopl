/*

With COOptimizer we can use a decision variable as an index

using CP;

int v[1..2]=[1,2];

dvar int x in 1..2;

subject to
{
  v[x]==2;
}

works fine

Often, OPL users need to use a set instead of an array and try to use item:

They write

using CP;

{string} s={"A","B"};

int v[s]=[1,2];

dvar int x in 1..2;

subject to
{
  v[item(s,x-1)]==2;
}

which does not work

What they can do : use dexpr instead:

*/

using CP;

{string} s={"A","B"};

int v[s]=[1,2];
int v2[s][s]=[[3,4],[5,6]];

tuple mytuple
{
  key int a;
  int b;
}

{mytuple} v3={<6,2>,<7,4>};

dvar int x in 1..2;
dexpr int vexpr[i in 1..2]=v[item(s,i-1)];

dvar int y in 1..2;
dvar int z in 1..2;
dexpr int v2expr[i in 1..2][j in 1..2]=v2[item(s,i-1)][item(s,j-1)];

dvar int t;
dexpr int v3expr[i in 6..7]=item(v3,<i>).b;

subject to
{
  vexpr[x]==2;
  v2expr[y][z]==5;
  v3expr[t]==2;
}

execute
{
  writeln("x = ",x);
  writeln("y = ",y);
  writeln("z = ",z);
  writeln("t = ",t);
}

int r1=v[item(s,x-1)];
int r2=v2[item(s,y-1)][item(s,z-1)];
int r3=item(v3,<t>).b;

execute
{
  writeln("v[item(s,x-1)] = ",r1," with vexpr[x]==2");
  writeln("v2[item(s,y-1)][item(s,z-1)] = ",r2," with v2expr[y][z]==5 ");
  writeln("item(v3,<t>).b = ",r3," with v3expr[t]==2");
}


/*

which gives

x = 2
y = 2
z = 1
t = 6
v[item(s,x-1)] = 2 with vexpr[x]==2
v2[item(s,y-1)][item(s,z-1)] = 5 with v2expr[y][z]==5 
item(v3,<t>).b = 2 with v3expr[t]==2

*/
