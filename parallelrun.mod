// parallel runs through ilooplexec

    range r=1..20;
    
        execute
        {
        d=new Date();

        writeln(d);
        
        var f=new IloOplOutputFile("c:\\temp\\parallel.bat");
        
        for(i in r)
        {
          writeln(i);
          f.writeln("start C:\\ILOG\\CPLEX_Studio1210\\opl\\bin\\x64_win64\\oplrun.exe "+
        " -Dn="+i+" -Dnbthreads=1 c:\\temp\\scalableWarehouse.mod ");
        }   
        
        
        f.close();

        IloOplExec("c:\\temp\\parallel.bat");
        
        
        
        var d2=new Date();
        writeln("total time : ",(d2-d)/1000);
        
        }

// 180 s with regards to 540 s with the serial version
