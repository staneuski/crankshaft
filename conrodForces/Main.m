% Calculates extremums of acting forces (K) to the conrods and angles
% beetween them and the crankshaft ( 180deg - (alpha + beta) )

%% Loading data of engine from dictionary 
conrodForcesDict;

%% Importing data from <name>.ind from Diesel-RK
indname = dir('*.ind'); Px = importdata(indname.name);
Px = circshift(Px.data(:,2), 180) * 1e+05; % Pa

%% Initialising arrays
Pj = zeros(length(Px), 1); Psum = zeros(length(Px), 1);
T = zeros(length(Px), 1); Z = zeros(length(Px), 1); K = zeros(length(Px), 1);

%% Calculating force K (and other) 
% Precalculations
R = S*0.001/2; % metres, radius of the crankshaft
omega = pi*n/30; % rad/s, mean value of angular velocity of the crankshaft

% Calculating forces
for alpha = 1:length(Px)
    beta = asind(lambda*sind( alpha ));
    j = R*power(omega, 2)*cosd(alpha + beta)/cosd(beta)...
        + lambda*power(cosd(alpha), 2)/power(cosd(beta), 3);
    
    Pj(alpha) = - Mpd*j; % MN/m^2
    Psum(alpha) = Px(alpha) + Pj(alpha); % MN/m^2
    
    Z(alpha) = Psum(alpha)*(cosd(alpha + beta) / cosd(beta)); % MN/m^2
    T(alpha) = Psum(alpha)*(sind(alpha + beta) / cosd(beta)); % MN/m^2
    K(alpha) = Psum(alpha) / cosd(beta); % MN/m^2
end

[Z_max, alpha_max] = max(Z);
[Z_min, alpha_min] = min(Z);

%% Searching extremums of force K and their extemum angles, and creating matrixes of them
% Searching extremums of K and where they are
[K_max, alpha_max] = max(K); [K_min, alpha_min] = min(K);

% Creating matrix with extremums of force K (converting to N) for
% two sections of engine (right & left)
pistonArea = pi*power(D*0.001, 2)/4; % m^2, piston area
Forces_matrix = pistonArea * [K_max, K( forcePeriod(alpha_max + combustionAngle, length(Px)) );...
                              K_min, K( forcePeriod(alpha_min + combustionAngle, length(Px)) )].';
                          
% Calculating angles beetween the conrods and the crankshaft, and creating matrix of them 
Angles_matrix = [round( anglesForce(alpha_max) ),...
                 round( anglesForce(alpha_min) )];
             
% Deleting repeating row in matrixes if it is the in-line engine
if crankshaftAngle == 0 && combustionAngle == 0
    Forces_matrix(2, :) = [];
    Angles_matrix(2, :) = [];
end

%% Displaying the results
% Saving to .txt file
delete conrodForcesResults.txt; diary('conrodForcesResults.txt'); diary on;

disp('Crank angle (alpha) when force K is maximum, deg');           disp(alpha_max - 1);
disp('Crank angle (alpha) when force K is minimum, deg');           disp(alpha_min - 1);
disp('Crank angle is zero (alpha = 0) at TDC');                     disp(' ');

disp('/--------------------- Results ----------------------/');     disp(' ');
disp('Matrix of pushing conrod forces, N / 1e+05');
disp('    Maximum   Minimum'); disp(Forces_matrix / 1e+05);
disp('Matrix of angles beetween conrods & crankshaft, deg');
disp('   Max   Min'); disp(Angles_matrix);
disp('"-" is anticlockwise direction,'); disp('"+" is clockwise direction'); disp(' ');
disp('/----------------------------------------------------/'); disp(' '); disp(' ');
disp('Contact me to feedback:'); disp('https://github.com/StasF1 or stanislau.stasheuski@gmail.com');
disp(' '); disp('© 2018 Stanislau Stasheuski');

diary off; open conrodForcesResults.txt;

% Displaying and saving plots to .png files

% Pressures Pj, Px, Psum (MN/m^2)
figure; hold on; grid on;
plot(Pj*1e-06, 'r', 'LineWidth', 1.5);
plot(Px*1e-06, 'm', 'LineWidth', 1.5);
plot(Psum*1e-06, 'LineWidth', 1.5);
legend('Pj', 'Px', 'Psum');
xlabel('alpha, grad');  ylabel('MN/m^2');   set(gca,'fontsize', 20);
% title('Pj, Px and Psum forces');
saveas(gcf,'forcesInCombustor.png');

% Pressures Z and K (N/m^2)
figure; hold on; grid on;
plot(T*1e-06, 'r', 'LineWidth', 1.5);
plot(Z*1e-06, 'm', 'LineWidth', 1.5);
plot(K*1e-06, 'b', 'LineWidth', 1.8);
plot(alpha_max, K_max*1e-06, '.', 'MarkerEdgeColor', 'c', 'MarkerSize', 30)
plot(alpha_min, K_min*1e-06, '.', 'MarkerEdgeColor', 'c', 'MarkerSize', 30)

legend('T', 'Z', 'K');
xlabel('alpha, grad');  ylabel('MN/m^2');   set(gca,'fontsize', 20);
% title('Z, T and K forces');
saveas(gcf,'forcesTZK.png');

%% Moving results to the conrodForces.Results folder
mkdir conrodForces.Results;
indname = dir('*.ind'); copyfile(indname.name, 'conrodForces.Results/');
copyfile conrodForcesDict.m conrodForces.Results/
movefile conrodForcesResults.txt conrodForces.Results/
movefile forcesInCombustor.png conrodForces.Results/
movefile forcesTZK.png conrodForces.Results/

%%
clear; clc
