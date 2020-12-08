

int n=400;
range r=1..n;

// Random graph  
float edge_prob=0.5;
int  weight_range=10;
int big=100000;
 
tuple t
{
  int i;
  int j;
}

{t} s={<i,j> | ordered i,j in r};

int w[i in r][j in r]=(i<=j)?((rand(big)<=big*edge_prob)?rand(weight_range):0):0;

// end of random graph

//int n=4;
//range r=1..n;
//float w[r][r]=
//
//[[ 0. , 8. ,-9. , 0.],
// [ 8. , 0. , 7. , 9.],
// [-9. , 7.  ,0., -8.],
// [ 0. , 9., -8. , 0.]];

assert card(s)==n*(n-1) div 2;

 // x is the unknown and 0 or 1 means in one or the other side of the fence
 dvar boolean x[r];
 
 dexpr float obj=2*sum(<i,j> in s) w[i][j]*x[i]*(1-x[j]);
 
 maximize obj;
 
 subject to
 {
   
 }
 
 {int} x1={i| i in r:x[i]==1};
 
 execute
 {
   writeln("objective = ",obj);
   writeln("x set to 1 : ",x1);
 }
