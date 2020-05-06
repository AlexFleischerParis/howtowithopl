// serial runs

    range r=1..20;
        execute
        {
        d=new Date();

        writeln(d);

        for(i in r)
        {
        writeln(i);

        IloOplExec("C:\\ILOG\\CPLEX_Studio1210\\opl\\bin\\x64_win64\\oplrun.exe "+
        " -Dn="+i+" -Dnbthreads=1 c:\\temp\\scalableWarehouse.mod");
        }
        
        
        var d2=new Date();
        writeln("total time : ",(d2-d)/1000);
        }

