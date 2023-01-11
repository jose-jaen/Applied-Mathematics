# Required packages
import numpy as np
from math import pi
from scipy.integrate import odeint

# Define parameters for mass and eccentricity
e, m1, m2 = 0.7, 1, 4

# Establish period
T = 2*pi/(1 - e)**1.5
tspan = np.linspace(0, T, 1000)
initial = [-1, 0, 0, np.sqrt(1 + e)]

# Function to solve ODE
def two_body_eq(xyuv, t):
    x, y = xyuv[0], xyuv[1]
    u, v = xyuv[2], xyuv[3]
    r = np.sqrt(x**2 + y**2)
    d_xyuv_dt = np.array([
        u, v,
        -x/r** 3,
        -y/r** 3
    ])
    return d_xyuv_dt

# Solution to ODE
y = odeint(two_body_eq, initial, tspan)
