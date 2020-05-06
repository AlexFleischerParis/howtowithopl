include "dblinkfunctions.mod";

tuple user
{
    string name;
    int age;
    string city;
    float weight;
}

{user}  users={<"Alice",30,"New York",23.3>,<"Bob",40,"London",2.8>};

string db="c:\\\\temp\\DBLINK.db";

string createTable="\"CREATE TABLE users(name TEXT,age INTERGER,city TEXT,weight REAL)\"";
string updateTable="\"INSERT INTO users(name, age,city,weight) VALUES(:name, :age, :city, :weight)\"";
string readTable="\"SELECT name, age, city, weight FROM users\"";

string DBExecutepythonpath="c:\\temp\\DBExecute.py";
string DBUpdatepythonpath="c:\\temp\\DBUpdate.py";
string DBReadpythonpath="c:\\temp\\DBRead.py";

string pythonpath="C:\\\\Python36\\python.exe";

execute
{
DBExecute(db,createTable,pythonpath,DBExecutepythonpath);
DBUpdate(db,updateTable,users,pythonpath,DBUpdatepythonpath);
DBRead(db,readTable,"c:\\\\temp\\\\res.dat","users",pythonpath,DBReadpythonpath);
} 

/*

This gives

DBExecute c:\\temp\DBLINK.db "CREATE TABLE users(name TEXT,age INTERGER,city TEXT,weight REAL)" C:\\Python36\python.exe c:\temp\DBExecute.py
DBUpdate c:\\temp\DBLINK.db  {<"Alice" 30 "New York" 23.3> <"Bob" 40 "London" 2.8>} C:\\Python36\python.exe c:\temp\DBUpdate.py
DBRead c:\\temp\DBLINK.db "SELECT name, age, city, weight FROM users" c:\\temp\\res.dat users C:\\Python36\python.exe c:\temp\DBRead.py


And in res.dat we ll have

users={
<"Alice",30,"New York",23.3,>,
<"Bob",40,"London",2.8,>,
<"Alice",30,"New York",23.3,>,
<"Bob",40,"London",2.8,>,
<"Alice",30,"New York",23.3,>,
<"Bob",40,"London",2.8,>,
};
*/
