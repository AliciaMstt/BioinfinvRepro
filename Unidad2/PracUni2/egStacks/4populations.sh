# Define variables

src=$HOME/research/project

#
# Calculate population statistics and export several output files.
#
populations -t 36 -b 1 -P $src/stacks/ -M $src/popmap \
			  -p 9 -f p_value -k -r 0.75 -s --structure --phylip --genepop
