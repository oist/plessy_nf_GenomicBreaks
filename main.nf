#!/usr/bin/env nextflow

include { GENOMICBREAKS_STATS } from './software/genomicbreaks/stats/main.nf' addParams( options: [:] )

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
 
    GENOMICBREAKS_STATS (input, skel)
}
