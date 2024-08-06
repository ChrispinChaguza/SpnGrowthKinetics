# SpnGrowthKinetics

## Input phenotype files for GEMMA

Phenotype files | Phenotype (growth feature)
-- | --
H.phe | Maximum Growth Change (Delta H)
L.phe | Maximum Growth Density (L) 
lag.phe | Lag Phase Duration
r.phe | Average Growth Rate (r)

## Input phenotype files for Pyseer

Phenotype files | Phenotype (growth feature)
-- | --
H.__.phe | Maximum Growth Change (Delta H)
L.__.phe | Maximum Growth Density (L)
lag.__.phe | Lag Phase Duration
r.__.phe | Average Growth Rate (r)


## Output files from the GWAS analysis of pneumococcal growth features using FaST-LMM (not adjusting for serotype)

Pyseer output filename | Phenotype 
-- | -- 
pyseer.lmm.Unitigs.H.out.tsv | Maximum Growth Change (Delta H)
pyseer.lmm.Unitigs.L.out.tsv | Maximum Growth Density (L)
pyseer.lmm.Unitigs.lag.out.tsv | Maximum Growth Density (L)
pyseer.lmm.Unitigs.r.out.tsv | Average Growth Rate (r)


## Output files from the GWAS analysis of pneumococcal growth features using FaST-LMM (adjusting for serotype)

Pyseer output filename | Phenotype                 
-- | --          
pyseer.lmm.Unitigs.H.out.SER.tsv | Maximum Growth Change (Delta H)
pyseer.lmm.Unitigs.L.out.SER.tsv | Maximum Growth Density (L)
pyseer.lmm.Unitigs.lag.out.SER.tsv | Maximum Growth Density (L)
pyseer.lmm.Unitigs.r.out.SER.tsv | Average Growth Rate (r)


## Unitig sequences

Unitig file | Description
-- | --
Unitigs.matrix.txt.tar.gz | Fasta file containing unitig sequences identified from all the isolates
Unitigs_ALL.matrix.R.tsv.tar.gz | Text file containing the presence and absence information for unitig in genomes of the isolates
Unitigs_ALL.matrix.T.txt.tar.gz | Text file containing the presence and absence information for unitig in genomes of the isolates
Unitigs_ALL.matrix.tsv.tar.gz | Text file containing the presence and absence information for unitig in genomes of the isolates
Unitigs_ALL.matrix.txt.tar.gz | Text file containing the presence and absence information for unitig in genomes of the isolates


## Sample commands used for the analysis

File name | Description
-- | --
bash.commands.txt | Some commands used for the analysis


## Scripts used for analysis

Script name | Description
-- | -- 
annotate_SNPs.py | Generates a summary of gene features in a reference genome given SNP position
blast_annotate_fasta.py | Generates a summary of genetic features in GenBank-formatted reference genome(s) associated with given unitig sequences
growth_curves.R | R code for generating the in vitro pneumococcal growth parameters
count_patterns.py | Counting number of unique unitig patterns (https://github.com/mgalardini/pyseer/blob/master/scripts/count_patterns.py)
makeMapPEDFromMatrix.py | Create PED and MAP-like files for PLINK, FaST-LMM, and GEMMA
createUnitigMatrix.sh | Script for generating the unitig presence and absence matrix
bifrost.sh | Script for generating the unitig presence and absence matrix

## Other files

File name | Description
-- | --
SPN_GROWTH_DATA_PLATES.tsv | Raw in vitro pneumococcal growth data
SpnGrowth.cov | Pyseer covariate file (serotypes)
ATCC700669.fasta |  Reference pneumococcal genome (for annotation and mapping)
ATCC700669.gb | Reference pneumococcal genome (for annotation and mapping)
Pneumoccal_Dutch_isolates.nwk | Phylogeny of the pneumococcal isolates used in the study
sim.mat.tsv | Genetic similarity matrix generated from the phylogeny for Pyseer GWAS created using https://github.com/mgalardini/pyseer/blob/master/scripts/phylogeny_distance.py
samples.R.txt | List of samples
samples.list | List of samples
samples.txt | List of samples (assembly files)


# Reference
Chrispin Chaguza, Daan W. Arends, Stephanie W. Lo, Indri Hapsari Putri, Anna York, John A. Lees, Anne L. Wyllie, Daniel M. Weinberger, Stephen D. Bentley, Marien I. de Jonge, Amelieke J.H. 
Cremers. **The capsule, lineage, and specific loci strongly influence intrinsic pneumococcal growth features**. 2023. Submitted for publication.

