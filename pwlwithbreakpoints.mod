/* 
 
 OPL supports piecewise linear functions, which are important in many applications. 
 In most cases, you specify piecewise linear functions by giving a set of slopes, 
 a set of breakpoints at which the slopes change, and the value of the functions at a given point. 
 The parameters are n breakpoints and n+1 slopes, and s -> b means that the slope s goes up to breakpoint b.
 
 But some find this a bit hard and prefer to enter sets of (x,y), 
 so let me help them through an example: 
 
*/

    //pwl1: y = x 0.5 (0, 0) (1, 1) (2, 4) 2.0  


     float firstSlope=0.5;
     float lastSlope=2.0;
     
     tuple breakpoint // y=f(x)
     {
      key float x;
      float y;
     }
     
     sorted { breakpoint } breakpoints={<0,0>,<1,1>,<2,4>};
     
     float slopesBeforeBreakpoint[b in breakpoints]=
     (b.x==first(breakpoints).x)
     ?firstSlope
     :(b.y-prev(breakpoints,b).y)/(b.x-prev(breakpoints,b).x);
     
     pwlFunction f=piecewise(b in breakpoints)
     { slopesBeforeBreakpoint[b]->b.x; lastSlope } (first(breakpoints).x, first(breakpoints).y);
     
     
    assert forall(b in breakpoints) f(b.x)==b.y;

