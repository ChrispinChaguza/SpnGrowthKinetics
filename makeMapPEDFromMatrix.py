#!/usr/bin/env python

import os
import sys
import numpy as np
from progress.bar import Bar,FillingSquaresBar,FillingCirclesBar

def main():
    print("--->>>Reading input data matrix")

    data=np.array([str(i).strip().split("\t") for i in open(sys.argv[1],"r")])
    pheno=[str(i).strip() for i in open(sys.argv[2],"r")]

    phenoData={}
        
    mapFile=open(os.path.basename(sys.argv[1]).split(".")[0]+".map","w")
    pedFile=open(os.path.basename(sys.argv[1]).split(".")[0]+".ped","w")

    print("--->>>Reading input phenotype data")

    with FillingSquaresBar('', max=len(pheno)) as bar:
        for m in pheno:
            tmpR=str(m).strip().split("\t")
            phenoData[tmpR[0]]=tmpR[2]
            bar.next()

    print("--->>>Creating .ped output file")

    with FillingSquaresBar('', max=data.shape[0]) as bar: 
        for i,j in enumerate(data):
            if i==0:
                pass
            else:
                tmpStr=""
                jj=[f for f in list(j)]
                for m,n in enumerate(jj):
                    if m==0:
                        #print("-->"+str(jj));sys.exit()
                        tmpStr=str(n)+"\t"+str(n)+"\t0\t0\t1\t"+str(phenoData[str(n)])
                    else:
                        tmpN=0
                        if(int(n)==0):
                            tmpN=2
                        else:
                            tmpN=1
                        tmpStr=tmpStr+"\t"+str(int(tmpN))+" "+str(int(tmpN))
                pedFile.write(tmpStr+"\n")
            bar.next()

    print("--->>>Creating .map output file")

    with FillingSquaresBar('', max=data.shape[0]) as bar:
        for k,l in enumerate(data[0]):
            if k!=0:
                mapFile.write("26\t"+str(l)+"\t0\t"+str(k)+"\n")
            bar.next()

    print("--->>>Finished")

if __name__=="__main__":
    main()
