% Define parameters for mass and eccentricity
e = 0.7; m1 = 1; m2 = 4;

% Establish period 
T = 2*pi./(1-e).^1.5; tspan = linspace(0, T, 1000);
options = odeset('RelTol', 1.e-6);

% Solve differential equation
% First, express 2nd order ODE as 1st order ODE
[t, xyuv] = ode45(@(t, xyuv) two_body(xyuv), tspan, [-1, 0, 0, sqrt(1 + e)], options);
x = xyuv(:, 1); y = xyuv(:, 2);
x1 = m2/(m1 + m2)*x; y1=m2/(m1 + m2)*y;
x2 = -m1/(m1 + m2)*x; y2=-m1/(m1 + m2)*y;

% Graphical representation of two-body problem
% Radius of masses and constant k
k = 0.1;
R1 = k*(m1)^(1/3); R2=k*(m2)^(1/3); 
theta = linspace(0, 2*pi); 
figure; axis equal; hold on; set(gcf, 'color', 'w');
axis off; 
xlim([-2,5]); ylim([-2.5, 2.5]);
body_one = fill(R1*cos(theta) + x1(1), R1*sin(theta) + y1(1), 'b'); 
body_two = fill(R2*cos(theta) + x2(1), R2*sin(theta) + y2(1), 'r'); 
pause(1);

% Iterate over a number of periods
nperiods = 5; 
for j = 1:nperiods
    for i = 1:length(t)
        body_one.XData = R1*cos(theta) + x1(i); body_one.YData = R1*sin(theta) + y1(i); 
        body_two.XData = R2*cos(theta) + x2(i); body_two.YData = R2*sin(theta) + y2(i); 
        drawnow;
    end
end

% Function needed for solving ODE 
function d_xyuv_dt = two_body(xyuv)
x = xyuv(1); y = xyuv(2);  u = xyuv(3);  v = xyuv(4);
r = sqrt(x^2 + y^2);
d_xyuv_dt = [u; v; -x/r^3; -y/r^3];
end
