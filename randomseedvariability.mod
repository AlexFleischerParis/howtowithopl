

    int n=30; // number of random seeds
    int d[1..n]; // duration
    int o[1..n]; // objective
    int iter[1..n]; // iterations
     
     // start of the model we want to test
     
     int Fixed        = 100;
    int NbWarehouses = 50;
    int NbStores     = 200;

    assert( NbStores > NbWarehouses );

    range Warehouses = 1..NbWarehouses;
    range Stores     = 1..NbStores;
    int Capacity[w in Warehouses] =
      NbStores div NbWarehouses +
      w % ( NbStores div NbWarehouses );
    int SupplyCost[s in Stores][w in Warehouses] =
      1 + ( ( s + 10 * w ) % 100 );
    dvar int Open[Warehouses] in 0..1;
    dvar float Supply[Stores][Warehouses] in 0..1;
    dexpr int TotalFixedCost = sum( w in Warehouses ) Fixed * Open[w];
    dexpr float TotalSupplyCost = sum( w in Warehouses, s in Stores )  SupplyCost[s][w] * Supply[s][w];
    minimize TotalFixedCost + TotalSupplyCost;

    subject to {
      forall( s in Stores )
        ctStoreHasOneWarehouse:
          sum( w in Warehouses )
            Supply[s][w] == 1;
      forall( w in Warehouses )
        ctOpen:
          sum( s in Stores )
            Supply[s][w] <= Open[w] * Capacity[w];
    }
     
    // end of the model we want to test


    main {

    thisOplModel.generate();


    var sum_d=0;
    var sum_o=0;;
    var sum_iter=0;

    writeln("seed objective iteration   runtime");

    for(var i=1;i<=thisOplModel.n;i++)
    {

        var opl=new IloOplModel(thisOplModel.modelDefinition);
        opl.generate();

        cplex.randomseed=i;

        
        
        
        var d1=new Date();
        cplex.solve();
        var d2=new Date();
        
        thisOplModel.d[i]=d2-d1;
        sum_d+=d2-d1;
        thisOplModel.d[i]=d2-d1;
        thisOplModel.o[i]=Opl.ftoi(Opl.round(cplex.getObjValue()));
        sum_o+=thisOplModel.o[i];
        thisOplModel.iter[i]=cplex.getNiterations();
        sum_iter+=thisOplModel.iter[i];
        writeln(i,"    ",thisOplModel.o[i],"     ",thisOplModel.iter[i],"       ",
        thisOplModel.d[i]/1000);
        cplex.clearModel();
    }    

    writeln("-----------------------------------------");
    writeln("average      ",sum_o/thisOplModel.n," ",
    sum_iter/thisOplModel.n," ",sum_d/thisOplModel.n/1000);
    writeln("std dev      ",Opl.standardDeviation(thisOplModel.o),"     ",
    Opl.standardDeviation(thisOplModel.iter),"     ",Opl.standardDeviation(thisOplModel.d)/1000);

    }
/*
which gives

    seed objective iteration   runtime
    1    4600     3039       0.416
    2    4600     1970       0.398
    3    4600     2458       0.431
    4    4600     3054       0.384
    5    4600     3434       0.33
    6    4600     3003       0.404
    7    4600     3677       0.424
    8    4600     3088       0.385
    9    4600     3885       0.465
    10    4600     2374       0.416
    11    4600     2837       0.364
    12    4600     3105       0.416
    13    4600     2801       0.357
    14    4600     5602       0.645
    15    4600     2647       0.383
    16    4600     3203       0.441
    17    4600     2635       0.4
    18    4600     3260       0.424
    19    4600     3756       0.339
    20    4600     3302       0.461
    21    4600     3630       0.446
    22    4600     3033       0.43
    23    4600     3362       0.375
    24    4600     2373       0.476
    25    4600     2598       0.353
    26    4600     1960       0.272
    27    4600     2832       0.445
    28    4600     3446       0.389
    29    4600     3379       0.424
    30    4600     2751       0.402
    -----------------------------------------
    average      4600 3083.133333333 0.409833333
    std dev      0     669.737149103     0.061352579

*/