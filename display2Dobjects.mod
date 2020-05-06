// 2 ways to display 2D objects in OPL
// 1) Rely on the OPL gantt chart
// 2) Call Python from OPL

    int n=6;
    int Half=n div 2;
    range FirstHalf = 1..Half;
    range LastHalf = n-Half+1..n;
    range States = 0..1;
    range Bord = 0..(n+1);
    range Interior = 1..n;

    range obj = 0..(n*n);

    tuple neighbors {
       int row;
       int col;
    }

    {neighbors} Neighbor =
      {<(-1),(-1)>,<(-1),0>,<(-1),1>,<0,(-1)>,<0,1>,<1,(-1)>,<1,0>,<1,1>};

    dvar int Life[Bord][Bord] in States;
    dvar int Obj in obj;

    maximize Obj;

    subject to {
      ct1:
        Obj == sum( i , j in Bord )
          Life[i][j];
         
      forall( i , j in Interior ) {
        ct21:
          2*Life[i][j] - sum( nb in Neighbor )
            Life[i+nb.row][j+nb.col] <= 0;
        ct22:
          3*Life[i][j] + sum( nb in Neighbor )
            Life[i+nb.row][j+nb.col] <= 6;
        forall( ordered n1 , n2 , n3 in Neighbor ) {
          ct23:
            -Life[i][j]+Life[i+n1.row][j+n1.col]
                       +Life[i+n2.row][j+n2.col]
                       +Life[i+n3.row][j+n3.col]
            -sum( nb in Neighbor : nb!=n1 && nb!=n2 && nb!=n3 )
              Life[i+nb.row][j+nb.col] <= 2;
        }
      }
      forall( j in Bord ) {
        ct31:
          Life[0][j] == 0;
        ct32:  
          Life[j][0] == 0;
        ct33:  
          Life[j][n+1] == 0;
        ct34:  
          Life[n+1][j] == 0;
      }
      forall( i in Bord : i<n ) {
        ct41:
          Life[i][1]+Life[i+1][1]+Life[i+2][1] <= 2;
        ct42:
          Life[1][i]+Life[1][i+1]+Life[1][i+2] <= 2;
        ct43:
          Life[i][n]+Life[i+1][n]+Life[i+2][n] <= 2;
        ct44:
          Life[n][i]+Life[n][i+1]+Life[n][i+2] <= 2;
      }
      ct5:
        sum( i in FirstHalf , j in Bord )
          Life[i][j] >=
        sum( i in LastHalf , j in Bord )
          Life[i][j];
      ct6:
        sum( i in Bord , j in FirstHalf )
          Life[i][j] >=
        sum( i in Bord , j in LastHalf )
          Life[i][j];   
    }

// Use the Gantt    
tuple sequence_like {
   int start;
   int end;
   string label;
   int type;
 };   
 
{sequence_like} array2[i in 1..n] = {<j-1,j," ",Life[i][j]> | j in 1..n};

 
  execute noname {
    
   array2; // This array2 can be seen in the OPL IDE as a 2D view 
} 


    tuple LifeSolutionT{
        int Bord1;
        int Bord2;
        int value;
    };
    {LifeSolutionT} LifeSolution = {<i0,i1,Life[i0][i1]> | i0 in Bord,i1 in Bord};

    execute DISPLAY
    {

    var python=new IloOplOutputFile("c:/temp/display.py");
    python.writeln("import matplotlib.pyplot as plt");
    python.writeln("import numpy as np");
    python.writeln("grid=np.array(");

    python.writeln("[");
    for(var i in Bord)
    {
        python.writeln("[");
        for(var j in Bord) python.write(Life[i][j],",");
        python.writeln("],");
        ;
    }
    python.writeln("]");

    python.writeln(")");
    python.writeln("im = plt.imshow(grid, cmap='hot')");
    python.writeln("im.axes.get_xaxis().set_visible(False)");
    python.writeln("im.axes.get_yaxis().set_visible(False)");
    python.writeln("plt.show()");
    python.close();

    IloOplExec("C:\\Python36\\python.exe c:\\temp\\display.py");
    }

