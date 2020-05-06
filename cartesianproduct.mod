// Cartesian product for an abritrary number of sets

    tuple Tset {
        {string} members;
    }
    {Tset} setOfTuples = {<{"1","2"}>,<{"4","5","6"}>,<{"8","9"}>};

    int dimresult=prod(i in 1..card(setOfTuples)) card(item(setOfTuples,i-1).members);

    {string} setPool[i in 1..dimresult]={}; // pool of sets
    {string} options[i in 1..card(setOfTuples)]=(item(setOfTuples,i-1).members);


    {Tset} result={};

    //For this particular example, the function needs to return:
    //{<{1,4,8}>,<{1,4,9}>,<{1,5,8}>,<{1,5,9}>,<{1,6,8}>,<{1,6,9}>,<{2,4,8}>,<{2,4,9}>,<{2,5,8}>,<{2,5,9}>,<{2,6,8}>,<{2,6,9}>}

    execute
    {

    options;

    function nextone(ndimension,sizes,e)
    {
     e[1]++;
     for(j=1;j<=ndimension;j++)
     {
       if (e[j]>= sizes[j] )
       {
         e[j]=0;
         e[j+1]++;   
       }
     }
     
    }


    var dim=setOfTuples.size;
    writeln("dim=",dim);
    var sizes=new Array(dim);
    var e=new Array(dim);
    var dimresult=1;
    for(var i=1;i<=dim;i++)
    {
        sizes[i]=Opl.item(setOfTuples,i-1).members.size;
        e[i]=0;
        dimresult*=sizes[i];
        writeln(sizes[i]);
    }

     

    for(var i=1;i<=dimresult;i++)
    {
       
       for(var j=1;j<=dim;j++)
       {
          write(e[j]," ");
          
          setPool[i].add(Opl.item(options[j],e[j]));
       }   
       writeln();
       nextone(dim,sizes,e);
       result.add(setPool[i]);
    }
    writeln(result);
    }

//which gives
//
//    {<{"1" "4" "8"}> <{"2" "4" "8"}> <{"1" "5" "8"}> <{"2" "5" "8"}>
//         <{"1" "6" "8"}> <{"2" "6" "8"}> <{"1" "4" "9"}>
//         <{"2" "4" "9"}> <{"1" "5" "9"}> <{"2" "5" "9"}>
//         <{"1" "6" "9"}> <{"2" "6" "9"}>}

