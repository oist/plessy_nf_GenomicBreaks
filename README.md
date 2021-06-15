# Pairwise Genome Comparison Statistics

## Mandatory parameters

 * `--skel`: path to a "skeletton" Rmarkdown file.

 * `--input`: path to a sample sheet in tab-separated format with one header
   line `id	file`, and one row per genome (ID and path to FASTA file).

## Test

### test locally

    nextflow run ./main.nf -profile oist --input input.tsv --skel skeleton.Rmd
