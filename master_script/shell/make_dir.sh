#!/bin/sh
i=$1
j=$2
mkdir "../q$i/$j/alert"
mkdir "../q$i/$j/anomaly_score"
mkdir "../q$i/$j/auc"
mkdir "../q$i/$j/centrality"
mkdir "../q$i/$j/roc"

MASTER="/cygdrive/c/Users/akihabara/Desktop/work/tamura/master_script"
cp "$MASTER/anomaly_score.m" "../q$i/$j/"
cp "$MASTER/calc_alert.m" "../q$i/$j/"
cp "$MASTER/calc_auc.m" "../q$i/$j/"
cp "$MASTER/calc_roc.m" "../q$i/$j/"
cp "$MASTER/data2matrix.R" "../q$i/$j/"

for k in "between" "close" "degree" "eigenvector" "katz" "mmc" "mmc1" "mmc2" "mmc3" "pagerank" 
do
	mkdir "../q$i/$j/centrality/$k"
done

mkdir "../q$i/$j/anomaly_score/node"
cp -r "../q$i/$j/centrality" "../q$i/$j/anomaly_score/node/"
mkdir "../q$i/$j/anomaly_score/whole"
mkdir "../q$i/$j/anomaly_score/whole/hirose"
mkdir "../q$i/$j/anomaly_score/whole/ide"
cp -r "../q$i/$j/centrality" "../q$i/$j/anomaly_score/whole/hirose/"
cp -r "../q$i/$j/centrality" "../q$i/$j/anomaly_score/whole/ide/"

mkdir "../q$i/$j/alert/dto"
mkdir "../q$i/$j/alert/dto/node"
mkdir "../q$i/$j/alert/dto/whole"
mkdir "../q$i/$j/alert/dto/whole2"
cp -r "../q$i/$j/centrality" "../q$i/$j/alert/dto/node/"
mkdir "../q$i/$j/alert/dto/whole/hirose"
mkdir "../q$i/$j/alert/dto/whole/ide"
mkdir "../q$i/$j/alert/dto/whole/node_or"
cp -r "../q$i/$j/centrality" "../q$i/$j/alert/dto/whole/hirose/"
cp -r "../q$i/$j/centrality" "../q$i/$j/alert/dto/whole/ide/"
cp -r "../q$i/$j/centrality" "../q$i/$j/alert/dto/whole/node_or/"
mkdir "../q$i/$j/alert/dto/whole2/mix_alert"
mkdir "../q$i/$j/alert/dto/whole2/mix_score"
mkdir "../q$i/$j/alert/dto/whole2/mix_alert/or"
mkdir "../q$i/$j/alert/dto/whole2/mix_alert/or/hirose"
mkdir "../q$i/$j/alert/dto/whole2/mix_alert/or/ide"
mkdir "../q$i/$j/alert/dto/whole2/mix_alert/or/node_or"

cp -r "../q$i/$j/alert/dto" "../q$i/$j/roc/"
cp -r "../q$i/$j/alert/dto" "../q$i/$j/auc/"
exit 0
