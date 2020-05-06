// How to compute combinations, arrangements and permutations in OPL ?

int n=8;
 range s=1..n;
 
 int m=3;
 
 int fact[i in 1..n]=prod(j in 2..i) j;
 
 tuple t
 {
 int e1;
 int e2;
 int e3;
 };
 
 {t} combinations={<e1,e2,e3> | ordered e1,e2,e3 in s};
 
 assert card(combinations)==fact[n] div fact[m] div fact[n-m];
 
 {t} arrangements={<e1,e2,e3> | e1,e2,e3 in s : e1!=e2 && e2!=e3 && e1!=e3};
 
 assert card(arrangements)==fact[n] div fact[n-m];
 
 {t} permutations={<e1,e2,e3> | e1,e2,e3 in 1..m : e1!=e2 && e2!=e3 && e1!=e3};
 
 assert card(permutations)==fact[m]; 
