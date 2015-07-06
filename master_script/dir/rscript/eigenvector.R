# 固有ベクトル中心性
d <- read.csv("../data.csv", header=TRUE, fileEncoding="utf-8")

# 初期化
l.f <- unique(d$V3)
f <- length(l.f)
l.date <- unique(d$V1)
s.all <- c()

# 中心性の計算
for (i in 1:length(l.date)) {
	# 隣接行列の生成
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
	# 固有値の計算
	z <- eigen(A)
	# 固有値が収束する場合の対応
	# 複素数の場合は実数部分の値を用いる
	for(j in 1:f) {
		if(z$values[j] == 1) {
			s.all <- rbind(s.all,Re(z$vectors[,j]))
			break;
		}
		if(j == f) {
			s.all <- rbind(s.all,Re(z$vectors[,1]))	
		} 
	}
}
colnames(s.all) <- l.f
write.csv(s.all, "../centrality/eigenvector/data.csv", row.names=FALSE, fileEncoding="UTF-8");
