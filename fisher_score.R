setwd("~/Documents/cmb/semester-2/advanced-stats/project")
data.gpigs <- read.table("surv.gpigs.txt", header = TRUE, sep = ";")
data.gpigs$regime <- factor(data.gpigs$regime)

data.gpigs_cens <- data.gpigs[which(data.gpigs$censored == 0), ]
X <- data.gpigs_cens$lifetime
n <- length(X)
Xbar <- mean(X)
logXbar <- mean(log(X))

S <- function(a, g) {
  m <- matrix(data = c(digamma(a) + log(g) - logXbar, a/g - Xbar/g^2), nrow = 2, ncol = 1)
  return(-n * m)
}

I <- function(a, g) {
  m <- matrix(data = c(c(trigamma(a), 1/g), c(1/g, a/g^2)), nrow = 2, ncol = 2)
  return(n * m)
}

a_old <- 1.5
g_old <- 130
a_g_old <- matrix(data = c(a_old, g_old), nrow = 2, ncol = 1)

for(i in 1:10) {
  new_a_g <- a_g_old + solve(I(a_old, g_old)) %*% S(a_old, g_old)
  a_old <- new_a_g[1,]
  g_old <- new_a_g[2,]
  a_g_old <- matrix(data = c(a_old, g_old), nrow = 2, ncol = 1)
}

new_a_g