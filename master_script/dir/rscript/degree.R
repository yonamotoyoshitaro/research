# ŽŸ”’†S«
d <- read.csv("../data.csv", header=TRUE, fileEncoding="utf-8")

# ‰Šú‰»
l.date <- unique(d$V1)
l.f <- unique(d$V3)
names <- c(rep(0, length(l.f)))
new_data <- c()

# ’†S«‚ÌŒvŽZ
for (i in 1:length(l.f)) {
	names[i] <- as.character(l.f[i])
	freq <- c(rep(0, length=(length(l.date))))
	for (j in 1:length(l.date)) {
		d.sub <- subset(d, d$V1==l.date[j] & d$V3==l.f[i] & d$V4=="W")
		freq[j] <- nrow(d.sub)
	}
	new_data <- cbind(new_data, freq)
}
colnames(new_data) <- names
write.csv(new_data, "../centrality/degree/data.csv", row.names=FALSE, fileEncoding="UTF-8");
