
/*
    using CP;

    range options=1..10;

    dvar interval itvs[options] optional in 1..3 size 1;

    cumulFunction c=sum(o in options) pulse(itvs[o],1);

    maximize sum(o in options) presenceOf(itvs[o]);

    subject to
    {

    // constant capacity

    c<=2;
    }
    
    */
    
// But sometimes capacity is not constant

// Now if the capacity is not a constant 2 but changes over time:
//
// 
//
//    // capacity 1 between 1 and 2
//    // capacity 2 between 2 and 3
//
//Then what can we do ?
//
// 
//
//We can rely on alwaysIn:

 

    using CP;

    range options=1..10;

    dvar interval itvs[options] optional in 1..3 size 1;

    cumulFunction c=sum(o in options) pulse(itvs[o],1);

    maximize sum(o in options) presenceOf(itvs[o]);

    subject to
    {

    // capacity 1 between 1 and 2
    // capacity 2 between 2 and 3

    alwaysIn(c,1,2,0,1);
    alwaysIn(c,2,3,0,2);
    }
   
// Or we could use 2 cumul

/*



    using CP;

    range options=1..10;

    dvar interval itvs[options] optional in 1..3 size 1;

    cumulFunction c=sum(o in options) pulse(itvs[o],1);

    cumulFunction c_bis=sum(o in options) pulse(itvs[o],1)
    +pulse(1,2,1);

    maximize sum(o in options) presenceOf(itvs[o]);

    subject to
    {

    // capacity 1 between 1 and 2
    // capacity 2 between 2 and 3

    c_bis<=2;
    c<=2;

    }


*/
