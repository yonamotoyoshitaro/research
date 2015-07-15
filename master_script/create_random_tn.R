# Random�`���̃e���|�����l�b�g���[�N�𐶐�
# �����������_���ɍs����悤�Ȏ����f�[�^

# ����
args <- commandArgs(trailingOnly = T)

N <- as.numeric(args[1])	# �m�[�h��(�Ή�����t�H���_����邱��)
W <- as.numeric(args[2]) 	# ����(�Ή�����t�H���_����邱��)
P <- as.numeric(args[3]) 	# �}�̐����m��(�Ή�����t�H���_����邱��)
T <- as.numeric(args[4]) 	# ����ڂ̎��s��

# �l�b�g���[�N�̐���
# �}ID
ID <- 1

# �l�b�g���[�N
TN <- c()

for(i in 1:W) {
	u <- runif(N*(N-1)/2)
	cnt <- 0
	for(j in 1:(N-1)) {
		for(k in (j+1):N) {
			cnt <- cnt+1
                	if(u[cnt] > P) {
				next
			}
			m1 <- c(1:4)
	                m2 <- c(1:4)
       	        	m1[1] <- i
                	m2[1] <- i
                	m1[2] <- ID
                	m2[2] <- ID
                	m1[3] <- j
                	m2[3] <- k
                	m1[4] <- "D"
                	m2[4] <- "D"
                	TN <- rbind(TN, m1)
                	TN <- rbind(TN, m2)
                	ID <- ID+1
		}
	}
}
write.csv(TN, paste("N", N, "/t", W, "/p", P, "/", T, "/random.csv", sep=''), row.names=FALSE, fileEncoding="UTF-8");