/*

 DEA is a very useful tool for efficiency analysis : https://en.wikipedia.org/wiki/Data_envelopment_analysis

    "Data envelopment analysis (DEA) is a nonparametric method in operations research and economics for the estimation of production frontiers. It is used to empirically measure productive efficiency of decision making units (or DMUs). Although DEA has a strong link to production theory in economics, the tool is also used for benchmarking in operations management, where a set of measures is selected to benchmark the performance of manufacturing and service operations."

Good tutorial at http://mat.gsia.cmu.edu/classes/QUANT/NOTES/chap12.pdf 

*/


int nbDMU=...;
 
 int nbInputs= ...;
 int nbOutputs=...;
 
 range DMU=1..nbDMU;
 range Input=1..nbInputs;
 range Output=1..nbOutputs;
 
 // Input
 float X[DMU][Input]=...;
 // Output
 float Y[DMU][Output]=...;
 
 int refDMU=...; // We want to measure efficiency of that DMU
 
 assert refDMU in DMU;
 
 dvar float+ theta;
 dvar float+ lambda[DMU];
 
 minimize theta;
 
 subject to
 {
 
 forall(j in Input)  
     ctInput:
         sum(i in DMU) (lambda[i]*X[i][j]) <= theta*X[refDMU][j];
 forall(j in Output)
     ctOutput:
         sum(i in DMU) (lambda[i]*Y[i][j]) >= Y[refDMU][j];
         
 }
 
 execute
 {
 writeln("theta= ",theta);
 if (theta==1) writeln("Efficient DMU");
 else writeln("Not efficient DMU");
 writeln("lambda=",lambda);
 writeln();
 }
 
 // Loop to measure efficiency for all DMU
 main
 {
 thisOplModel.generate();
 
 for(var dmu in thisOplModel.DMU)
 {
     writeln("DMU",dmu);
     for(j in thisOplModel.Input) thisOplModel.ctInput[j].setCoef(thisOplModel.theta,-thisOplModel.X[dmu][j]);
     for(j in thisOplModel.Output) thisOplModel.ctOutput[j].LB=thisOplModel.Y[dmu][j];
     cplex.solve();
     thisOplModel.postProcess();
     
 }
 
 }
 
 /*
 
 Which gives
 
 DMU1
theta= 1
Efficient DMU
lambda= [1 0 0]

DMU2
theta= 0.773333333
Not efficient DMU
lambda= [0.26154 0 0.66154]

DMU3
theta= 1
Efficient DMU
lambda= [0 0 1]
 
 
 */
