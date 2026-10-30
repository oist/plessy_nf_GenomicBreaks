# Pairwise Genome Comparison Statistics

The version number is the one of the _GenomicBreaks_ package in the
`genomicbreaks` modules's Singularity image, plus 1 per changes in the
`skeleton.Rmd` file.

## Mandatory parameters

 * `--input`: path to a sample sheet in tab-separated format with one header
   line `id	file`, and one row per genome (ID and path to FASTA file).

## Optional parameters

 * `--skel`: path or URL to a "skeletton" Rmarkdown file.
 * `--trace_report_suffix`: suffix of the files in `pipeline_info/` (default:
   launch time, `yyyy-MM-dd_HH-mm-ss`).

## Execution reports

As in nf-core pipelines, each run writes in `<outdir>/pipeline_info/` an
execution report, a timeline, a trace, a DAG and the parameters of the run,
all suffixed with `--trace_report_suffix`, so that resumed or repeated runs
add files instead of overwriting them.  The trace has Nextflow's default
fields first, followed by requested resources, attempt, I/O counters and CPU model.

## Run

See the [`makeGBreaksInputFile.sh`](https://github.com/oist/LuscombeU_ScramblingInTheTreeOfLife/blob/main/scripts/makeGBreaksInputFile.sh)
script in `oist/LuscombeU_ScramblingInTheTreeOfLife` for  an example on how
to construct an input file.  Then, run the pipeline.  If needed, do not forget
to give a path to a work directory writable by the compute node (at OIST, it
is on the `/flash` file system) using the `-w` option.

    nextflow run oist/plessy_nf_GenomicBreaks -r main -profile oist --input your_input_file.tsv
 
## Test

The `test` profile runs the pipeline on the small alignment between a
SARS-CoV-2 genome and a SARS-CoV-2 contig assembly in `test_data/`, from any
launch directory.

    nextflow run oist/plessy_nf_GenomicBreaks -r main -profile oist,test

## nf-test

As in the nf-core template, `tests/default.nf.test` runs the `test` profile
and `modules/local/genomicbreaks/tests/main.nf.test` runs the process alone,
each in real and in `-stub` mode, and compares the outputs with the snapshots
in the `.snap` files.  The rendered HTML report is checked by name only; the
YAML statistics are checked by content.  The real mode needs the Singularity
image, for instance with the `oist` profile:

    nf-test test --profile +oist                    # all tests
    nf-test test tests/default.nf.test --profile +oist
    nf-test test --profile +oist --update-snapshot  # after an intended change of the outputs

The stub tests need no container.

## Test locally

    nextflow run . -profile oist,test # don't forget -w if the compute nodes can not write to the current directory.

## Tip

Cache the singularity image to avoid multiple downloads, using the
`singularity.cacheDir` option in `~/.nextflow/config`.
