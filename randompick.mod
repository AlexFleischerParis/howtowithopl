 // for Monte Carlo or other simulation, we often need to pick a random combination of 
 // m elements among n elements.
// One may compute all possible combinations and thenuse rand to pick one.
// But we can write this in a much simpler way:


        int n=8;
        int m=3;
        
    //    execute
    //    {
    //    var i=new Date();    
    //    
    //    var t=Opl.srand(i.getMilliseconds())   ;
    //    }
        
        
        range r=1..n;

        // scripting way that will get m times 1

        range subr=1..m;
        int t[i in subr]=1+rand(n+1-i);
        {int} setn=asSet(r);

        int x2[i in r];

        execute
        {
        for(var i in subr)
        {
           var e=t[i];
           var e2=Opl.item(setn,e-1);
           x2[e2]=1;
           setn.remove(e2);
        }
        }

        assert card(setn)==n-m;

        int s2=sum(i in r) x2[i];

        execute
        {
        writeln(s2);
        }
        
        {int} result={i | i in r:x2[i]==1};
        
        execute
        {
        writeln("result = ",result);   
        }

 
/*
which may give

 

    3
    result =  {2 3 4}

but also all other combinations 

*/
