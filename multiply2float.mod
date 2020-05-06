 /*
 
 Here, I want to help those who want to stay MIP and need to deal with

    dvar float x;
    dvar float y;

    subject to
    {
    x*y<=10;
    }

What you can do is remember that

    4*x*y=(x+y)*(x+y)-(x-y)(x-y)

So if you do a variable change X=x+y and Y=x-y

    x*y

becomes

    1/4*(X*X-Y*Y)

which is separable.

And then you are able to interpolate the function x*x by piecewise linear function:

    // y=x*x interpolation
    
    */
    


    int sampleSize=10000;
    float s=0;
    float e=100;

    float x[i in 0..sampleSize]=s+(e-s)*i/sampleSize;

    int nbSegments=20;

    float x2[i in 0..nbSegments]=(s)+(e-s)*i/nbSegments;
    float y2[i in 0..nbSegments]=x2[i]*x2[i];

    float firstSlope=0;
     float lastSlope=0;
     
     tuple breakpoint // y=f(x)
     {
      key float x;
      float y;
     }
     
     sorted { breakpoint } breakpoints={<x2[i],y2[i]> | i in 0..nbSegments};
     
     float slopesBeforeBreakpoint[b in breakpoints]=
     (b.x==first(breakpoints).x)
     ?firstSlope
     :(b.y-prev(breakpoints,b).y)/(b.x-prev(breakpoints,b).x);
     
     pwlFunction f=piecewise(b in breakpoints)
     { slopesBeforeBreakpoint[b]->b.x; lastSlope } (first(breakpoints).x, first(breakpoints).y);
     
     assert forall(b in breakpoints) f(b.x)==b.y;
     
     float maxError=max (i in 0..sampleSize) abs(x[i]*x[i]-f(x[i]));
     float averageError=1/(sampleSize+1)*sum (i in 0..sampleSize) abs(x[i]*x[i]-f(x[i]));
     
     execute
    {
    writeln("maxError = ",maxError);
    writeln("averageError = ",averageError);
    }

    dvar float a in 0..10;
    dvar float b in 0..10;
    dvar float squareaplusb;
    dvar float squareaminusb;

    maximize a+b;
    dvar float ab;
    subject to
    {
        ab<=10;
        ab==1/4*(squareaplusb-squareaminusb);
        
        squareaplusb==f(a+b);
        squareaminusb==f(a-b);
    }
    
