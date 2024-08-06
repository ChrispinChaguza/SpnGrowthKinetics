#!/usr/bin/env python

import os
import sys
import argparse
from progress.bar import Bar,FillingSquaresBar,FillingCirclesBar
import subprocess

def commandLineArguments():
    options = argparse.ArgumentParser(description='Filter KMERs based on minimum and maximum frequency (minor allele frequency)')
    options.add_argument('--kmers', 
            dest='kmers', 
            help='specify file containing kmer matrix (rows=kmers,cols=genome)')
    options.add_argument('--maf',
            dest='maf',
            default=0.05,
            type=float,
            help="specify value between 0-100")
    #options.add_argument('--output',
    #        dest='output',
    #        default='Kmer.matrix.filtered.txt',
    #        help='specify kmer file')
    #options.add_argument('--unique',
    #        dest='unique',
    #        action='store_true',
    #        help='Save only unique kmer patterns')
    #options.add_argument('--keep',
    #        dest='keep',
    #        action='store_true',
    #        help='save excluded kmers')
    return options

def main():
        print("--->>>Checking input options")

        options=commandLineArguments()
        options=options.parse_args()
        inFile=options.kmers
        maf=options.maf
        outFile=str(os.path.basename(options.kmers).split(".")[0])+".filtered.txt"
        outFile1=str(os.path.basename(options.kmers).split(".")[0])+".removed.txt"
        #kmerTAGs=str(os.path.basename(options.kmers).split(".")[0])+".kmerTAGs.txt"
        #uniqueKmersOnly=options.unique
        #keepKmers=options.keep
        inputFile=""
        
        if not (os.path.exists(inFile) and os.path.isfile(inFile)):
            print("--->>>Input file "+str(inFile)+" does not exist")
            print("--->>>Specify correct file. Exiting")
            sys.exit()

        outputFile=open(outFile,"w")
   
        #if keepKmers:
        outputFile1=open(outFile1,"w")

        tmpCmd="wc -l "+str(inFile)+" | awk '{print $1}'"
        kmerFileLines=subprocess.Popen(tmpCmd,shell=True, stderr=subprocess.STDOUT, stdout=subprocess.PIPE)
        kmerLines=int(kmerFileLines.communicate()[0])
        kmerFileLines.kill()

        print("--->>>Processing kmer patterns")
        
        tmpKMER={}

        with FillingSquaresBar('', max=kmerLines-1) as bar, open(inFile,"r") as inputFile:
            for kmerCounter,kmerPattern in enumerate(inputFile):
                kmerID=kmerPattern.strip().split("\t")[0]
                kmerPattern=kmerPattern.strip().split("\t")[1:]
                kmerPatternStr=[str(kmerValues) for kmerValues in kmerPattern]
                tmpStr=".".join(kmerPatternStr)

                if kmerCounter==0:
                    outputFile.write("KmerID\t"+"\t".join(kmerPatternStr)+"\n")
                    outputFile1.write("KmerID\t"+"\t".join(kmerPatternStr)+"\n")
                    #tmpKMER[tmpStr]=["KmerID"]
                else:
                    #kmerID=kmerPattern.strip().split("\t")[0]
                    #kmerPattern=kmerPattern.strip().split("\t")[1:]
                    #kmerPatternStr=[str(kmerValues) for kmerValues in kmerPattern]
                    #tmpStr=".".join(kmerPatternStr)

                    #if tmpStr in tmpKMER.keys():
                    #    tmpKMER[tmpStr].append(kmerID)
                    #else:
                    #    tmpKMER[tmpStr]=[]
                    #    tmpKMER[tmpStr].append(kmerID)
                        
                    kmerPattern=[int(presencePattern) for presencePattern in kmerPattern]
                        
                    if sum(kmerPattern)>maf*len(kmerPattern) and sum(kmerPattern)<(1-maf)*len(kmerPattern):
                            #if uniqueKmersOnly:
                        outputFile.write(str(kmerID)+"\t"+"\t".join(kmerPatternStr).strip()+"\n")
                            #else:
                            #pass
                    else:
                        #if keepKmers:
                        outputFile1.write(str(kmerID)+"\t"+"\t".join(kmerPatternStr).strip()+"\n")
                        #else:
                        #pass

                bar.next()
        #bar.finish()
        outputFile.close()
        #sys.stdout.flush()
        print("--->>>Finished")

        #with open(kmerTAGs,"w") as outp:
        #    for kmer in tmpKMER.keys():
        #        outp.write(str(kmer)+"\t"+str(",".join(tmpKMER[kmer]))+"\n")

if __name__=="__main__":
    main()
