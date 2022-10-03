# Required packages
import numpy as np
import scipy.special as sc
import matplotlib.pyplot as plt

# Define data grid
x = np.linspace(0, 20, 100)

# First five Bessel functions of the first kind
for n in range(5):
    y = sc.jn(n, x)
    # Plot results
    plt.plot(x, y, label = r'$J_ %s (x)$'%n)

# Include labels
plt.axhline(0, color = 'green', label = '_nolegen_')
plt.grid()
plt.legend()
plt.xlabel(r'$x$')
plt.ylabel(r'$J_m (x)$')
plt.title(r'Bessel functions $J_n(x)$')
plt.show()

# Find roots
x = np.zeros(shape=(5, 6))
for n in range(6):
    x[:, n] = sc.jn_zeros(n, 5)
print(x)