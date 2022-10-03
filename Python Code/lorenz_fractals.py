# Required packages
import math
import numpy as np

# Define parameters

# Lorenz System Parameters
r, sigma, beta = 28, 10, 8/3

# Data grid for representation
nx, nz = [500, 500]
x_grid = np.linspace(-40, 40, nx)
z_grid = np.linspace(-40, 40, nz)
X, Z = np.meshgrid(x_grid, z_grid)

# Tolerance Parameters
RelTol, AbsTol = 1.e-6, 1.e-9

# Iterate over rows of X, Z
for i in range(nx):
    # Iterate over columns of X, Z
    for j in range(nz):

        # Initialize y
        y = 3 * np.sqrt(2)

        # Define convergence criteria
        error = math.inf
        while error > max(RelTol * max([abs(X[i, j]), abs(y), abs(Z[i, j])]), AbsTol):
            # Construct jacobian matrix
            jacobian = np.array([[-sigma, sigma, 0],
                                 [r - Z[i, j], -1, -X[i, j]],
                                 [y, X[i, j], -beta]], dtype=float)

            # Right-hand-side matrix of the equation
            rhs = np.array([[-sigma * (y - X[i, j])],
                            [-X[i, j] * (r - Z[i, j]) + y],
                            [-X[i, j] * y + beta * Z[i, j]]], dtype=float)

            # Solve the matrix equation
            delta = np.linalg.solve(jacobian, rhs)

            # Update values
            X[i, j] += delta[0][0]
            y += delta[1][0]
            Z[i, j] += delta[2][0]

            # Update convergence criterion
            error = max(abs(delta))[0]