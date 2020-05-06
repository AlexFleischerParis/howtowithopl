

    int n1=5;
    int n2=4;
    range r1=1..n1;
    range r2=1..n2;

    int values[i in r1][j in r2]=i*j;

    execute
    {

    // Write in file the 2D array values with seperator sep and ranges range1 and range2
    function write2D(file,range1,range2,values,sep)
    {
    for(var i in r1)
    {
    for(var j in r2)
    {
       file.write(values[i][j]);
       if (j!=range2.UB) file.write(sep);
    }
    if (i!=range1.UB) file.writeln();
    }
    }

    }

    execute
    {
    var f=new IloOplOutputFile("v1.csv");
    write2D(f,r1,r2,values,";");
    f.close();
    }

    execute
    {
    var f=new IloOplOutputFile("v1.txt");
    write2D(f,r1,r2,values," ");
    f.close();
    }

    execute
    {
    var f=new IloOplOutputFile("v2.txt");
    f.write(values);
    f.close();
    }


/*

 generates 3 files

v1.txt

    1 2 3 4
    2 4 6 8
    3 6 9 12
    4 8 12 16
    5 10 15 20

v1.csv

    1;2;3;4
    2;4;6;8
    3;6;9;12
    4;8;12;16
    5;10;15;20

that we can open with a text editor or even Excel

 

and v2.txt

    [[1 2 3 4]
             [2 4 6 8]
             [3 6 9 12]
             [4 8 12 16]
             [5 10 15 20]]

which relies on OPL format for 2 dimensions array 

*/
