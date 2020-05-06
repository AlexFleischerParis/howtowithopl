// --------------------------------------------------------------------------
// Licensed Materials - Property of IBM
//
// 5725-A06 5725-A29 5724-Y48 5724-Y49 5724-Y54 5724-Y55
// Copyright IBM Corporation 1998, 2013. All Rights Reserved.
//
// Note to U.S. Government Users Restricted Rights:
// Use, duplication or disclosure restricted by GSA ADP Schedule
// Contract with IBM Corp.
// --------------------------------------------------------------------------

/****************************************************************** 
 * Life Game from Robert Bosch and Michael Trick, CP 2001, 
 * CPAIOR 2002.
 * Original model IP2 available at http://mat.gsia.cmu.edu/Life/
 * Basic integer program with birth constraints
 *
 * This model is greater than the size allowed in trial mode. 
 * You therefore need a commercial edition of CPLEX Studio to run this example. 
 * If you are a student or teacher, you can also get a full version through
 * the IBM Academic Initiative.
 *
 ******************************************************************/
using CP; // I added this line to lifegameip.mod



execute
{

cp.param.timelimit=60;

}

int n=30;
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

dvar int x[0..(n+2)*(n+2)-1];

maximize Obj;

subject to {

forall(i,j in Bord) Life[i][j]==x[i*(n+2)+j];

  //ct1:
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
  //ct5:
    sum( i in FirstHalf , j in Bord ) 
      Life[i][j] >= 
    sum( i in LastHalf , j in Bord ) 
      Life[i][j];
  //ct6:
    sum( i in Bord , j in FirstHalf ) 
      Life[i][j] >= 
    sum( i in Bord , j in LastHalf ) 
      Life[i][j];   
}
