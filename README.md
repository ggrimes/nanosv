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



cramino

~~~
#get cramino https://github.com/wdecoster/cramino
cramino -t <threads> $bam > `basename $bam .bam`.log.txt
function multijoin() {     out=$1;     shift 1;     cat $1 | awk 'FS="\t"{print $1}' > $out;     for f in $*; do join -t$'\t'  --nocheck-order $out $f > tmp; mv tmp $out; done; }
~~~
