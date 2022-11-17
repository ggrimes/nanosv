
// https://github.com/fakedrtom/SVAFotate
process SVAFotate {
    input:
    path vcf
    path SOURCE_BED //SVAFotate_core_SV_popAFs.GRCh38.bed.gz
    script:
    """
    svafotate annotate \
    -v in.vcf.gz \
    -o out.vcf \
    -b ${SOURCE_BED}
    """
}