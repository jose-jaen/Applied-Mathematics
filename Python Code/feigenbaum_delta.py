# Required package
import numpy as np

# Define parameters

# Newton's Method and estimation iterations
n_newton, n_estimates = 10, 11

# Periods with x_0 = 1/2 and delta vectors
m = np.zeros(shape=(12, 1))
delta = np.zeros(shape=(11, 1))
# Initialize arrays
m[0], m[1], delta[0] = 2, 1 + np.sqrt(5), 5

# Loop over desired number of estimates
for n in range(2, n_estimates + 1):
    # Set the period and initial mu values
    period = 2 ** n
    mu = m[n - 1] + (m[n - 1] - m[n - 2]) / delta[n - 2]

    # Compute Newton's Method
    for i in range(n_newton):
        x = 1 / 2
        y = 0

        # Loop over each period
        for j in range(period):
            y = x * (1 - x) + mu * y * (1 - 2 * x)
            x = mu * x * (1 - x)

        # Update mu value
        Delta = (x - 1 / 2) / y
        mu = mu - Delta

    # Collect m and delta values
    m[n] = mu
    delta[n - 1] = np.format_float_positional(
        (m[n - 1] - m[n - 2]) / (m[n] - m[n - 1]), precision=32)

# Output estimates for Feigenbaum Delta
for i, j in enumerate(delta):
    print(i, np.format_float_positional(m[i], precision=32),
          np.format_float_positional(j, precision=32))