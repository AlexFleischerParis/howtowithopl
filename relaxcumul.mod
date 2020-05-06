using CP;

    range options=1..10;

    dvar interval itvs[options] optional in 1..3 size 1;
    
    dvar int+ additionalCapacity in 0..3;

    cumulFunction c=sum(o in options) pulse(itvs[o],1);

    maximize sum(o in options) presenceOf(itvs[o])-1/10*additionalCapacity;

    subject to
    {

    // constant capacity

    c<=2+additionalCapacity;
    }
