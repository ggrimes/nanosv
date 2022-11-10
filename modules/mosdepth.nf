
//NOTE grep MOSDEPTH_TUPLE if changing output tuple
process MOSDEPTH {
    cpus 2
    input:
        tuple path(bam), path(bai)
        tuple path(ref), path(ref_idx), path(ref_cache)
    output:
        tuple \
            path("${params.sample_name}.regions.bed.gz"),
            path("${params.sample_name}.mosdepth.global.dist.txt"),
            path("${params.sample_name}.thresholds.bed.gz")
    script:
        """
        export REF_PATH=${ref}
        export MOSDEPTH_PRECISION=3
        mosdepth \
        -x \
        -t $task.cpus \
        --thresholds 1,10,20,30 \
        --no-per-base \
        ${params.sample_name} \
        $bam
        """
}
