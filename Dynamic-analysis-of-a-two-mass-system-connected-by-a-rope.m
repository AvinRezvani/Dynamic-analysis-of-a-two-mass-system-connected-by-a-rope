clearvars; close all; clc;

%% ======================== SETUP ========================

g = 9.81;               
r_hole = 0.05;          
R_table = 1.3;          

beta = 2;              
n = 2;                 


tmax = 20;              
opts = odeset('RelTol', 1e-8, 'AbsTol', 1e-9, 'Events', @eventsFcn);

%% ======================= PART (a) =======================
disp('Running Part (a): Frictionless cases with varying mB');


mA = 2;                 
mu_k = 0;               
r0 = 0.75;              
v0 = 5;                 
theta0 = 0;           
y0 = 0;                
L = r0 + beta*y0;      


mB_list = [6, 15, 50];  


figure('Name', 'Part (a) Results', 'NumberTitle', 'off', 'Position', [100 100 1200 800]);

for i = 1:length(mB_list)
    mB = mB_list(i);
    
    
    z0 = [r0; 0; theta0; v0/r0];  
    
    
    [t, z] = ode45(@(t, z) dynamics(t, z, [mA, mB, mu_k, beta, n, g]), [0 tmax], z0, opts);
    
    
    r = z(:, 1); 
    rdot = z(:, 2); 
    theta = z(:, 3); 
    omega = z(:, 4);
    
    
    speedA = sqrt(rdot.^2 + (r.*omega).^2);
    yB = (L - r)/beta;
    
    
    ddotr = (n*mA*r.*omega.^2 - mB*g)./(n*mA + mB/beta);
    T = mA*(r.*omega.^2 - ddotr);
    
    
    animateMotion(t, r, theta, [mA, mB, mu_k], sprintf('Part (a): mB = %d kg', mB));
    
    
    subplot(3, 3, i);
    plot(t, speedA, 'b-', 'LineWidth', 1.5);
    title(sprintf('Speed (mB = %d kg)', mB)); 
    xlabel('Time (s)'); 
    ylabel('Speed (m/s)'); 
    grid on;
    
    subplot(3, 3, i+3);
    plot(t, yB, 'r-', 'LineWidth', 1.5);
    title(sprintf('Block B Position (mB = %d kg)', mB)); 
    xlabel('Time (s)'); 
    ylabel('y_B (m)'); 
    grid on;
    
    subplot(3, 3, i+6);
    plot(t, T, 'g-', 'LineWidth', 1.5);
    title(sprintf('Tension (mB = %d kg)', mB)); 
    xlabel('Time (s)'); 
    ylabel('Tension (N)'); 
    grid on;
end

%% ======================= PART (b) =======================
disp('Running Part (b): Friction cases with mB = 6 kg');


mA = 2;                 
mB = 6;                 
r0 = 0.75;              
v0 = 5;                 
theta0 = 0;             
y0 = 0;                
L = r0 + beta*y0;       


mu_list = [0.03, 0.15, 0.9];  


figure('Name', 'Part (b) Results', 'NumberTitle', 'off', 'Position', [100 100 1200 800]);

for i = 1:length(mu_list)
    mu_k = mu_list(i);
    
    
    z0 = [r0; 0; theta0; v0/r0];  
    
    
    [t, z] = ode45(@(t, z) dynamics(t, z, [mA, mB, mu_k, beta, n, g]), [0 tmax], z0, opts);
    
    
    r = z(:, 1); 
    rdot = z(:, 2); 
    theta = z(:, 3); 
    omega = z(:, 4);
    
    
    speedA = sqrt(rdot.^2 + (r.*omega).^2);
    yB = (L - r)/beta;
    
    
    ddotr = (n*mA*r.*omega.^2 - mB*g)./(n*mA + mB/beta);
    T = mA*(r.*omega.^2 - ddotr);
    
    
    animateMotion(t, r, theta, [mA, mB, mu_k], sprintf('Part (b): μ_k = %.2f', mu_k));
    
    
    subplot(3, 3, i);
    plot(t, speedA, 'b-', 'LineWidth', 1.5);
    title(sprintf('Speed (μ_k = %.2f)', mu_k)); 
    xlabel('Time (s)'); 
    ylabel('Speed (m/s)'); 
    grid on;
    
    subplot(3, 3, i+3);
    plot(t, yB, 'r-', 'LineWidth', 1.5);
    title(sprintf('Block B Position (μ_k = %.2f)', mu_k)); 
    xlabel('Time (s)'); 
    ylabel('y_B (m)'); 
    grid on;
    
    subplot(3, 3, i+6);
    plot(t, T, 'g-', 'LineWidth', 1.5);
    title(sprintf('Tension (μ_k = %.2f)', mu_k)); 
    xlabel('Time (s)'); 
    ylabel('Tension (N)'); 
    grid on;
end

%% ======================= PART (c) =======================
disp('Running Part (c): Specific case with friction');


mA = 5;                 
mB = 4;                 
mu_k = 0.7;             
r0 = 0.75;              
v0 = 3;                 
theta0 = 0;            
y0 = 0;                
L = r0 + beta*y0;       


z0 = [r0; 0; theta0; v0/r0];  


[t, z, te, ze, ie] = ode45(@(t, z) dynamics(t, z, [mA, mB, mu_k, beta, n, g]), [0 tmax], z0, opts);


r = z(:, 1); 
rdot = z(:, 2); 
theta = z(:, 3); 
omega = z(:, 4);


final_r = r(end);
final_theta = theta(end);
final_yB = (L - final_r)/beta;


final_omega = omega(end);
final_rdot = rdot(end);
ddotr_final = (n*mA*final_r*final_omega^2 - mB*g)/(n*mA + mB/beta);
final_T = mA*(final_r*final_omega^2 - ddotr_final);


fprintf('\n=== Part (c) Results ===\n');
fprintf('Final position of block A: r = %.4f m, θ = %.2f rad\n', final_r, final_theta);
fprintf('Final position of block B: y = %.4f m (%.2f cm below initial)\n', final_yB, abs(final_yB-y0)*100);
fprintf('Final tension in cord: T = %.4f N\n\n', final_T);


if ~isempty(ie)
    if ie(end) == 1
        fprintf('Simulation stopped: Block A reached the central hole.\n');
    elseif ie(end) == 2
        fprintf('Simulation stopped: Block A reached the table edge.\n');
    end
else
    fprintf('Simulation stopped at maximum time (20 seconds).\n');
end


animateMotion(t, r, theta, [mA, mB, mu_k], 'Part (c): Final Configuration');


figure('Name', 'Part (c) Results', 'NumberTitle', 'off', 'Position', [100 100 1000 800]);

subplot(3, 1, 1);
plot(t, sqrt(rdot.^2 + (r.*omega).^2), 'b-', 'LineWidth', 1.5);
title('Speed of Block A'); 
xlabel('Time (s)'); 
ylabel('Speed (m/s)'); 
grid on;

subplot(3, 1, 2);
plot(t, (L - r)/beta, 'r-', 'LineWidth', 1.5);
title('Vertical Position of Block B'); 
xlabel('Time (s)'); 
ylabel('y_B (m)'); 
grid on;

subplot(3, 1, 3);
plot(t, mA*(r.*omega.^2 - (n*mA*r.*omega.^2 - mB*g)./(n*mA + mB/beta)), 'g-', 'LineWidth', 1.5);
title('Tension in Cord'); 
xlabel('Time (s)'); 
ylabel('Tension (N)'); 
grid on;

%% ==================== HELPER FUNCTIONS ====================


function dz = dynamics(~, z, params)
    
    mA = params(1); 
    mB = params(2); 
    mu_k = params(3);
    beta = params(4); 
    n = params(5); 
    g = params(6);
    
    
    r = z(1); 
    rdot = z(2); 
    omega = z(4);
    
    
    if r <= 1e-6
        r = 1e-6;
        if abs(rdot) < 1e-3
            rdot = 0;
        end
    end
    
   
    den = n*mA + mB/beta;
    ddotr = (n*mA*r*omega^2 - mB*g)/den;
    
    
    if mu_k > 0
        
        if abs(omega) < 0.01
            friction_term = mu_k*g*omega/0.01;
        else
            friction_term = mu_k*g*sign(omega);
        end
        domega = -2*rdot*omega/r - friction_term/r;
    else
        domega = -2*rdot*omega/r;
    end
    
   
    dz = [rdot; ddotr; omega; domega];
end


function [value, isterminal, direction] = eventsFcn(~, z, ~)
    r = z(1);
   
    value = [r - 0.05; 1.3 - r];  
    isterminal = [1; 1];           
    direction = [-1; -1];         
end


function animateMotion(t, r, theta, params, figTitle)
    mA = params(1); 
    mB = params(2); 
    mu_k = params(3);
    
    
    xA = r.*cos(theta);
    yA = r.*sin(theta);
    
    
    fig = figure('Name', figTitle, 'NumberTitle', 'off', 'Position', [200 200 600 600]);
    ax = axes(fig);
    hold(ax, 'on'); 
    axis(ax, 'equal');
    
    
    th = linspace(0, 2*pi, 100);
    plot(ax, 1.3*cos(th), 1.3*sin(th), 'k-', 'LineWidth', 2);
    plot(ax, 0.05*cos(th), 0.05*sin(th), 'k-', 'LineWidth', 1.5);
    fill(ax, 1.3*cos(th), 1.3*sin(th), [0.9 0.9 0.9]); 
    fill(ax, 0.05*cos(th), 0.05*sin(th), 'k'); 
    
    
    path = plot(ax, xA, yA, 'Color', [0.8 0.8 0.8]);
    dot = plot(ax, xA(1), yA(1), 'ro', 'MarkerSize', 10, 'MarkerFaceColor', 'r');
    line = plot(ax, [0 xA(1)], [0 yA(1)], 'r-', 'LineWidth', 1.5);
    
    
    xlim(ax, [-1.4 1.4]); 
    ylim(ax, [-1.4 1.4]);
    xlabel(ax, 'x (m)'); 
    ylabel(ax, 'y (m)');
    title(ax, figTitle);
    
    
    info_str = sprintf('mA = %d kg\nmB = %d kg\nμ_k = %.2f', mA, mB, mu_k);
    annotation('textbox', [0.7 0.7 0.2 0.15], 'String', info_str, ...
              'FitBoxToText', 'on', 'BackgroundColor', 'w');
    
   
    nframes = min(150, length(t));
    idx = round(linspace(1, length(t), nframes));
    speed = max(0.01, min(0.05, t(end)/nframes));
    
    
    for k = 1:nframes
        i = idx(k);
        set(dot, 'XData', xA(i), 'YData', yA(i));
        set(line, 'XData', [0 xA(i)], 'YData', [0 yA(i)]);
        drawnow;
        pause(speed);
    end
    
    
end