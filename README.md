# nanosv

A nextflow pipeline for somatic sv calling using ONT data from bam files


* mosdepth
* nanoplot
* nanocomp
* sniffles2
* annotation
* visualisation samplots


~~~
module load igmm/bac/nextflow/22.04.0.5697
nextflow run ggrimes/nanosv --bam "nanoseq_results/minimap2/*.{bam,bam.bai}" --tr resources/human_GRCh38_no_alt_analysis_set.trf.bed --ref reference.fa -resume
~~~

## AnnotSV

### installing CosmicCompleteCNA from COSMIC

Installing the data source:
AnnotSV needs the “CosmicCompleteCNA.tsv.gz” (2 genome versions available) file from
https://cancer.sanger.ac.uk/cosmic/download
 Put the “CosmicCompleteCNA.tsv.gz” file in the corresponding directory:
“$ANNOTSV/share/AnnotSV/Annotations_Human/FtIncludedInSV/COSMIC/GRCh37/
or
“$ANNOTSV/share/AnnotSV/Annotations_Human/FtIncludedInSV/COSMIC/GRCh38/
These files will be reprocessed and then removed the first time AnnotSV is executed.





## cramino

~~~
#get cramino https://github.com/wdecoster/cramino
cramino -t <threads> $bam > `basename $bam .bam`.log.txt
function multijoin() {     out=$1;     shift 1;     cat $1 | awk 'FS="\t"{print $1}' > $out;     for f in $*; do join -t$'\t'  --nocheck-order $out $f > tmp; mv tmp $out; done; }
~~~
