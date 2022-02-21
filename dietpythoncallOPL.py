# The goal of the diet problem is to select a set of foods that satisfies
# a set of daily nutritional requirements at minimal cost.
# Source of data: http://www.neos-guide.org/content/diet-problem-solver

import subprocess

FOODS = [
    ("Roasted Chicken", 0.84, 0, 10),
    ("Spaghetti W/ Sauce", 0.78, 0, 10),
    ("Tomato,Red,Ripe,Raw", 0.27, 0, 10),
    ("Apple,Raw,W/Skin", .24, 0, 10),
    ("Grapes", 0.32, 0, 10),
    ("Chocolate Chip Cookies", 0.03, 0, 10),
    ("Lowfat Milk", 0.23, 0, 10),
    ("Raisin Brn", 0.34, 0, 10),
    ("Hotdog", 0.31, 0, 10)
]

NUTRIENTS = [
    ("Calories", 2000, 2500),
    ("Calcium", 800, 1600),
    ("Iron", 10, 30),
    ("Vit_A", 5000, 50000),
    ("Dietary_Fiber", 25, 100),
    ("Carbohydrates", 0, 300),
    ("Protein", 50, 100)
]

FOOD_NUTRIENTS = [
    ("Roasted Chicken", 277.4, 21.9, 1.8, 77.4, 0, 0, 42.2),
    ("Spaghetti W/ Sauce", 358.2, 80.2, 2.3, 3055.2, 11.6, 58.3, 8.2),
    ("Tomato,Red,Ripe,Raw", 25.8, 6.2, 0.6, 766.3, 1.4, 5.7, 1),
    ("Apple,Raw,W/Skin", 81.4, 9.7, 0.2, 73.1, 3.7, 21, 0.3),
    ("Grapes", 15.1, 3.4, 0.1, 24, 0.2, 4.1, 0.2),
    ("Chocolate Chip Cookies", 78.1, 6.2, 0.4, 101.8, 0, 9.3, 0.9),
    ("Lowfat Milk", 121.2, 296.7, 0.1, 500.2, 0, 11.7, 8.1),
    ("Raisin Brn", 115.1, 12.9, 16.8, 1250.2, 4, 27.9, 4),
    ("Hotdog", 242.1, 23.5, 2.3, 0, 0, 18, 10.4)
]


def writedat(dat,tupleName,tupleInstance):
    dat.write(tupleName)
    dat.write('={\r')
    for f in tupleInstance:
      dat.write('<')
      for e in f:
          
          if not isinstance(e, str):
              dat.write(str(e))
          else:
              dat.write("\"");
              dat.write(e);
              dat.write("\"");
          dat.write(',');
      dat.write('>');     
      dat.write('\r');    
    dat.write('};\r');

    


def build_diet_model():

    dat = open('diet.dat','w')

    writedat(dat,'FOODS',FOODS);
    writedat(dat,'NUTRIENTS',NUTRIENTS);
    writedat(dat,'FOOD_NUTRIENTS',FOOD_NUTRIENTS);
     
    dat.close()

    subprocess.check_call(["C:/ILOG/CPLEX_Studio1210/opl/bin/x64_win64/oplrun.exe","diet.mod", "diet.dat"])  


build_diet_model()

"""

and in dietoutput.txt we will get

quantity =  [0 2.1552 0 0 0 10 1.8312 0 0.9297]
cost = 2.690409172
amount =  [2000 800 11.278 8518.4 25 256.81 51.174]

"""
    
