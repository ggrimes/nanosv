
params.bam = "*.{bam,bam.bai}"
params.ref = "reference.fa"
params.tr = "tandem.bed"
params.outdir = "results_nanosv"
params.annotDir = "/exports/igmm/eddie/HGS-OvarianCancerA-SGP-WGS/ONT/software/AnnotSV/share/AnnotSV/"
params.sniffles_minsupport = "auto"

include { SNIFFLES;FILTER_SV;ANNOTSV } from './modules/sv'
include {MOSDEPTH} from './modules/mosdepth.nf'

bam_ch = channel.fromFilePairs(params.bam,checkIfExists:true).view()
ref_ch = channel.fromPath(params.ref,checkIfExists: true)
tr_ch = channel.fromPath(params.tr  ,checkIfExists: true)
annotDir_ch = channel.fromPath(params.annotDir  ,checkIfExists: true)

log.info """\
  bam:          ${params.bam}
  ref:          ${params.ref}
  tr:           ${params.tr} 
  minsupport:   ${params.sniffles_minsupport}
  outdir:       ${params.outdir}
""".stripIndent()

workflow {

 MOSDEPTH(bam_ch)
 //variant calling
 SNIFFLES(bam_ch,ref_ch,tr_ch)
 //filter vcf
 FILTER_SV(SNIFFLES.out)
 //annotate vcf
 ANNOTSV(FILTER_SV.out,annotDir_ch)

}
