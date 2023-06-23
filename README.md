# Pairwise Genome Comparison Statistics

## Mandatory parameters

 * `--input`: path to a sample sheet in tab-separated format with one header
   line `id	file`, and one row per genome (ID and path to FASTA file).

## Optional parameters

 * `--skel`: path or URL to a "skeletton" Rmarkdown file.

## Run

See the [`makeGBreaksInputFile.sh`](https://github.com/oist/LuscombeU_ScramblingInTheTreeOfLife/blob/main/scripts/makeGBreaksInputFile.sh)
script in `oist/LuscombeU_ScramblingInTheTreeOfLife` for  an example on how
to construct an input file.  Then, run the pipeline.  If needed, do not forget
to give a path to a work directory writable by the compute node (at OIST, it
is on the `/flash` file system) using the `-w` option.

    nextflow run oist/plessy_nf_GenomicBreaks -profile oist --input input.tsv
 
## Test

To test the pipeline, just run it with the input file from GitHub.  This will
download a small alignment file between a SARS-CoV-2 genome and a SARS-CoV-2
contig assembly.

    nextflow run oist/plessy_nf_GenomicBreaks -profile oist --input https://github.com/oist/plessy_nf_GenomicBreaks/raw/main/input.tsv

## Tip

Cache the singularity image to avoid multiple downloads, using the
`singularity.cacheDir` option in `~/.nextflow/config`.
