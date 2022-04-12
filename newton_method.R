n <- 1e6

alpha <- 2
beta <- 5

X <- rgamma(n, scale = beta, shape = alpha) # generate a gamma sample of size n
X.bar <- mean(X) # compute the mean of the sample
X.log <- log(X) # take the log of the sample
X.log.bar <- mean(X.log) # take the mean of log(sample)

a <- log(X.bar) - X.log.bar # constant in function phi

# phi itself
phi <- function(z, a) return(digamma(z) - log(z) + a)

phi.diff <- function(z) return(trigamma(z) - 1/z)

## Start N-R method
iter <- 15
x.old <- 1  # initial value
comp.alpha <- numeric(length = iter); comp.alpha[1] <- x.old # vector of estimated alpha

## Newton-Raphson method

for(i in 2:iter) {
  x.new <- x.old - phi(x.old, a) / phi.diff(x.old)
  x.old <- x.new
  comp.alpha[i] <- x.new
}

comp.beta <- X.bar / comp.alpha # vector of estimated gamma
error <- (comp.alpha - alpha) ^ 2 + (comp.beta - beta) ^ 2 # computing the error

comp.alpha[iter]
comp.beta[iter]
error[iter]
min(error)
