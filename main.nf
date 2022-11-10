
params.bam = "*.bam"
params.ref = "reference.fa"

include { SNIFFLES } from './modules/sv'

bam_ch = channel.fromFilePairs(params.bam,checkIfExists: true)
ref_ch = channl.fromPath(,checkIfExists: true)

log.info """\
  bam ${params.bam}
  ref ${params.ref}
""".stripIndent()

workflow {

 //MOSDEPTH(bam_ch)
 SNIFFLES(bam_ch,ref_ch)

}
