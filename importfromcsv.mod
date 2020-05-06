execute
    {

    function readCSV(csvfilename,datfilename,tuplesetname)
    {
        var quote="\"";

        var python=new IloOplOutputFile("c:\\temp\\readCSV.py");
        python.writeln("from pandas import *");
        python.writeln("df=read_csv(",quote,csvfilename,quote,",sep=\',\')");
        python.writeln("res = open(",quote,datfilename,quote,",",quote,"w",quote,")");
        python.writeln("res.write(",quote,tuplesetname,"={",quote,")");
        python.writeln("res.write(",quote,"\\","n",quote,")");
        python.writeln("for i, row in enumerate(df.values):");
       
        python.writeln("   res.write(",quote,"<",quote,")");
        python.writeln("   for j in row:");
        python.writeln("      if (j==j):");
        python.writeln("         res.write(str(j))");
        python.writeln("         res.write(\",\")");
        python.writeln("   res.write(\">,\")    ");
        python.writeln("   res.write(",quote,"\\","n",quote,")");
        python.writeln("res.write(\"};\")");
        python.writeln("res.close()");
        python.close();
        
        IloOplExec("C:\\Python36\\python.exe c:\\temp\\readCSV.py");
    }


    readCSV("c:\\\\temp\\\\friends.csv","c:\\\\temp\\\\friends.dat","s");

    }
    
/*
    
generates "friends.dat"
     
with
     
s={
<Jhon,35, Canada,>,
<Peter,29, USA,>,
<Alex,33, England ,>,
};

*/
