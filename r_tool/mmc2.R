# ���S���̒l��csv����ǂݎ���ĐV���Ȓ��S���̒l���v�Z����
# ���鎞�_�ł̐�Βl�̍��v�Ŋ����ĕW������������
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
	data <- c(rep(0, length=(n-1)))
	for(j in 2:n){
		col <- d[j,]

		# ���鎞�_�̃X�R�A���v�Z
		s_all = 0
		for(k in 1:length(f)) {
			t <-  abs(as.numeric(as.character(col[1,k])))
			s_all <- s_all + t	
		}
		s <- as.numeric(as.character(col[1,i]))
		data[j-1] <- s / s_all
	}
	new_data <- cbind(new_data, data)
}
colnames(new_data) <- names
write.csv(new_data, "../centrality/mmc2/data.csv", row.names=FALSE, fileEncoding="UTF-8");