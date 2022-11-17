
// NOTE VCF entries for alleles with no support are removed to prevent them from
//      breaking downstream parsers that do not expect them
process SNIFFLES {
    label "wf_human_sv"
    cpus params.threads
    publishDir "${params.outdir}/mosdepth", mode:"copy"
    container "https://depot.galaxyproject.org/singularity/sniffles:2.0.7--pyhdfd78af_0"
    input:
        tuple val(sample_name), path(bam)
        each path(reference)
        each path (tr)
    output:
        path "*.sniffles.vcf", emit: vcf
    script:
    """
    sniffles \
        --threads ${task.cpus} \
        --sample-id ${sample_name} \
        --reference ${reference} \
        --output-rnames \
        --input ${bam[0]} \
        --tandem-repeats ${tr} \
        --symbolic \
        --non-germline \
        --vcf ${sample_name}.sniffles.vcf
    """
}

process ANNOTSV {
   publishDir "${params.outdir}/annotsv", mode:copy
   input:
        path vcf
        
   output:
   path "${sample_name}"

   script:
   """
      export ANNOTSV=./AnnotSV
    ./AnnotSV/bin/AnnotSV \
    -SVinputFile ${vcf} \
    -bedtools `which bedtools` \
    -genomeBuild GRCh38 \
    -outputDir ${sample_name}>& ${sample_name}.log
    """


}
