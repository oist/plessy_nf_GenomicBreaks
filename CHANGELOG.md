# oist/plessy_nf_GenomicBreaks: Changelog

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/)
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [TBD](https://github.com/oist/plessy_nf_GenomicBreaks/releases/tag/TBD) "TBD" - [TBD]

- Compatibiltiy with 2026 Nextflow versions.
- Fix documentation on how to run tests.

## [v0.23.0.5](https://github.com/oist/plessy_nf_GenomicBreaks/releases/tag/0.23.0.5) "Isogashisugi" - [August 12th 2026]

- Fix the code that keeps only the longest 250 sequences.

## [v0.23.0.4](https://github.com/oist/plessy_nf_GenomicBreaks/releases/tag/0.23.0.4) "Hidokunai?" - [August 11th 2026]

- Keep only the longest 250 sequences, because some genomes that I use in a benchmark and that did not go through the stl_preprocess pipeline have more than one million contigs.

## [v0.23.0.3](https://github.com/oist/plessy_nf_GenomicBreaks/releases/tag/0.23.0.3) "Geki Kantan" - [July 30th 2026]

- Stop issuing pipeline version in the YAML output as it caused numeric to string conversions in the downstream pipeline.

## [v0.23.0.2](https://github.com/oist/plessy_nf_GenomicBreaks/releases/tag/0.23.0.2) "Motto Kantan" - [July 29th 2026]

- Further adjustments to nf-core/pairgenomealign version 3.

## [v0.23.0.1](https://github.com/oist/plessy_nf_GenomicBreaks/releases/tag/0.23.0.1) "Kantan" - [July 29th 2026]

- Move singularity image from Dropbox to GitHub.
- Load aligments in _blasttab+_ format.
