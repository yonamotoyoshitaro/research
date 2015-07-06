# Katzの中心性
d <- read.csv("../data.csv", header=TRUE, fileEncoding="utf-8")

# 初期化
a <- 0.1
l.f <- unique(d$V3)
f <- length(l.f)
l.date <- unique(d$V1)
s.all <- c()
I <- matrix(nrow=f,ncol=f,0)
diag(I) <- 1
D <- c(rep(1,f))

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
	# Katz
	s <- t(solve((I-a*A))%*%D)
	s.all <- rbind(s.all,s)
}
colnames(s.all) <- l.f
write.csv(s.all, "../centrality/katz/data.csv", row.names=FALSE, fileEncoding="UTF-8");
