
params.bam = "*.{bam,bam.bai}"
params.ref = "reference.fa"
params.tandem = "tandem.bed"

include { SNIFFLES } from './modules/sv'

bam_ch = channel.fromFilePairs(params.bam,checkIfExists:true).view()
ref_ch = channl.fromPath(params.ref,checkIfExists: true)

log.info """\
  bam ${params.bam}
  ref ${params.ref}
""".stripIndent()

workflow {

 //MOSDEPTH(bam_ch)
 SNIFFLES(bam_ch,ref_ch,params.tandem)

}
