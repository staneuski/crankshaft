% Calculates the moment of inertia of the flywheel
clc;    flywheelDict;

%% Importing data from <name>.ind from Diesel-RK
indname = dir('*.ind'); Px = importdata(indname.name);
Px = circshift(Px.data(:,2), 180) * 1e+05; % Pa

%% Initialising arrays
Pj = zeros(length(Px), 1); Psum = zeros(length(Px), 1);
T = zeros(length(Px), 1); Z = zeros(length(Px), 1); K = zeros(length(Px), 1);
Mav = zeros(length(Px), 1); Mt = zeros(length(Px), 1);

%% Precalculations
R = S*1e-03/2; % radius of the crankshaft, m
omega = pi*n/30; % mean value of angular velocity of the crankshaft, rad/s
S_area = pi*power( D*1e-03, 2 )/4; % piston area, m^2

%% Calculating forces T, Z, K
for alpha = 1:length(Px)
    beta = asind(lambda*sind( alpha ));
    j = R*power(omega, 2)*cosd(alpha + beta)/cosd(beta)...
        + lambda*power(cosd(alpha), 2)/power(cosd(beta), 3);
    
    Pj(alpha) = - Mpd*j; % N/m^2
    Psum(alpha) = Px(alpha) + Pj(alpha); % N/m^2
    
    Z(alpha) = Psum(alpha)*(cosd(alpha + beta) / cosd(beta)); % N/m^2
    T(alpha) = Psum(alpha)*(sind(alpha + beta) / cosd(beta)); % N/m^2
    K(alpha) = Psum(alpha) / cosd(beta); % N/m^2
end

%% Torque moment on the crankshaft
for alpha = 1:length(Px)
    T_crank = 0;
    for i = 1:nCyl;    T_crank = T_crank + T_period(T, alpha + combustionAngle*(i-1)); end
    
    Mt(alpha) = S_area*R*T_crank;
end

%% Mean value of torque moment Mt
for alpha = 1:length(Px);   Mav(alpha) = mean( Mt ); end

A_arr = cumtrapz(degtorad(1:length(Px)), Mt - Mav);
Amax = max(A_arr);  Amin = min(A_arr);  A = Amax - Amin; % overwork of torque moment, J
% Moment of inertia of the flywheel, kg*m^2
J_flywheel = A/( delta*power(omega, 2) ) - nCyl*Jmm;

%% Saving results to .txt file and display it
diary('flywheelResults.txt'); diary on;

disp('Mean value of angular velocity of the crankshaft, rad/s');    disp (omega);
disp('Maximum of work A, J');                                       disp (Amax);
disp('Minimum of work A, J');                                       disp (Amin);
disp('Overwork of torque moment, J');                               disp (A);

disp('/----------------------------- Results -----------------------------/'); disp(' ');
disp('Flywheel moment of inertia, kg*m^2');     disp(J_flywheel);
disp('Ratio of flywheel moment of inertia to motor mass moment of inertia');
disp('J_flywheel/Jmm');                         disp(J_flywheel/Jmm);
disp('/-------------------------------------------------------------------/'); 
disp(' ');  disp(' ');   disp('Contact me to feedback:');
disp('https://github.com/StasF1 or stanislau.stasheuski@gmail.com'); 
disp(' '); disp('© 2018 Stanislau Stasheuski');

disp(' ');  diary off;  %open flywheelResults.txt;

%% Displaying and saving plots to .png files
% Pressures Pj, Px, Psum (MN/m^2)
figure('visible', 'off'); hold on; grid on;
plot(Pj*1e-06, 'r', 'LineWidth', 1.5);
plot(Px*1e-06, 'm', 'LineWidth', 1.5);
plot(Psum*1e-06, 'LineWidth', 1.5);
legend('Pj', 'Px', 'Psum');
xlabel('alpha, deg');  ylabel('MN/m^2');
saveas(gcf,'forcesInCombustor.png');

% Pressures T, Z and K (N/m^2)
figure('visible', 'off'); hold on; grid on;
plot(T*1e-06, 'r', 'LineWidth', 1.5);
plot(Z*1e-06, 'm', 'LineWidth', 1.5);
plot(K*1e-06, 'b', 'LineWidth', 1.5);
legend('T', 'Z', 'K');
xlabel('alpha, deg');  ylabel('MN/m^2');
saveas(gcf,'forcesTZK.png');

% Torque moment & it's mean value
figure('visible', 'on'); hold on;
plot(Mt, 'LineWidth', 1.5); plot(Mav, 'LineWidth', 1.5);
grid on;    xlabel('alpha, deg');    ylabel('M, <M>, 1/min');
saveas(gcf,'torqueMoment.png');

% Work A of torque moment
figure('visible', 'on');
plot(A_arr, 'm', 'LineWidth', 1.5);
grid on;    xlabel('alpha, deg');    ylabel('A, J');
saveas(gcf,'workOfMoment.png');

%% Moving results to the conrodForces.Results folder
mkdir flywheel.Results;
indname = dir('*.ind'); copyfile(indname.name, 'flywheel.Results/');
copyfile flywheelDict.m flywheel.Results/
movefile flywheelResults.txt flywheel.Results/
movefile forcesInCombustor.png flywheel.Results/
movefile forcesTZK.png flywheel.Results/
movefile torqueMoment.png flywheel.Results/
movefile workOfMoment.png flywheel.Results/

%% end
clear;
% clc;


