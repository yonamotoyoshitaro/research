# 中心性の値をcsvから読み取って標準化する
# ある時点での最大値で割った値を指数の肩にのせた値で標準化したもの
# csvへの書き出しとプロットを行う

# 初期化
d <- read.csv("../centrality/mmc/data.csv", header=FALSE, fileEncoding="utf-8")
f <- d[1,]
n <- nrow(d)
new_data <- c()
names <- c(rep(0, length(f)))

# 各フォーメーションの中心性スコアを計算
for(i in 1:length(f)) {
	names[i] <- as.character(f[1,i])
	plot_data <- c(rep(0, length=(n-1)))
	for(j in 2:n){
		col <- d[j,]

		# 数値ベクトルに変換
		for(k in 1:length(f)) {
			col[k] <-  as.numeric(as.character(col[1,k]))
		}

		# その時間における最大値を取得
		max_row <- as.numeric(which.max(col))
		max <-  as.numeric(as.character(col[1,max_row])) 
		
		# ある時点のスコアを計算
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
