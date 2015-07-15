#!/bin/sh

BASE=$(cd $(dirname $0); pwd)

for n in 4 #TODO: �m�[�h��
do
	cd "$BASE"
	mkdir "N$n"
	for t in 100 #TODO: ���ԕ�
	do
		mkdir "N$n/t$t"
		for p in 0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1
		do
			cd "$BASE"
			mkdir "N$n/t$t/p$p"
			for (( try = 1 ; try <= 1 ; try++ )) #TODO:�@���s�񐔂��̂P
			do
				if [ $p == 1 ] && [ $try -gt 1 ]
                		then
                       			continue
                		fi
				
				# �l�b�g���[�N�쐬
				mkdir "N$n/t$t/p$p/$try"
				R --vanilla --slave --args $n $t $p $try < create_random_tn.R
				
				# ���s�̌���
				for s in 2 #TODO: �����L���O�ύX�Ԋu(���ԕ�/�萔)
				do
					span=$(( $t / $s ))
					
					# �������Ԃ̍X�V
					target="["
					for (( ss = 1 ; ss <= $(($s-1)) ; ss++ ))
					do
        					tt=$(($ss*$span))
        					target=$target$tt
        					if [ $ss != $(($s-1)) ]
        					then
                					target=$target","
        					fi
					done
					target=$target"]"
					echo "function [target]=roctarget()" > $w/my_tools/roctarget.m
					echo "target = $target;" >> $w/my_tools/roctarget.m

					cd "$BASE"
					cd "N$n/t$t/p$p/$try/"
					cp $w/master_script/reverse_ranking.R .
					mkdir "span$span/"
					mkdir "span$span/reverse_ranking"
					for q in 0.5 0.6 0.7 0.8 0.9 1
					do
						cd "$BASE"
                                               	cd "N$n/t$t/p$p/$try/"
						mkdir "span$span/reverse_ranking/q$q"
						for (( try2 = 1 ; try2 <= 1 ; try2++ )) #TODO: ���s�񐔂��̂Q
						do
							if [ $q == 1 ] && [ $try2 -gt 1 ]
                					then
                       						continue
                					fi

							cd "$BASE"
                                               		cd "N$n/t$t/p$p/$try/"
							mkdir "span$span/reverse_ranking/q$q/$try2"
							R --vanilla --slave --args $n $q $span $try2 < reverse_ranking.R
							cd "span$span/reverse_ranking/q$q/$try2/"

							# �f�B���N�g���̍쐬
							cp -r $w/master_script/dir/alert . 
							cp -r $w/master_script/dir/roc .
							cp -r $w/master_script/dir/centrality . 
							cp -r $w/master_script/dir/auc .
							cp -r $w/master_script/dir/anomaly_score .
							cp -r $w/master_script/dir/rscript .
							cp  $w/master_script/calc_all.m .
							cp  $w/master_script/data2matrix.R .

							# ���S���̌v�Z
							cd rscript
							R --vanilla --slave < close.R
						        R --vanilla --slave < degree.R
						        R --vanilla --slave < eigenvector.R
						        R --vanilla --slave < katz.R
						        R --vanilla --slave < pagerank.R
						        R --vanilla --slave < mmc.R
						        R --vanilla --slave < mmc1.R
						        R --vanilla --slave < mmc2.R
						        R --vanilla --slave < mmc3.R 
		
							# AUC�̌v�Z
							cd ../
							R --vanilla --slave < data2matrix.R
							matlab -nosplash -nodesktop -nodisplay -r calc_all
						done
					done
				done
			done
		done
	done
done
