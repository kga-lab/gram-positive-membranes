import pandas as pd
import numpy as np
import math
import matplotlib.pyplot as plt
from mpl_toolkits.axes_grid1 import make_axes_locatable
from matplotlib.ticker import FormatStrFormatter
from scipy.optimize import curve_fit
from sklearn.metrics import r2_score

plt.rcParams['axes.linewidth']=2.5
plt.rcParams['figure.dpi'] = 300
plt.rcParams['savefig.dpi'] = 300

def func(x,D,c):
    y = 1.0/((D*(x**4)) + (c*(x**2)))
    return y

################
data = np.loadtxt("Skavg.dat",comments=['@','#'])

x=data[:,0]
y=data[:,1]
x1=data[:,0][data[:,0]<0.45] #for fits where q < 0.45
y1=data[:,1][data[:,0]<0.45]
p, co = curve_fit(func,x1,y1)
perr = np.sqrt(np.diag(co))

D=p[0]
c=p[1]
D_stderr=perr[0]
c_stderr=perr[1]
print(D,D_stderr,c,c_stderr) 
yf= func(x1,D,c)
R2fit=r2_score(y1,yf)
print(R2fit)

####################PLOT 
fig=plt.figure() #figsize=(30,20))  #(48/28)
row=1
col=1
#grid=plt.GridSpec(row,col,wspace=0.18,hspace=0.30,width_ratios=[2,2,2], height_ratios=[2,2,2])  #wspace=0.15
grid=plt.GridSpec(row,col,wspace=0.18,hspace=0.30)
ax=plt.subplot(grid[0])
plt.scatter(data[:,0],data[:,1],color='blue',marker='o',s=50)
#plt.scatter(data2[:,0],data2[:,1],color='crimson',marker='o',s=30)

plt.plot(x1,yf,color='crimson',lw=2,ls='dotted')
plt.tick_params(direction='in',labelsize=15,length=4,width=1,pad=5)
plt.tick_params(which='minor',direction='in',labelsize=15,length=4,width=1,pad=5)
plt.xscale('log')
plt.yscale('log')
ax.set_xlim([0.1,5])
ax.set_title(r'$\kappa$ = '+str(np.round(D,2))+' kT',fontsize=20,x=0.5,y=0.8)
#plt.legend(prop={'size':40},frameon=False,handlelength=2,loc=1,ncol=4)
plt.xlabel(r'q (1/nm)',labelpad=10,fontsize=20)
plt.ylabel(r'S(q)',fontsize=20,labelpad=10)
plt.tight_layout
plt.savefig('Fig-bendingmodulus-saureus.png',dpi=300,format='png',bbox_inches = 'tight', pad_inches = 0.1,facecolor='w')
plt.show()
