% Define parameters
sigma = 10; beta = 8/3; rho = 28;

% Set differential equations system
f = @(t,a) [-sigma*a(1) + sigma*a(2); rho*a(1) - a(2) - a(1)*a(3); -beta*a(3) + a(1)*a(2)];

% Runge-Kutta 4th/5th order ODE solver
[t, a] = ode45(f,[0 100],[1 1 1]);     

% Plot results
plot3(a(:, 1),a(:, 2),a(:, 3))
xlabel('$x$','Interpreter','latex','FontSize', 14);
ylabel('$y\;\;$','Interpreter','latex','FontSize', 14);
zlabel('$z\;\;$','Interpreter','latex','FontSize', 14);
title('Lorenz Equations','Interpreter','latex','FontSize', 16)