
params.bam = "*.{bam,bam.bai}"
params.ref = "reference.fa"
params.tandem = "tandem.bed"

include { SNIFFLES } from './modules/sv'

bam_ch = channel.fromFilePairs(params.bam,checkIfExists:true).view()
ref_ch = channel.fromPath(params.ref,checkIfExists: true)
tr_ch = channel.fromPath(params.tandem ,checkIfExists: true)

log.info """\
  bam:   ${params.bam}
  ref:   ${params.ref}
  tr:    ${params.tr} 
""".stripIndent()

workflow {

 //MOSDEPTH(bam_ch)
 SNIFFLES(bam_ch,ref_ch,tr_ch)

}
