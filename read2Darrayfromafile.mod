

    int n1=5;
    int n2=4;
    range r1=1..n1;
    range r2=1..n2;

    int values[i in r1][j in r2]=0;

    execute
    {

    // Read in file the 2D array values with seperator sep and ranges range1 and range2
    function read2D(file,range1,range2,values,sep)
    {
    for(var i in r1)
    {
       line=file.readline();
       var ar=line.split(sep);
       var k=0;
       for(var j in r2)
       {
          values[i][j]=ar[k];
          k++;   
       }
    }

    }
    }
    execute
    {
    var f= new IloOplInputFile("v1.txt");
    read2D(f,r1,r2,values," ");
    f.close();

    writeln("values = ",values);
    }

/* 

which gives

 

    values =  [[1 2 3 4]
             [2 4 6 8]
             [3 6 9 12]
             [4 8 12 16]
             [5 10 15 20]] 
             
*/             
