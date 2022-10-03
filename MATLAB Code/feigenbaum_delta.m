% Define parameters

% Number of estimation and Newton's Method iterations
n_newton=10; n_estimates = 11; 

% Set up m and delta vectors with initial values
n=0; m(1+n)=2;         
n=1; m(1+n)=1+sqrt(5); 
delta=zeros(1,11); delta(1)=5;

% Loop over the rest of estimates
for n=2:n_estimates
    period = 2^n;
    % Initial guess
    mu = m(n) + (m(n) - m(n-1))/delta(n-1);

    % Newtons' Method iteration
    for i=1:n_newton %Newton's iteration
        x=1/2; y=0;
        
        % Period iteration
        for j=1:period
            y=x*(1-x) + mu*y*(1-2*x);
            x=mu*x*(1-x);
        end

        % Update mu values
        Delta = (x-1/2)/y; %Newton's method
        mu = mu - Delta; 
    end
    
    % Collect final values
    m(1+n) = mu;
    delta(n) = vpa((m(n) - m(n-1))/(m(n+1) - m(n)));
end

% Results
fprintf('n        delta(n)\n');
for n = 1:n_estimates
    fprintf('%2g %18.15f\n', n, delta(n));
end