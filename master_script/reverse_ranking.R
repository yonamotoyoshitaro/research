# ����̊Ԋu�Ń����L���O�𐳔��΂ɓ���ւ���
# �����L���O����̂��͉̂��̎҂Ɋm��q�ŏ���

# ����
args <- commandArgs(trailingOnly = T)

N <- as.numeric(args[1])        # �m�[�h��(�Ή�����t�H���_����邱��)
P <- as.numeric(args[2])        # �����m��(�Ή�����t�H���_����邱��)
span <- as.numeric(args[3])     # �����L���O��ύX����Ԋu(�Ή�����t�H���_����邱��)
T <- as.numeric(args[4])        # ����ڂ̎��s��

# �l�b�g���[�N�f�[�^
data <- read.csv("random.csv",header=TRUE, fileEncoding="utf-8")

# �����L���O
ranking <- c(1:N)

# ���t
date <- unique(data$V1)

# �����L���O�X�V�p�̊֐�
change_ranking <- function() {
        for(j in 1:length(ranking)) {
                ranking[j] <- length(ranking) - ranking[j] + 1
        }
        return(ranking)
}

# ���s�̌���
nd <- c()
cnt <- 0
ranking <- c(1:N)
for (i in 1:length(date)) {
        cnt <- cnt + 1

        # ����I�Ƀ����L���O���X�V
        if(span != 0 && cnt%%span == 0) {
                ranking <- change_ranking()
        }
        now <- date[i]

        d.sub <- subset(data, data$V1==now)
        id <- unique(d.sub$V2)
        for (j in 1:length(id)) {
                # 1�����̌���(2�s��)
                match <- subset(d.sub, d.sub$V2==id[j])

                if (nrow(match)>2) exit
                # �������s��ꂽ�t�H�[���[�V�����̃C���f�b�N�X��T��
                f1 <- match$V3[1]
                f2 <- match$V3[2]
                index1 <- -1
                index2 <- -1
                cnt2 <- 0
                for (k in 1:N) {
                        cnt2 <- cnt2 + 1
                        if(k == f1) index1 <- cnt2
                        if(k == f2) index2 <- cnt2
                }
                if(index1 == -1 || index2 == -1) exit
                # �����L���O�ɉ����ď��s������������
		u <- runif(1)
                if(ranking[index1] < ranking[index2]) {
			if(u <= P) {
                        	match$V4 = "W"
                        	match$V4[2] = "L"
			} else {
                        	match$V4 = "L"
                        	match$V4[2] = "W"
			}
                } else {
			if(u <= P) {
                        	match$V4 = "L"
                        	match$V4[2] = "W"
			} else {
                        	match$V4 = "W"
                        	match$V4[2] = "L"
			}
                }
                nd <- rbind(nd, match)
        }
}
write.csv(nd, paste("span", span, "/reverse_ranking/q", P, "/", T, "/data.csv", sep=''), row.names=FALSE, fileEncoding="UTF-8");