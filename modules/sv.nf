
// NOTE VCF entries for alleles with no support are removed to prevent them from
//      breaking downstream parsers that do not expect them
process sniffles2 {
    label "wf_human_sv"
    cpus params.threads
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
    export REF_PATH=${ref_path}
    sniffles \
        --threads $task.cpus \
        --sample-id ${params.sample_name} \
        --output-rnames \
        --cluster-merge-pos $params.cluster_merge_pos \
        --input $bam \
        $tr_arg \
        $sniffles_args \
        --vcf ${params.sample_name}.sniffles.vcf
    sed -i '/.:0:0:0:NULL/d' ${params.sample_name}.sniffles.vcf
    """
}
