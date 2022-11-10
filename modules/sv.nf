
// NOTE VCF entries for alleles with no support are removed to prevent them from
//      breaking downstream parsers that do not expect them
process SNIFFLES {
    label "wf_human_sv"
    cpus params.threads
    container "https://depot.galaxyproject.org/singularity/sniffles:2.0.7--pyhdfd78af_0"
    input:
        tuple path(bam), path(bam_index)
        tuple path(reference), path(ref_idx), path(ref_cache)
    output:
        path "*.sniffles.vcf", emit: vcf
    script:
        def tr_arg = tr_bed.name != 'OPTIONAL_FILE' ? "--tandem-repeats ${tr_bed}" : ''
        def sniffles_args = params.sniffles_args ?: ''
        def ref_path = "${ref_cache}/%2s/%2s/%s:" + System.getenv("REF_PATH")
    """
    sniffles --input ${bam} --vcf output.vcf --non-germline
    sniffles \
        --threads $task.cpus \
        --sample-id ${params.sample_name} \
        --reference ${reference \}
        --output-rnames \
        --cluster-merge-pos $params.cluster_merge_pos \
        --input $bam \
        --tandem-repeats {tandem-repeats}\
        --non-germline \
        --vcf ${params.sample_name}.sniffles.vcf
    """
}
