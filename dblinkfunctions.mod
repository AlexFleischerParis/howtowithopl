 execute
{

// turn an OPL tupleset into a python list
function getPythonListOfTuple(tupleSet)
{

var quote="\"";
var nextline="\\\n";

var nbFields=tupleSet.getNFields();
var res="[";
for(var i in tupleSet)
{
res+="{";
for(var j=0;j<nbFields;j++)
{
res+=quote+tupleSet.getFieldName(j)+quote;
res+=":";
var value=i[tupleSet.getFieldName(j)];
if (typeof(value)=="string") res+=quote;
res+=value;
if (typeof(value)=="string") res+=quote;
res+=",";
res+=nextline;
}
res+="},";
}
res+="]";
return res;
}

// DBExecute
// dbName is the name of the database
// sql is the sql command
// pythonpath is the path for python executable
// pythonfile is the python program that will do the DBExecute
function DBExecute(dbName,sql,pythonpath,pythonfile)
{
writeln("DBExecute ",dbName," ",sql," ",pythonpath," ",pythonfile);

var python=new IloOplOutputFile(pythonfile);
python.writeln("import sqlite3");
python.writeln("conn = sqlite3.connect('"+dbName+"')");
python.writeln("cursor = conn.cursor()");
python.writeln("cursor.execute(",sql,")");
python.writeln("conn.commit()");
python.writeln("conn.close()");
python.close();
 
IloOplExec(pythonpath+" "+ pythonfile,true);        
//IloOplExec("C:\\Users\\IBM_ADMIN\\AppData\\Local\\Programs\\Python\\Python36\\python.exe c:\\DBExecute.py");
}

// DBUpdate
// dbName is the name of the database
// sql is the sql command
// tupleset is the tupleset we want to write into the database
// pythonpath is the path for python executable
// pythonfile is the python program that will do the DBExecute
function DBUpdate(dbName,sql,tupleset,pythonpath,pythonfile)
{
writeln("DBUpdate ",dbName," ",tupleset," ",pythonpath," ",pythonfile);

var python=new IloOplOutputFile(pythonfile);
python.writeln("import sqlite3");
python.writeln("conn = sqlite3.connect('"+dbName+"')");
python.writeln("cursor = conn.cursor()");

python.writeln("data = ",getPythonListOfTuple(tupleset));
python.writeln("cursor.executemany(",sql,",data)");

python.writeln("conn.commit()");

python.close();
        
//IloOplExec("C:\\Users\\IBM_ADMIN\\AppData\\Local\\Programs\\Python\\Python36\\python.exe c:\\DBUpdate.py");
IloOplExec(pythonpath+" "+ pythonfile,true);
}

// DBRead
// dbName is the name of the database
// sql is the sql command
// outputFileName is the name of the output .dat
// tuplesetname is the tupleset name in the output .dat
// pythonpath is the path for python executable
// pythonfile is the python program that will do the DBExecute
function DBRead(dbName,sql,outputFileName,tuplesetname,pythonpath,pythonfile)
{
writeln("DBRead ",dbName," ",sql," ",outputFileName," ",tuplesetname," ",pythonpath," ",pythonfile);

var quote="\"";
var antislash="\\";
var python=new IloOplOutputFile(pythonfile);
python.writeln("import sqlite3");
python.writeln("conn = sqlite3.connect('"+dbName+"')");
python.writeln("cursor = conn.cursor()");
python.writeln("cursor.execute(",sql,")");
python.writeln("rows = cursor.fetchall()");


python.writeln("res = open(",quote,outputFileName,quote,",",quote,"w",quote,")");
python.writeln("res.write(",quote,tuplesetname,"={",quote,")");
python.writeln("res.write(",quote,"\\","n",quote,")");
python.writeln("for row in rows:");
python.writeln("   res.write(",quote,"<",quote,")");
python.writeln("   for j in row:");
python.writeln("      if (j==j):");
python.writeln("         if (type(j)==str):");
python.writeln("            res.write(",quote,antislash,quote,quote,")");
python.writeln("         res.write(str(j))");
python.writeln("         if (type(j)==str):");
python.writeln("            res.write(",quote,antislash,quote,quote,")");
python.writeln("         res.write(\",\")");
python.writeln("   res.write(\">,\")    ");
python.writeln("   res.write(",quote,"\\","n",quote,")");
python.writeln("res.write(\"};\")");
python.writeln("res.close()");

python.close();

IloOplExec(pythonpath+" "+ pythonfile,true);
}


} 
