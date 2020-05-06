  

// https://en.wikipedia.org/wiki/Power_set The powerset is the set of all subsets

    {string} s={"A","B","C","D"};
    range r=1.. ftoi(pow(2,card(s)));
    {string} s2 [k in r] = {i | i in s: ((k div (ftoi(pow(2,(ord(s,i))))) mod 2) == 1)};

    execute
    {
     writeln(s2);
    }


/*
which gives

 

    [{"A"} {"B"} {"A" "B"} {"C"} {"A" "C"} {"B" "C"} {"A" "B" "C"} {"D"} {"A" "D"}
             {"B" "D"} {"A" "B" "D"} {"C" "D"} {"A" "C" "D"} {"B" "C" "D"} {"A"
             "B" "C" "D"} {}]
             
             */

