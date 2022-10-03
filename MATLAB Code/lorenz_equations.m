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

% Deriving fractals

% Define Lorenz Equations parameters
r=28; sigma=10; beta=8/3; 

% Set up fixed points
x1=0; x2=sqrt(beta*(r-1)); x3=-sqrt(beta*(r-1));
y1=0; y2=sqrt(beta*(r-1)); y3=-sqrt(beta*(r-1));
z1=0; z2=r-1; z3=r-1;

% Iteration values and grid points
nx=500; nz=500;
xmin=-40; xmax=40; zmin=-40; zmax=40;
x_grid=linspace(xmin,xmax,nx); z_grid=linspace(zmin,zmax,nz);
[X,Z]=meshgrid(x_grid,z_grid);

% Tolerance parameters
RelTol = 1.e-06; AbsTol = 1.e-09;

% Iterate over X, Z values
for i = 1:nx
    for j = 1:nz

	% Initialize y
	y = 3*sqrt(2);

	% Define convergence criteria
        error = Inf; 
        while error > max(RelTol*max(abs([X(i,j), y, Z(i, j)])), AbsTol)

	    % Construct jacobian matrix
            jacobian = [-sigma, sigma, 0; r-Z(i, j), -1, -X(i, j); y, X(i, j), -beta];
	    
            % Righ-hand-side matrix of the equation
            rhs = [-sigma*(y - X(i, j));-X(i, j)*(r-Z(i, j))+y;-X(i,j)*y + beta*Z(i, j)];

            % Solve the equation
            delta = jacobian\rhs;

	    % Update values
            X(i,j) = X(i,j) + delta(1); y = y+delta(2); Z(i,j) = Z(i,j) + delta(3);
            
            % Update convergence criterion 
            error = max(abs(delta));

        end
    end
end

% Check closer values to fixed points
eps=1.e-03;
X1 = abs(X - x1) < eps; X2 = abs(X - x2) < eps; X3 = abs(X - x3) < eps;
X4 = ~(X1 + X2 + X3);

% Create figure for graphical representation
figure; 
map = [1 0 0; 0 1 0; 0 0 1; 0 0 0]; colormap(map); %[red; green; blue; black]
X=(X1 + 2*X2 + 3*X3 + 4*X4); 
image([xmin xmax], [zmin zmax], X); set(gca,'YDir','normal');
xlabel('$x$', 'Interpreter', 'latex', 'FontSize',14);
ylabel('$z$', 'Interpreter', 'latex', 'FontSize',14);
title('Fractal from the Lorenz Equations', 'Interpreter', 'latex','FontSize', 16)  
