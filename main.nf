
params.bam = "*.bam"
params.ref = "reference.fa"

include { SNIFFLES } from './modules/sv'


workflow {

  MOSDEPTH(bam_ch)
  SNIFFLES(bam_ch,ref_ch)

}
