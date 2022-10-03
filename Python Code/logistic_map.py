# Required packages
import numpy as np
import matplotlib.pyplot as plt

# Initialize data containers for plotting
X, Y = [], []

# Set transient and data iterations
n_trans, n_data = 20000, 10000

# Define grid for the reproduction rate
mu_values = np.linspace(2.4, 4, 10000)

# Collect data for each value of mu
for mu in mu_values:
    # Add each mu value to X-axis
    X.append(mu)
    # Randomly initialize our data around 0.5
    x = 0.5 + 0.1 * np.random.randn()
    x = round(x, 3)

    # Loop over transient
    for n in range(n_trans):
        x = (mu * x) * (1 - x)

    # Update final values for population ratio
    for m in range(n_data):
        x = (mu * x) * (1 - x)

    # Collect final data
    Y.append(x)

# Plot results
plt.plot(X, Y, ls='', marker=',')
plt.title(r'Logistic Map Bifurcation Diagram')
plt.xlabel(r'$\mu$')
plt.ylabel(r'$x$')
plt.show()