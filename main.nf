#!/usr/bin/env nextflow

include { GENOMICBREAKS_STATS } from './modules/local/genomicbreaks/main.nf'

workflow {

// Record the parameters of the run next to the execution reports, as nf-core
// pipelines do.
def pipeline_info = file("${params.outdir}/pipeline_info")
pipeline_info.mkdirs()
pipeline_info.resolve("params_${params.trace_report_suffix}.json").text =
    groovy.json.JsonOutput.prettyPrint(groovy.json.JsonOutput.toJson(params)) + '\n'

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
