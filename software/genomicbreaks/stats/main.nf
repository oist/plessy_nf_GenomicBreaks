// Import generic module functions
include { initOptions; saveFiles; getSoftwareName } from './functions'

params.options = [:]
options        = initOptions(params.options)

process GENOMICBREAKS_STATS {
    tag "$meta.id"
    label 'process_low'
    publishDir "${params.outdir}",
        mode: params.publish_dir_mode,
        saveAs: { filename -> saveFiles(filename:filename, options:params.options, publish_dir:getSoftwareName(task.process), meta:meta, publish_by_meta:['id']) }

//    conda (params.enable_conda ? "YOUR-TOOL-HERE" : null)
    if (workflow.containerEngine == 'singularity' && !params.singularity_pull_docker_container) {
//                 https://www.dropbox.com/scl/fi/<id>/<filename>?rlkey=<token>&dl=1
//                 https://www.dropbox.com/scl/fi/vjd08ymncytxm3kz9i0le/GenomicBreaks_0.21.0.sif?rlkey=2oa70vu5rm1vpy0bf4xj7awac&st=5rnpbr2e&dl=0
//                 https://dl.dropboxusercontent.com/scl/fi/<id>/<filename>?rlkey=<token>
        container "https://dl.dropboxusercontent.com/scl/fi/vjd08ymncytxm3kz9i0le/GenomicBreaks_0.21.0.sif?rlkey=2oa70vu5rm1vpy0bf4xj7awac"
    } else {
        error "Only the local Singularity image is supported"
//        container "quay.io/biocontainers/YOUR-TOOL-HERE"
    }

    errorStrategy 'retry'
    maxRetries 2

    input:
    tuple val(meta), path(maf)
    path(skel)

    output:
    tuple val(meta), path("*.yaml"), emit: yaml
    path "*.html"                  , emit: html
    path "*.version.txt"           , emit: version

    script:
    def software = getSoftwareName(task.process)
    def prefix   = options.suffix ? "${meta.id}${options.suffix}" : "${meta.id}"
    """
    cp ${skel} not-a-symbolic-link.Rmd
    R -e 'rmarkdown::render(
        "not-a-symbolic-link.Rmd",
        output_file = "./${prefix}.html",
        params = list(alnFile = "${maf}", prefix = "${prefix}"))'

    Rscript -e 'cat(packageDescription("GenomicBreaks")\$Version)' > ${software}.version.txt
    """
}
