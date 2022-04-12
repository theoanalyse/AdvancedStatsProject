import numpy as np
from scipy.special import digamma
import matplotlib.pyplot as plt

## Setup Newton-Raphson Parameters
n = 10000 # sample size

alpha = 1.915
gamma = 135.158

X = np.random.gamma(alpha, gamma, n) # generate a gamma sample of size n
Xbar = np.mean(X) # compute the mean of the sample

logX = np.log(X) # take the log of the sample
logXbar = np.mean(logX) # take the mean of log(sample)

a = np.log(Xbar) - logXbar # constant in function phi

# phi itself
def phi(z):
    return digamma(z) - np.log(z) + a

def Ddigamma(z):
    sum = 0
    for i in range(int(1e5)):
        sum += 1 / (i + z)**2
    return sum

def Dphi(z):
    return Ddigamma(z) - 1/z

## Start N-R method
x_old = 1 # initial value

for i in range(20):
    x_new = x_old - phi(x_old) / Dphi(x_old)
    x_old = x_new

print(x_new, Xbar / x_new)
