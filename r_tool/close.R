# �ߖT���S��
d <- read.csv("../data.csv", header=TRUE, fileEncoding="utf-8")

# ������
l.date <- unique(d$V1)
l.f <- unique(d$V3)
f <- length(l.f)
s.all <- c()

# ���S���̌v�Z
for (i in 1:length(l.date)) {
	# �אڍs��̐���
	A <- matrix(nrow=f, ncol=f, 0)
	match.day <- unique(d$V1)[i]
        d.sub <- subset(d, d$V1==match.day)
        l.id <- unique(d.sub$V2)
        for (j in 1:length(l.id)) {
                d.sub2 <- subset(d.sub, d.sub$V2==l.id[j])
                if (nrow(d.sub2)>2) {print(j)}

                for (k in 1:length(l.f)) {
                        if ( d.sub2$V3[1] == l.f[k] & d.sub2$V4[1] == "W" ) {
                                win <- k
                        }
                        if ( d.sub2$V3[2] == l.f[k] & d.sub2$V4[2] == "W" ) {
                                win <- k
                        }
                        if ( d.sub2$V3[1] == l.f[k] & d.sub2$V4[1] == "L" ) {
                                lose <- k
                        }
                        if ( d.sub2$V3[2] == l.f[k] & d.sub2$V4[2] == "L" ) {
                                lose <- k
                        }
                }

                A[win,lose] <- A[win,lose] + 1
        }

	# ����matrix�̍쐬
	distance_matrix <- c()
	for(i in 1:f) {
		finish <- 0 			# �I���t���O
		cnt <- 1			# �������[�v����p
		target <- i 			# �Ώۃm�[�h
		checked_list <- c(rep(0,f)) 	# �m��t���O���X�g
		distance_list <- c(rep(f,f)) 	# �������X�g
		distance_list[target] <- 0
		while(!finish) {
			# �^�[�Q�b�g�m�[�h����Ȃ����Ă�m�[�h�Ԃ̋������v�Z
			# �������X�g���X�V����
			for(j in 1:f) {
				if(target==j || checked_list[j]) next
				if(A[target,j]) {
					if(distance_list[j]  > (distance_list[target]+1)) {
						distance_list[j] <- distance_list[target]+1
					}
				}		
			}
			checked_list[target] <- 1
		
			# ���̃^�[�Q�b�g���m�F
			# �m�肵�Ă��Ȃ������ŒZ�̃m�[�h
			new_target <- target
			min <- f
			for(j in 1:f) {
				if(!checked_list[j] && min > distance_list[j]) {
					new_target <- j
					min <- distance_list[j]
				}
			}	
			if(target==new_target) finish <- 1
			if(cnt > f) exit
			target <- new_target
			cnt <- cnt + 1
		}
		distance_matrix <- rbind(distance_matrix, distance_list)
	}

	# ���S���̌v�Z
	s <- c(rep(0,f)) 
	for(i in 1:f) {
		p <- 0
		for(j in 1:f) {
			if(i==j) next
			p <- p + distance_matrix[i, j] 
		}
		s[i] <- (f-1)/p
	}
	s.all <- rbind(s.all, s)
}
colnames(s.all) <- l.f
write.csv(s.all, "../centrality/close/data.csv", row.names=FALSE, fileEncoding="UTF-8");