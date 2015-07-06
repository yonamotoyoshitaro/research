#!/bin/sh
for i in 0.5 0.6 0.7 0.8 0.9
do
	for j in 1 2 3
	do
	cd "$w/human4/random/N10/t1500/p0.1/1/span300/reverse_ranking/q$i/$j/rscript"
	R --vanilla --slave < close.R
	R --vanilla --slave < degree.R
	R --vanilla --slave < eigenvector.R
	R --vanilla --slave < katz.R
	R --vanilla --slave < pagerank.R
	R --vanilla --slave < mmc.R
	R --vanilla --slave < mmc1.R
	R --vanilla --slave < mmc2.R
	R --vanilla --slave < mmc3.R
	done
done
