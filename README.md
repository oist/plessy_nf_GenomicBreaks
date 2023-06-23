# Pairwise Genome Comparison Statistics

## Mandatory parameters

 * `--skel`: path to a "skeletton" Rmarkdown file.

 * `--input`: path to a sample sheet in tab-separated format with one header
   line `id	file`, and one row per genome (ID and path to FASTA file).

See the [`makeGBreaksInputFile.sh`](https://github.com/oist/LuscombeU_ScramblingInTheTreeOfLife/blob/main/scripts/makeGBreaksInputFile.sh)
script in `oist/LuscombeU_ScramblingInTheTreeOfLife` for  an example on how
to construct an input file.

## Test

### test locally

    nextflow run oist/plessy_nf_GenomicBreaks -profile oist --input input.tsv --skel skeleton.Rmd
