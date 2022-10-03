# Required packages
import numpy as np
import matplotlib.pyplot as plt
from scipy.integrate import odeint
from mpl_toolkits.mplot3d import Axes3D

# Define parameters
rho, sigma, beta = 28, 10, 8/3

# Computational function
def f(state, t):
    # Unpack vector
    x, y, z = state 
    # Return derivatives
    return sigma * (y - x), x * (rho - z) - y, x * y - beta * z  

# Initial conditions
state0 = [1, 1, 1]
t = np.arange(0, 40, 0.01)

# Differential Equations Solver
states = odeint(f, state0, t)

# Plot results
fig = plt.figure()
ax = fig.gca(projection="3d")
ax.plot(states[:, 0], states[:, 1], states[:, 2])
plt.draw()
plt.title(r'Lorenz Equations')
plt.xlabel(r'$x$')
plt.ylabel(r'$y$')
ax.set_zlabel(r'$z$')
plt.show()