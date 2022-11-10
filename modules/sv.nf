
// NOTE VCF entries for alleles with no support are removed to prevent them from
//      breaking downstream parsers that do not expect them
process SNIFFLES {
    label "wf_human_sv"
    cpus params.threads
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
