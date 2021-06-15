#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

include { LAST_MAFCONVERT }     from './modules/nf-core/software/last/mafconvert/main.nf' addParams( options: [:] )
include { GENOMICBREAKS_STATS } from './software/genomicbreaks/stats/main.nf'             addParams( options: [:] )

workflow {
channel
    .value( params.skel )
    .map { filename -> file(filename, checkIfExists: true) }
    .set { skel }

channel
    .fromPath( params.input )
    .splitCsv( header:true, sep:"\t" )
    .map { row -> [ row, file(row.file, checkIfExists: true) ] }
    .set { input }
 
    LAST_MAFCONVERT(input, "axt")
    GENOMICBREAKS_STATS ( LAST_MAFCONVERT.out.axt_gz, skel )
}
