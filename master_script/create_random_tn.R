# Random形式のテンポラルネットワークを生成
# 試合がランダムに行われるような試合データ

# 引数
args <- commandArgs(trailingOnly = T)

N <- as.numeric(args[1])	# ノード数(対応するフォルダを作ること)
W <- as.numeric(args[2]) 	# 期間(対応するフォルダを作ること)
P <- as.numeric(args[3]) 	# 枝の生成確率(対応するフォルダを作ること)
T <- as.numeric(args[4]) 	# 何回目の試行か

# ネットワークの生成
# 枝ID
ID <- 1

# ネットワーク
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
