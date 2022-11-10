# nanosv

A nextflow pipeline for somatic sv calling using ONT data from bam files


* mosdepth
* sniffles2
* annotation
* visualisation samplots


~~~
module load igmm/bac/nextflow/22.04.0.5697
nextflow run ggrimes/nanosv --bam "nanoseq_results/minimap2/*.{bam,bam.bai}" --tr resources/human_GRCh38_no_alt_analysis_set.trf.bed --ref reference.fa -resume
~~~
