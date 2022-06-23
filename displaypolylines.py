
import numpy as np 
import matplotlib.pyplot as plt

f = open("c://temp//paramdisplaypolylines.txt", "r")

nblines=int(f.readline())

for it in range(0,nblines):
   
   xstring=f.readline()
   ystring=f.readline()
   colorstring=f.readline()


   x =  xstring.split(",")
   y =  ystring.split(",")
   colors =  colorstring.split(",")


   realcolors=["p","r","b","y","g","c"]

   l=len(x)

   

   x.append(x[0])
   y.append(y[0])

   for i in range(0,l):
      #print(x[i]," ",y[i])
      
    
      plt.plot([int(x[i]),int(x[i+1])],[int(y[i]),int(y[i+1])],
               color=realcolors[int(colors[i]) % len(realcolors)],marker='o')

plt.show()    
f.close()
