import pandas as pd
import numpy as np

################
colnames=['x','y']
data = np.loadtxt("Skavg-v4.dat",comments=['@','#'])
df = pd.DataFrame(data,columns=colnames)
#print(df)
# Group by 'x' and calculate the mean of 'y' for each group
average_y = df.groupby('x')['y'].mean()
df2=df.groupby('x')['y'].mean()
xn=list(df2.index)
yn=list(df2)
cs=np.column_stack([xn,yn])
print(cs)
np.savetxt('Skavg.dat',cs,fmt='%.3f\t%.3f')
