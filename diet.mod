/*********************************************
 * OPL 12.6.3.0 Model
 * Author: FLEISCHER
 * Creation Date: 3 févr. 2016 at 11:05:00
 *********************************************/
 
tuple Food
{
	key string name;
	float unit_cost;
	float qmin;
	float qmax;
};

{Food} FOODS=...;

tuple Nutrient 
{
	key string name;
	float qmin;
	float qmax;
}

{Nutrient} NUTRIENTS=...;

tuple food_nutrients
{
	key string name;
	float q1;
	float q2;
	float q3;
	float q4;
	float q5;
	float q6;
	float q7;
}

{food_nutrients} FOOD_NUTRIENTS=...;

float array_FOOD_NUTRIENTS[f in FOODS][n in NUTRIENTS];

// turn tuple set into an array
execute
{
for(var fn in FOOD_NUTRIENTS) 
	for(var n in NUTRIENTS)
		array_FOOD_NUTRIENTS[FOODS.find(fn.name)][n]=fn[fn.getFieldName(1+Opl.ord(NUTRIENTS,n))];
}

// Decision variables
dvar float qty[f in FOODS] in f.qmin .. f.qmax;

// cost
dexpr float cost=sum (f in FOODS) qty[f]*f.unit_cost;

// KPI
dexpr float amount[n in NUTRIENTS] = sum(f in FOODS)
qty[f] * array_FOOD_NUTRIENTS[f,n];

minimize cost;
subject to
{
forall(n in NUTRIENTS) n.qmin<=amount[n]<=n.qmax;
}

execute
{
var f=new IloOplOutputFile("dietoutput.txt");
f.writeln("quantity = ",qty);
f.writeln("cost = ",cost);
f.writeln("amount = ",amount);
f.close();
}

