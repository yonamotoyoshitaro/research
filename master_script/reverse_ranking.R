# 特定の間隔でランキングを正反対に入れ替える
# ランキングが上のものは下の者に確率qで勝つ

# 引数
args <- commandArgs(trailingOnly = T)

N <- as.numeric(args[1])        # ノード数(対応するフォルダを作ること)
P <- as.numeric(args[2])        # 勝利確率(対応するフォルダを作ること)
span <- as.numeric(args[3])     # ランキングを変更する間隔(対応するフォルダを作ること)
T <- as.numeric(args[4])        # 何回目の試行か

# ネットワークデータ
data <- read.csv("random.csv",header=TRUE, fileEncoding="utf-8")

# ランキング
ranking <- c(1:N)

# 日付
date <- unique(data$V1)

# ランキング更新用の関数
change_ranking <- function() {
        for(j in 1:length(ranking)) {
                ranking[j] <- length(ranking) - ranking[j] + 1
        }
        return(ranking)
}

# 勝敗の決定
nd <- c()
cnt <- 0
ranking <- c(1:N)
for (i in 1:length(date)) {
        cnt <- cnt + 1

        # 定期的にランキングを更新
        if(span != 0 && cnt%%span == 0) {
                ranking <- change_ranking()
        }
        now <- date[i]

        d.sub <- subset(data, data$V1==now)
        id <- unique(d.sub$V2)
        for (j in 1:length(id)) {
                # 1試合の結果(2行分)
                match <- subset(d.sub, d.sub$V2==id[j])

                if (nrow(match)>2) exit
                # 試合が行われたフォーメーションのインデックスを探索
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
                # ランキングに応じて勝敗を書き換える
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
