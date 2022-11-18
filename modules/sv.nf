
// NOTE VCF entries for alleles with no support are removed to prevent them from
//      breaking downstream parsers that do not expect them
process SNIFFLES {
    label "wf_human_sv"
    cpus 12
    memory 32.GB
    publishDir "${params.outdir}/sniffles-somatic", mode:"copy"
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


process FILTER_SNPS {
    
    cpus 12
    memory 32.GB
    publishDir "${params.outdir}/sniffles-somatic/filtered", mode:"copy"
    container "https://depot.galaxyproject.org/singularity/sniffles:2.0.7--pyhdfd78af_0"
    
    input:
    path VCF
    
    output:
    tuple val(sample_name),path("*${VCF}*")
    
    script:
    sample_name = VCF..getSimpleName() 
    """
    bcftools view -i 'FILTER="PASS"' \
    ${VCF} |\
    bgzip -c >  ${VCF}.pass.vcf.gz
    tabix -p vcf ${VCF}.pass.vcf.gz
    """
}

process ANNOTSV {
   publishDir "${params.outdir}/annotsv", mode:"copy"
   container "docker://ggrimes/annotsv:3.1.1"
   cpus 6
   memory 32.GB
   input:
    path VCF
    each  ANNOTDIR
        
   output:
    path "${sample_name}"

   script:
   """
    export ANNOTSV=/opt/AnnotSV
    /opt/AnnotSV/bin/AnnotSV \
    -SVinputFile ${VCF} \
    -bedtools `which bedtools` \
    -genomeBuild GRCh38 \
<<<<<<< HEAD
    -annotationsDir ${params.annotDir}
    -outputDir ${VCF.getSimpleName()}>& ${VCF.getSimpleName()}.log
=======
    -annotationsDir ${ANNOTDIR}
    -outputDir ${sample_name}>& ${sample_name}.log
>>>>>>> cc69e45cb61d6bcf5c9037db2fa6f5e09b637cc1
    """


}

/*
* Filter VCF for those variants that pass
*/
process FILTER_SV {
    publishDir "${params.outdir}/sniffles-somatic/filtered", mode:"copy"
    cpus 2
    memory 8.GB
    container "https://depot.galaxyproject.org/singularity/bcftools:1.16--hfe4b78e_1"
    input:
        path VCF
    output:
        path "*.vcf"    
    script:
    """
    bcftools view -i 'FILTER=="PASS"' ${VCF} > ${VCF.getSimpleName()}.pass.vcf
    """
    
} 
