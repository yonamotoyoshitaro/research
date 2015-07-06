# motegi masuda ‚Ì’†S«
d <- read.csv("../data.csv", header=TRUE, fileEncoding="utf-8")

# ‰Šú‰»
a <- 0.13
b <- -1/365
l.f <- unique(d$V3)
f <- length(l.f)
I <- matrix(nrow=f,ncol=f,0)
diag(I) <- 1
l.date <- unique(d$V1)
w.all <- c()
l.all <- c()
s.all <- c()

# ’†S«‚ÌŒvZ
for (i in 1:length(l.date)) {
	# —×Ús—ñ‚Ì¶¬
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

		A[lose,win] <- A[lose,win] + 1
	}

	# ‘ÎŠp¬•ª‚ğ‚O‚É
	diag(A) <- 0
	if (i == 1) {
		w <- t(A)%*%c(rep(1,f))
		l <- A%*%c(rep(1,f))
	} else {
		w <- t(A)%*%c(rep(1,f))+exp(b)*(I+a*t(A))%*%w
		l <- A%*%c(rep(1,f))+exp(b)*(I+a*A)%*%l
	}
	
	s <- w-l
	w.all <- rbind(w.all,w[,1])
        l.all <- rbind(l.all,l[,1])
	s.all <- rbind(s.all,s[,1])
	colnames(w.all) <- l.f
	colnames(l.all) <- l.f
	colnames(s.all) <- l.f

}
write.csv(s.all, "../centrality/mmc/data.csv", row.names=FALSE, fileEncoding="UTF-8");
write.csv(w.all, "../centrality/mmc/win.csv", row.names=FALSE, fileEncoding="UTF-8");
write.csv(l.all, "../centrality/mmc/lose.csv", row.names=FALSE, fileEncoding="UTF-8");
