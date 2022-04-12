import numpy as np
import matplotlib.pyplot as plt
from numpy import log
from scipy.special import polygamma as psi

n = int(1e5)

Xbar = 258.83211
logXbar = 5.27291

def S(a, g):
    return -n * np.array([psi(0, a) + log(g) - logXbar,
                          a/g - Xbar/g**2])

def I(a, g):
    return n * np.array([[psi(1, a), 1/g],
                          [1/g, a / g**2 ]])

def invI(a, g):
    return np.linalg.inv(I(a, g))

# theta_k+1 = theta_k + invI(theta_k) @ S(theta_k)
a_old = 1
g_old = 130

for i in range(10):
    [a_new, g_new] = np.array([a_old, g_old]) + invI(a_old, g_old) @ S(a_old, g_old)
    a_old = a_new
    g_old = g_new
    print(a_new, g_new)
