# ���S���̒l��csv����ǂݎ���ĕW��������
# ���鎞�_�ł̍ő�l�Ŋ������l���w���̌��ɂ̂����l�ŕW������������
# csv�ւ̏����o���ƃv���b�g���s��

# ������
d <- read.csv("../centrality/mmc/data.csv", header=FALSE, fileEncoding="utf-8")
f <- d[1,]
n <- nrow(d)
new_data <- c()
names <- c(rep(0, length(f)))

# �e�t�H�[���[�V�����̒��S���X�R�A���v�Z
for(i in 1:length(f)) {
	names[i] <- as.character(f[1,i])
	plot_data <- c(rep(0, length=(n-1)))
	for(j in 2:n){
		col <- d[j,]

		# ���l�x�N�g���ɕϊ�
		for(k in 1:length(f)) {
			col[k] <-  as.numeric(as.character(col[1,k]))
		}

		# ���̎��Ԃɂ�����ő�l���擾
		max_row <- as.numeric(which.max(col))
		max <-  as.numeric(as.character(col[1,max_row])) 
		
		# ���鎞�_�̃X�R�A���v�Z
		s_all = 0
		for(k in 1:length(f)) {
			t <-  as.numeric(as.character(col[1,k])) / max
			s_all <- s_all + exp(t)	
		}
		s <- exp(as.numeric(as.character(col[1,i])) / max)
		plot_data[j-1] <- s / s_all
	}
	new_data <- cbind(new_data, plot_data)
}
colnames(new_data) <- names
write.csv(new_data, "../centrality/mmc1/data.csv", row.names=FALSE, fileEncoding="UTF-8");