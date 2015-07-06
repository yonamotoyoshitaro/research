#!/bin/sh

# �S�q�K�w�ɂ����Ĉُ팟�m���s��AUC���v�Z���� P�Œ�o�[�W����
# �����������s����
# 1. ���s�\����אڍs��f�[�^���v�Z
# 2. �ُ�X�R�A���v�Z��CSV���o�͂���
# 3. �A���[�g���v�Z��CSV���o�͂���
# 4. 臒l��ω�����FAR, Benefit���v�Z��CSV���o�͂���
# 5. ROC�Ȑ���`�悵�AAUCt���v�Z��CSV���o�͂���

# ������
try=3
DIR=$(cd $(dirname $0); pwd)

# �����m�F
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
