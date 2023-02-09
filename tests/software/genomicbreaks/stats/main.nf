#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

include { GENOMICBREAKS_STATS } from '../../../../software/genomicbreaks/stats/main.nf'             addParams( options: [:] )

workflow test_genomicbreaks_stats {
    
    input = [ [ id:'test', single_end:false ], // meta map
              file('https://github.com/oist/GenomicBreaks/raw/main/inst/extdata/NeuCra__PodCom.III__7.gff3.gz', checkIfExists: true) ]

    skel = file("${launchDir}/tests/software/genomicbreaks/stats/skeleton.Rmd", checkIfExists: true)

    GENOMICBREAKS_STATS ( input, skel )
}
