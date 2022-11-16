process NANOPLOT {
  input:
    tuple val sample_name,path(bam)
    
  container "https://depot.galaxyproject.org/singularity/nanoplot:A1.40.2--pyhdfd78af_0"
  
  script:
  """
  NanoPlot \
  --color yellow \
  --bam ${bam[0]} 
  """

}
