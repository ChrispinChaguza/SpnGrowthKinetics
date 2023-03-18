# SpnGrowthKinetics

## Output files from the GWAS analysis of pneumococcal growth features using FaST-LMM (not adjusting for serotype)

FaST-LMM output filename | Genetic variant type | Phenotype | Phenotype type
-- | -- | -- | -- 
FASTLMM.SNP.MaxOD.nocov.tsv | SNP | Maximum Growth Density (H) | Continuous
FASTLMM.SNP.lagPhase.nocov.tsv | SNP | Lag Phase Duration | Continuous
FASTLMM.SNP.maxH.nocov.tsv | SNP | Maximum Growth Change (Delta H) | Continuous
FASTLMM.SNP.r.nocov.tsv | SNP | Average Growth Rate (r) | Continuous
FASTLMM.SNP.rmax.nocov.tsv | SNP | Maximum Growth Rate (r max) | Continuous
FASTLMM.UNITIGs.MaxH.nocov.tsv | Unitigs | Maximum Growth Change (Delta H) | Continuous
FASTLMM.UNITIGs.MaxOD.nocov.tsv | Unitigs | Maximum Growth Density (H) | Continuous
FASTLMM.UNITIGs.lagPhase.nocov.tsv | Unitigs | Lag Phase Duration | Continuous
FASTLMM.UNITIGs.r.nocov.tsv | Unitigs | Average Growth Rate (r) | Continuous
FASTLMM.UNITIGs.rmax.nocov.tsv | Unitigs | Maximum Growth Rate (r max) | Continuous


## Output files from the GWAS analysis of pneumococcal growth features using FaST-LMM (adjusting for serotype)

FaST-LMM output filename | Genetic variant type | Phenotype | Phenotype type
-- | -- | -- | -- 
FASTLMM.SNP.MaxOD.cov.tsv | SNP | Maximum Growth Density (H) | Continuous
FASTLMM.SNP.lagPhase.cov.tsv | SNP | Lag Phase Duration | Continuous
FASTLMM.SNP.maxH.cov.tsv | SNP | Maximum Growth Change (Delta H) | Continuous
FASTLMM.SNP.r.cov.tsv | SNP | Average Growth Rate (r) | Continuous
FASTLMM.SNP.rmax.cov.tsv | SNP | Maximum Growth Rate (r max) | Continuous
FASTLMM.UNITIGs.MaxH.cov.tsv | Unitigs | Maximum Growth Change (Delta H) | Continuous
FASTLMM.UNITIGs.MaxOD.cov.tsv | Unitigs | Maximum Growth Density (H) | Continuous
FASTLMM.UNITIGs.lagPhase.cov.tsv | Unitigs | Lag Phase Duration | Continuous
FASTLMM.UNITIGs.r.cov.tsv | Unitigs | Average Growth Rate (r) | Continuous
FASTLMM.UNITIGs.rmax.cov.tsv | Unitigs | Maximum Growth Rate (r max) | Continuous

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

# Reference
Chrispin Chaguza, Daan W. Arends, Stephanie W. Lo, Indri Hapsari Putri, John A. Lees, Anne L. Wyllie, Daniel M. Weinberger, Stephen D. Bentley, Marien I. de Jonge4, Amelieke J.H. 
Cremers. **The capsule, lineage and specific loci strongly influence intrinsic pneumococcal growth features**. 2023. Submitted for publication.
