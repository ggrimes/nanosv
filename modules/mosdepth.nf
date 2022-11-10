
//NOTE grep MOSDEPTH_TUPLE if changing output tuple
process MOSDEPTH {
    publishDir "${params.outdir}/mosdepth", mode:"copy"
    cpus 2
    container "https://depot.galaxyproject.org/singularity/mosdepth:0.3.3--hdfd78af_1"
    input:
        tuple val(sample_name), path(bam)
    output:
        tuple \
            path("${params.sample_name}.regions.bed.gz"),
            path("${params.sample_name}.mosdepth.global.dist.txt"),
            path("${params.sample_name}.thresholds.bed.gz")
    script:
        mosdepth \
        -x \
        -t $task.cpus \
        --thresholds 1,10,20,30,50,60,70,80,90,100 \
        --no-per-base \
        ${params.sample_name} \
        ${bam}
        """
}
