

    tuple point {
    float latitude;
    float longitude;
    };

    float PI;

    execute
    {
    PI=Math.PI;
    }

    {point} points = ...;

    {point} pointsRadian={<p.latitude*PI/180,p.longitude*PI/180> | p in points};

    float  earthRadiusKms = 6376.5;


    // Cities
    int     n       = card(points);
    range   Cities  = 1..n;

    point pRadian[c in Cities]=item(pointsRadian,c-1);

    // Edges -- sparse set
    tuple       edge        {int i; int j;}
    setof(edge) Edges       = {<i,j> | ordered i,j in Cities};
    float         dist[Edges];

    execute compute_distances
    {
    writeln(n," points");

    for(e in Edges)
    {
      dist[e]=earthRadiusKms*Math.acos(
      Math.sin(pRadian[e.i].latitude)*Math.sin(pRadian[e.j].latitude)+
      Math.cos(pRadian[e.i].latitude)*Math.cos(pRadian[e.j].latitude)*
      Math.cos(pRadian[e.j].longitude-pRadian[e.i].longitude));
     
      writeln("distance from ",e.i," to ",e.j," = ",dist[e]);
     
    }
    }


/*

 which gives

    11 points
    distance from 1 to 2 = 5008.091388904
    distance from 1 to 3 = 6677.455185205
    distance from 1 to 4 = 7790.364382739
    distance from 1 to 5 = 5008.091388904
    distance from 1 to 6 = 20032.365555615
    distance from 1 to 7 = 10016.182777808
    distance from 1 to 8 = 0
    distance from 1 to 9 = 2095.608018957
    distance from 1 to 10 = 2836.805544515
    distance from 1 to 11 = 3212.968853281
    distance from 2 to 3 = 2748.227646927
    distance from 2 to 4 = 6509.319132227
    distance from 2 to 5 = 3494.503141191
    distance from 2 to 6 = 15024.274166711
    distance from 2 to 7 = 13354.91037041
    distance from 2 to 8 = 5008.091388904
    distance from 2 to 9 = 6990.683723353
    distance from 2 to 10 = 7796.577300153
    distance from 2 to 11 = 8148.457920375
    distance from 3 to 4 = 4162.273650918
    distance from 3 to 5 = 2417.380052239
    distance from 3 to 6 = 13354.91037041
    distance from 3 to 7 = 11933.658168096
    distance from 3 to 8 = 6677.455185205
    distance from 3 to 9 = 8769.616053004
    distance from 3 to 10 = 9457.100063805
    distance from 3 to 11 = 9846.019348887
    distance from 4 to 5 = 3336.043897524
    distance from 4 to 6 = 12242.001172876
    distance from 4 to 7 = 7929.785501304
    distance from 4 to 8 = 7790.364382739
    distance from 4 to 9 = 9352.971477397
    distance from 4 to 10 = 9614.599355622
    distance from 4 to 11 = 9947.715796963
    distance from 5 to 6 = 15024.274166711
    distance from 5 to 7 = 10016.182777808
    distance from 5 to 8 = 5008.091388904
    distance from 5 to 9 = 6968.154654933
    distance from 5 to 10 = 7518.038417735
    distance from 5 to 11 = 7905.702847421
    distance from 6 to 7 = 10016.182777808
    distance from 6 to 8 = 20032.365555615
    distance from 6 to 9 = 17936.757536658
    distance from 6 to 10 = 17195.560011101
    distance from 6 to 11 = 16819.396702334
    distance from 7 to 8 = 10016.182777808
    distance from 7 to 9 = 9192.24326288
    distance from 7 to 10 = 8525.381590705
    distance from 7 to 11 = 8438.966484735
    distance from 8 to 9 = 2095.608018957
    distance from 8 to 10 = 2836.805544515
    distance from 8 to 11 = 3212.968853281
    distance from 9 to 10 = 830.681781355
    distance from 9 to 11 = 1158.377782719
    distance from 10 to 11 = 390.965210663


*/
