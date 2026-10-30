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
    .map { row -> [ row, inputFile(row.file, params.input) ] }
    .set { input }

    GENOMICBREAKS_STATS (input, skel)
}

// A path of the sample sheet is resolved against the launch directory, as
// before.  A relative path that does not exist there is then resolved against
// the directory of the sample sheet, so that the test profile runs from any
// directory.
def inputFile(String path, String samplesheet) {
    def candidate = file(path)
    if ( !candidate.exists() && !(path ==~ /^(\/|[A-Za-z][A-Za-z0-9+.-]*:\/\/).*/) ) {
        candidate = file(samplesheet).parent.resolve(path)
    }
    return file(candidate.toUriString(), checkIfExists: true)
}
