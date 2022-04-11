N <- seq(1e2, 1e4, by = 1e2) # sample sizes
s <- 4 # parameter options
palpha <- sample(1.1:5, s, replace = TRUE) # alpha samples
pgamma <- sample(0.5:3.5, s, replace = TRUE) # gamma samples
true.alpha <- matrix(palpha, nrow = length(N), ncol = s,
                     byrow = TRUE) # combine all alpha samples
true.gamma <- matrix(pgamma, nrow = length(N), ncol = s,
                     byrow = TRUE) # combine all gamma samples

comp.alpha <- matrix(data = NA, ncol = s, nrow = length(N)) # matrix for storing computed alpha
comp.gamma <- matrix(data = NA, ncol = s, nrow = length(N)) # matrix for storing computed gamma
for(n in N) {
  for(i in 1:s) {
    set.seed(010)
    X <- rgamma(n, scale = pgamma[i], shape = palpha[i]) # generate a gamma sample of size n
    X.bar <- mean(X) # compute the mean of the sample
    X.log <- log(X) # take the log of the sample
    X.log.bar <- mean(X.log) # take the mean of log(sample)
    a <- log(X.bar) - X.log.bar
    phi <- function(z, a) return(digamma(z) - log(z) + a)
    phi.diff <- function(z) return(trigamma(z) - 1/z)
    
    ## Newton-Raphson method for estimation
    iters <- 15
    x.old <- mean(palpha)  # initial value
    vec.alpha <- numeric(length = iters); vec.alpha[1] <- x.old
    for(it in 2:iters) {
      x.new <- x.old - phi(x.old, a) / phi.diff(x.old)
      x.old <- x.new
      vec.alpha[it] <- x.new
    }
    vec.gamma <- X.bar / vec.alpha # vector of estimated gamma
    errors <- (vec.alpha - palpha[i]) ^ 2 + (vec.gamma - pgamma[i]) ^ 2 # computing the error
    comp.alpha[which(N == n), i] <- vec.alpha[length(vec.alpha)]
    comp.gamma[which(N == n), i] <- vec.gamma[length(vec.gamma)]
  }
}
comp.a.MSE <- ((true.alpha - comp.alpha) ^ 2) / N # compute MSE for alpha estimator
comp.g.MSE <- ((true.gamma - comp.gamma) ^ 2) / N # compute MSE for gamma estimator

# Plotting the evolution
par(mfcol = c(2, 2));
for(i in 1:s) {
  plot(comp.a.MSE[, i], type = "l", col = "blue",
       xlab = "Sample size (x1e2)", ylab = "Computed MSE",
       main = paste("(", palpha[i], ", ", pgamma[i], ")"))
  #text(1:s, comp.a.MSE[, i] + 4e-7, comp.a.MSE[, i], cex = 0.5, col = "blue")
  lines(comp.g.MSE[, i], type = "l", col = "red")
  legend("topright", legend = c("MSE of alpha estimator", "MSE of gamma estimator"),
         col = c("blue", "red"), lty = 1, cex = 0.6)
}