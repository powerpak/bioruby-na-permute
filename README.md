# Degenerate primer permutations

For a given primer sequence with degenerate bases in [IUPAC notation](http://en.wikipedia.org/wiki/Nucleic_acid_notation) this script prints out sequences for all the permutations that are possible.

## Usage

This script requires [BioRuby](http://bioruby.org/).

Pipe a FASTA formatted file into this script, and this script will output a new FASTA file with the new sequences on STDOUT.

For each FASTA entry ID, the new entry IDs for the permuted sequences will be appended with `_1`, `_2`, etc.  Note that the script does not check for entry ID collisions, e.g. if you used the same entry ID twice.
