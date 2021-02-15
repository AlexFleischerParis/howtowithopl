/*

very simple sum of cumuls

and then we evaluate the cumul values within subject to block

*/

using CP;

range r=1..3;
int n=10;
int M=20;

dvar interval itvs[i in 1..3] in i..i+5 size 5;

// 3 simple cumuls
cumulFunction  ci[i in r]=pulse(itvs[i],i);

// sum of those 3 cumuls
cumulFunction sumc=sum(i in r) ci[i];

// And now all we use to get cumul values

// Array of the dates when we want the cumul values
int D[i in 0..n]=i;
dvar interval Date[i in 0..n] in D[i]..D[i]+1 size 1;

cumulFunction fm = sumc - sum(i in 1..n) pulse(Date[i],0,M);

dexpr int cumulvalue[i in 1..n] = -heightAtStart(Date[i], fm);



subject to
{
  sumc<=10;
  
  // Compute of 
  forall(i in 1..n) { alwaysIn(fm, Date[i], 0, 0);  }
}

execute
{
  writeln("cumulvalue =",cumulvalue);
}

assert forall(i in 0..n) cumulvalue[i]==cumulFunctionValue(sumc,i);

/*

which gives

value = [1 3 6 6 6 5 3 0 0 0]

*/

