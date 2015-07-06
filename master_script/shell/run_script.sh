#!/bin/sh

# 全子階層において異常検知を行いAUCを計算する P固定バージョン
# 第一引数分試行する
# 1. 勝敗表から隣接行列データを計算
# 2. 異常スコアを計算しCSVを出力する
# 3. アラートを計算しCSVを出力する
# 4. 閾値を変化させFAR, Benefitを計算しCSVを出力する
# 5. ROC曲線を描画し、AUCtを計算しCSVを出力する

# 初期化
try=3
DIR=$(cd $(dirname $0); pwd)

# 引数確認
if [ $# -eq 1 ]
then
	try=$1
fi

for i in 1
#for i in 0.5 0.6 0.7 0.8 0.9 1
do
	for (( j = 1 ; j <= $try ; j++ ))
	do
		if [ $i == 1 ] && [ $j -gt 1 ]
		then 
			continue
		fi

		cd $DIR
		cd "../q$i/$j/"
		#R --vanilla --slave < data2matrix.R
		#matlab -nosplash -nodesktop -nodisplay -r anomaly_score
		#matlab -nosplash -nodesktop -nodisplay -r calc_alert
		#matlab -nosplash -nodesktop -nodisplay -r calc_roc
		matlab -nosplash -nodesktop -nodisplay -r calc_auc
	done
done
