
params.bam = "*.{bam,bam.bai}"
params.ref = "reference.fa"
params.tr = "tandem.bed"
params.outdir = "results_nanosv"

include { SNIFFLES } from './modules/sv'
include {MOSDEPTH} from './modules/mosdepth.nf'

bam_ch = channel.fromFilePairs(params.bam,checkIfExists:true).view()
ref_ch = channel.fromPath(params.ref,checkIfExists: true)
tr_ch = channel.fromPath(params.tr  ,checkIfExists: true)

log.info """\
  bam:   ${params.bam}
  ref:   ${params.ref}
  tr:    ${params.tr} 
  outdir:${params.outdir}
""".stripIndent()

workflow {

 MOSDEPTH(bam_ch)
 //variant calling
 SNIFFLES(bam_ch,ref_ch,tr_ch)

}
