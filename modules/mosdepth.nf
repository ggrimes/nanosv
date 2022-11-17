
//NOTE grep MOSDEPTH_TUPLE if changing output tuple
process MOSDEPTH {
    publishDir "${params.outdir}/mosdepth", mode:"copy"
    cpus 2
    memory 10.GB
    container "https://depot.galaxyproject.org/singularity/mosdepth:0.3.3--hdfd78af_1"
    input:
        tuple val(sample_name), path(bam)
    output:
        tuple \
            path("${sample_name}.regions.bed.gz"),
            path("${sample_name}.mosdepth.global.dist.txt"),
            path("${sample_name}.thresholds.bed.gz")
    script:
        """
        export MOSDEPTH_PRECISION=2 
        mosdepth \
        -x \
        -t $task.cpus \
        --by 500 \
        --thresholds 1,10,20,30,50,60,70,80,90,100 \
        --no-per-base \
        ${sample_name} \
        ${bam[0]}
        """
}
