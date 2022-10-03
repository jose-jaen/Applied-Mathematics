% Define data grid
z = 0:0.1:20;

% Compute first five Bessel functions of the first kind
J = zeros(5,201);
for i = 0:4
    J(i+1, :) = besselj(i, z);
end

% Plot results
plot(z, J)
grid on
legend('J_0','J_1','J_2','J_3','J_4','Location','Best')
title('Bessel Functions of the First Kind for $\nu \in [0, 4]$','interpreter','latex')
xlabel('z','interpreter','latex')
ylabel('$J_\nu(z)$','interpreter','latex')

% Define number of roots and functions to compute
n_roots=5; n_functions=6;

% Initial guess matrix
roots_guess = [2.4, 3.8, 5.1, 6, 7.5, 8.7;
   5.5, 7, 8.4, 9.7, 11, 12;
   8.6, 10, 11.6, 13, 14, 16;
   11.8, 13, 15, 16, 18, 19;
   15, 16.4, 18, 19.4, 21, 22]; 

% First five roots of six Bessel functions
% Iterate over number of solutions and functions
for i = 1:n_roots
  for j = 0:n_functions-1

    % Define j-th function and integrate it
    funcion = @(x, theta) cos(x.*sin(theta) - j.*theta); 
    vzeros(i, j+1) = fzero(@(x) integral(@(theta) funcion(x, theta), 0, pi), [roots_guess(i, j+1)]);
  end
end

% Print table
fprintf('k     J0(x)     J1(x)     J2(x)     J3(x)     J4(x)     J5(x)\n')
for k = 1:n_roots
    fprintf('%i', k)
    for n = 0:n_functions-1
        fprintf('%10.4f', vzeros(k,n+1));
    end
    fprintf('\n');
end