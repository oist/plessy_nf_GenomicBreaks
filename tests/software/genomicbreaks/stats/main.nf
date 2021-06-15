#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

include { LAST_MAFCONVERT }     from '../../../../modules/nf-core/software/last/mafconvert/main.nf' addParams( options: [:] )
include { GENOMICBREAKS_STATS } from '../../../../software/genomicbreaks/stats/main.nf'             addParams( options: [:] )

workflow test_genomicbreaks_stats {
    
    input = [ [ id:'test', single_end:false ], // meta map
              file(params.test_data['sarscov2']['genome']['contigs_genome_maf_gz'], checkIfExists: true) ]

    skel = file("${launchDir}/tests/software/genomicbreaks/stats/skeleton.Rmd", checkIfExists: true)

    LAST_MAFCONVERT(input, "axt")
    GENOMICBREAKS_STATS ( LAST_MAFCONVERT.out.axt_gz, skel )
}
