# SpnGrowthKinetics

## Output files from the GWAS analysis of pneumococcal growth features using FaST-LMM (not adjusting for serotype)

FaST-LMM output filename | Genetic variant type | Phenotype | Phenotype type
-- | -- | -- | -- 
FASTLMM.SNP.L.nocov.tsv | SNP | Maximum Growth Density (L) | Continuous
FASTLMM.SNP.lag.nocov.tsv | SNP | Lag Phase Duration | Continuous
FASTLMM.SNP.H.nocov.tsv | SNP | Maximum Growth Change (Delta H) | Continuous
FASTLMM.SNP.r.nocov.tsv | SNP | Average Growth Rate (r) | Continuous
FASTLMM.UNIT.H.nocov.tsv | Unitigs | Maximum Growth Change (Delta H) | Continuous
FASTLMM.UNIT.L.nocov.tsv | Unitigs | Maximum Growth Density (L) | Continuous
FASTLMM.UNIT.lag.nocov.tsv | Unitigs | Lag Phase Duration | Continuous
FASTLMM.UNIT.r.nocov.tsv | Unitigs | Average Growth Rate (r) | Continuous


## Output files from the GWAS analysis of pneumococcal growth features using FaST-LMM (adjusting for serotype)

FaST-LMM output filename | Genetic variant type | Phenotype | Phenotype type
-- | -- | -- | -- 
FASTLMM.SNP.L.cov.tsv | SNP | Maximum Growth Density (L) | Continuous
FASTLMM.SNP.lagP.cov.tsv | SNP | Lag Phase Duration | Continuous
FASTLMM.SNP.H.cov.tsv | SNP | Maximum Growth Change (Delta H) | Continuous
FASTLMM.SNP.r.cov.tsv | SNP | Average Growth Rate (r) | Continuous
FASTLMM.UNIT.H.cov.tsv | Unitigs | Maximum Growth Change (Delta H) | Continuous
FASTLMM.UNIT.L.cov.tsv | Unitigs | Maximum Growth Density (L) | Continuous
FASTLMM.UNIT.lag.cov.tsv | Unitigs | Lag Phase Duration | Continuous
FASTLMM.UNIT.r.cov.tsv | Unitigs | Average Growth Rate (r) | Continuous

## Unitig sequences

Unitig file | Description
-- | --
Unitigs.mfa.tar.gz | Fasta file containing unitig sequences identified from all the isolates
Unitigs.matrix.tsv.tar.gz | Text file containing the presence and absence information for unitig in genomes of the isolates

## Scripts used to annotate SNPs and unitig sequences

Script name | Description
-- | -- 
annotate_SNPs.py | Generates a summary of gene features in a reference genome given SNP position
blast_annotate_fasta.py | Generates a summary of genetic features in GenBank-formatted reference genome(s) associated with given unitig sequences
growth_curves.R | R code for generating the in vitro pneumococcal growth parameters

## Other files

File name | Description
-- | --
SPN_GROWTH_DATA_PLATES.tsv | Raw in vitro pneumococcal growth data

# Reference
Chrispin Chaguza, Daan W. Arends, Stephanie W. Lo, Indri Hapsari Putri, John A. Lees, Anne L. Wyllie, Daniel M. Weinberger, Stephen D. Bentley, Marien I. de Jonge, Amelieke J.H. 
Cremers. **The capsule, lineage and specific loci strongly influence intrinsic pneumococcal growth features**. 2023. Submitted for publication.

