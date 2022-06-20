int n=10000;
range r=1..n;

int m=10;
int M=21;

// uniform distribution

// choose randomly n numbers between 0 and M-1 bounds included
int random1[i in r]=rand(M);

float av1=1/n*sum(i in r)random1[i];

// choose randomly n numbers between m and M-1 bounds included
int random2[i in r]=m+rand(M-m);

float av2=1/n*sum(i in r)random2[i];

// choose randomly n float numbers between 0 and 1, 1 excluded
float random3[i in r]=rand(maxint)/maxint;

float av3=1/n*sum(i in r)random3[i];

// normal distribution through Box–Muller transform
int BIG=1000000;
float x[i in r]=-1+2*rand(BIG)/BIG;
float y[i in r]=-1+2*rand(BIG)/BIG;;
 
float w[i in r]=sqrt(x[i]*x[i]+y[i]*y[i]);
{int} subsetr={i | i in r:w[i]<=1};

float w2[i in subsetr]=(-2*ln(w[i])/w[i]);
float x2[i in subsetr]=x[i]*w2[i];
float y2[i in subsetr]=y[i]*w2[i];

// the values of x2 and y2  obey a normal distribution

float avx2=1/card(subsetr)*sum(i in subsetr) x2[i];
float avy2=1/card(subsetr)*sum(i in subsetr) y2[i];

float stddevx2=sqrt( 1/card(subsetr)*sum(i in subsetr) pow(x2[i]-avx2,2));
float stddevy2=sqrt( 1/card(subsetr)*sum(i in subsetr) pow(y2[i]-avy2,2));

execute
{
  writeln("av1 = ",av1);
  writeln("av2 = ",av2);
  writeln("av3 = ",av3);
  writeln("avx2 = ",avx2);
  writeln("avy2 = ",avy2);
  writeln("stddevx2 = ",stddevx2);
  writeln("stddevy2 = ",stddevy2);
}

// We can do the same by calling java from OPL

int N=100000;
range R=1..N;
float uniform[R];
float gaussian[R];


execute{ 

var rnd = IloOplCallJava("java.util.Random", "<init>", "()");
rnd.setSeed(1);	
for(var i in R)
{			    			  
 uniform[i]=rnd.nextDouble();
 
}

for(var i in R)
{			    			  
 gaussian[i] = rnd.nextGaussian();
 
}
}

float meanU=1/N*sum(i in R)uniform[i];
float meanG=1/N*sum(i in R)gaussian[i];

float stdU=sqrt(1/N*(sum(i in R) (uniform[i]-meanU)^2));
float stdG=sqrt(1/N*(sum(i in R) (gaussian[i]-meanG)^2));


execute
{
 writeln(); 
 writeln("And now using scripting"); 
 writeln("Uniform");
 writeln("Mean = ",meanU);
 writeln("Std dev = ",stdU);
 writeln("sqrt(1/12) = ",Math.sqrt(1/12)," which is std dev of uniform between 0 and 1");
 writeln();
 writeln("Gaussian");
 writeln("Mean = ",meanG);
 writeln("Std dev = ",stdG);
 
}

/*

which can give

av1 = 10.017
av2 = 14.9814
av3 = 0.501438553
avx2 = 0.003682341
avy2 = 0.005292613
stddevx2 = 1.0253974
stddevy2 = 1.005016899

And now using scripting
Uniform
Mean = 0.499294295
Std dev = 0.288984266
sqrt(1/12) = 0.288675135 which is std dev of uniform between 0 and 1

Gaussian
Mean = 0.005901088
Std dev = 0.998125421

or other values

*/




