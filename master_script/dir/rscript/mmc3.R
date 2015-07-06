# win-loseの値をcsvから読み取って新たな中心性の値を計算する
# ある時点での絶対値の合計で割って標準化したものの差
# csvへの書き出しとプロットを行う

# 初期化
d  <- read.csv("../centrality/mmc/win.csv", header=FALSE, fileEncoding="utf-8")
d2 <- read.csv("../centrality/mmc/lose.csv", header=FALSE, fileEncoding="utf-8")
f <- d[1,]
n <- nrow(d)
new_data <- c()
names <- c(rep(0, length(f)))

# 各フォーメーションの中心性スコアを計算
for(i in 1:length(f)) {
	names[i] <- as.character(f[1,i])
	data <- c(rep(0, length=(n-1)))
	for(j in 2:n){
		col <- d[j,]
		col2 <- d2[j,]

		# ある時点のスコアを計算
		s_all = 0
		s_all2 = 0
		for(k in 1:length(f)) {
			t <-  as.numeric(as.character(col[1,k]))
			t2 <-  as.numeric(as.character(col2[1,k]))
			s_all <- s_all + t
			s_all2 <- s_all2 + t2
		}
		s <- as.numeric(as.character(col[1,i]))
		s2 <- as.numeric(as.character(col2[1,i]))
		data[j-1] <- s/s_all - s2/s_all2
	}
	new_data <- cbind(new_data, data)
}
colnames(new_data) <- names
write.csv(new_data, "../centrality/mmc3/data.csv", row.names=FALSE, fileEncoding="UTF-8");
