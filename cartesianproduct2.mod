// Cartesian product for a given number of sets

tuple Tset {
        {string} members;
}

{Tset} setOfTuples = {<{"1","2"}>,<{"4","5","6"}>,<{"8","9"}>};

// Here we have 3 dimensions

{Tset} result=union (k in item(setOfTuples,2).members,
     j in  item(setOfTuples,1).members,
     i in item(setOfTuples,0).members)
{<{i,j,k}>};

execute
{
  writeln(result);
}

/*

which gives

{<{"1" "4" "8"}> <{"2" "4" "8"}> <{"1" "5" "8"}> <{"2" "5" "8"}>
     <{"1" "6" "8"}> <{"2" "6" "8"}> <{"1" "4" "9"}>
     <{"2" "4" "9"}> <{"1" "5" "9"}> <{"2" "5" "9"}>
     <{"1" "6" "9"}> <{"2" "6" "9"}>}
     
     */