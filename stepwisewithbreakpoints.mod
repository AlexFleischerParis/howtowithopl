     tuple breakpoint // y=f(x)
     {
      key float x;
      float y;
     }
     
     sorted { breakpoint } breakpoints={<0,0>,<1,1>,<2,4>};
      
     stepFunction f=stepwise(b in breakpoints:b!=first(breakpoints))
     { prev(breakpoints,b).y->b.x; last(breakpoints).y } ;
     
     
    assert forall(b in breakpoints) f(b.x)==b.y;
