import numpy as np
import matplotlib.pyplot as plt

#adjust this filename to match your directory of the file
filename='/Users/thebl/OneDrive/UW/Zoo Bot/rawdatashadycove.csv'

#loading in the data; skipped the header collumn
data=np.loadtxt(filename,skiprows=1,delimiter=',')

#assigned the collumn for shell size to the object 'size'
L=len(data[:,0])

#Created an array called 'sizeMM' and assigned data collumn for whole population
sizeMM=np.zeros(L)
sizeMM=data[:,0]


#breeding group was a 1 for yes in 2nd collumn, so sum of collumn is # of breeding
#group individuals
totalBREED = sum(data[:,1])
sizebreed=np.zeros(totalBREED)

m=-1
for i in range (0,L):
    if data[i,1]==1:
        m=m+1
        sizebreed[m]=data[i,0]
        
#set size of plot in cm (X = width, Y = height)        
X=13
Y=10
#Making the plot
fig1=plt.figure(figsize = (X,Y))
plt.hist(sizeMM,bins=np.arange(0,60,1.0),color="lavender")
plt.xlabel("Shell Length in mm")
plt.ylabel("Frequency of Occurence")
plt.title("Nucella lamellosa Size Distrubution at Shady Cove, San Juan Island April 2018")
plt.hist(sizebreed,bins=np.arange(0,60,1.0),color="black")

plt.show()



#Statistics
avgALL=np.mean(sizeMM)
stdevALL=np.std(sizeMM)
avgBREED=np.mean(sizebreed)
stdevBREED=np.std(sizebreed)
print(avgALL,stdevALL,avgBREED,stdevBREED,min(sizeMM),max(sizeMM),min(sizebreed),max(sizebreed))
print("Total number of snails:",len(sizeMM))
print("Average shell length for whole population:",avgALL,"mm")
print("standard deviation in shell length for whole population:",stdevALL,"mm")
print("Average shell length for breeding group:",avgBREED,"mm")
print("standard deviation in shell length for breeding group:",stdevBREED,"mm")
