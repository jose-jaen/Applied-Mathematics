% Range of values and pixels
mu_min = 2.4; mu_max = 4; 
n_mu = 500; n_x = 400;

% Edges for pixels
x_edges = linspace(0, 1, n_x+1); 
mu_edges = linspace(mu_min, mu_max, n_mu+1); 
mu = (mu_edges(1:n_mu) + mu_edges(2:n_mu+1))/2; 


% Transient and final data iterations
n_trans = 2000; n_data = 1000;
 
% Data to plot results
x_data = zeros(n_data, n_mu); 

% Initial condition
x_0 = 0.5; 

% For each value of mu we collect population data
for i = 1:length(mu)
    
    % Loop over transient
    for j = 1:n_trans   
        x_trans = mu(i)*x_0*(1-x_0);
    end

    % Collect final data
    x = x_trans;
    for n = 1:n_data    
        x = mu(i)*x*(1-x);   
        x_data(n,i) = x + x_data(n,i);
    end
    
end

% Plotting the Bifucartion Diagram

% Binned values for x
x_histogram = zeros(n_x, n_mu);
for i = 1:n_mu
    x_histogram(:,i) = histcounts(x_data(:, i), x_edges);
    x_histogram(:,i) = 255*x_histogram(:, i)/max(x_histogram(:, i));
end

% Adjust color scale to avoid overlapping results
colormap(flipud(bone(256))); brighten(-0.8); cmap = colormap;
im = image([mu_edges(1) mu_edges(end)], [x_edges(1) x_edges(end)], x_histogram);
set(gca,'YDir','normal');

% Add labels
xlabel('$\mu$','Interpreter','latex','FontSize', 14);
ylabel('$x\;\;$','Interpreter','latex','FontSize', 14);
title('Logistic Map Bifurcation Diagram','Interpreter','latex','FontSize', 16)