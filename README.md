# nanosv

A nextflow pipeline for somatic sv calling using ONT data from bam files


* mosdepth
* sniffles2
* annotation
* visualisation samplots


~~~
nextflow run ggrimes/nanosv --bam nanoseq_results/minimap2/ --tr resources/human_GRCh38_no_alt_analysis_set.trf.bed --ref reference.fa
~~~
