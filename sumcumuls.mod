/*

very simple sum of cumuls

*/

using CP;

range r=1..3;

dvar interval itvs[i in 1..3] in i..i+5 size 5;

// 3 simple cumuls
cumulFunction  ci[i in r]=pulse(itvs[i],i);

// sum of those 3 cumuls
cumulFunction sumc=sum(i in r) ci[i];

subject to
{
  sumc<=10;
}
