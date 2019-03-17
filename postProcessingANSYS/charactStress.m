% Imports data from ANSYS by .txt files & calculates characteristics of
% cycle midles of stress (sigma_Xa etc. and tau_XYa etc.) and amplitudes of
% stress (sigma_Xa etc. and tau_XYa etc.)

%% Importing data from .txt files like structures
% Normal stress
Xmax = importdata('inputStressData/Normal_Xmax.txt'); Xmin = importdata('inputStressData/Normal_Xmin.txt');
Ymax = importdata('inputStressData/Normal_Ymax.txt'); Ymin = importdata('inputStressData/Normal_Ymin.txt');
Zmax = importdata('inputStressData/Normal_Zmax.txt'); Zmin = importdata('inputStressData/Normal_Zmin.txt');
% Shear stress
XYmax = importdata('inputStressData/Shear_XYmax.txt'); XYmin = importdata('inputStressData/Shear_XYmin.txt');
YZmax = importdata('inputStressData/Shear_YZmax.txt'); YZmin = importdata('inputStressData/Shear_YZmin.txt');
ZXmax = importdata('inputStressData/Shear_XZmax.txt'); ZXmin = importdata('inputStressData/Shear_XZmin.txt'); 

%% Calculating characteristics of cycle
nodeNumberStartMax = Xmax.data(1,1);	nodeNumberStartMin = Xmin.data(1,1);
% Calculating characteristics of cycle
    
% Calculating amplitude of stress
% For normal stress
X_a = stressCycle(Xmax.data(:, 2), Xmin.data(:, 2), 'a'); % MPa
Y_a = stressCycle(Ymax.data(:, 2), Ymin.data(:, 2), 'a'); % MPa
Z_a = stressCycle(Zmax.data(:, 2), Zmin.data(:, 2), 'a'); % MPa
% For shear stress
XY_a = stressCycle(XYmax.data(:, 2), XYmin.data(:, 2), 'a'); % MPa
YZ_a = stressCycle(YZmax.data(:, 2), YZmin.data(:, 2), 'a'); % MPa
ZX_a = stressCycle(YZmax.data(:, 2), YZmin.data(:, 2), 'a'); % MPa

% Calculating middle of stress
% For normal stress
X_m = stressCycle(Xmax.data(:, 2), Xmin.data(:, 2), 'm'); % MPa
Y_m = stressCycle(Ymax.data(:, 2), Ymin.data(:, 2), 'm'); % MPa
Z_m = stressCycle(Zmax.data(:, 2), Zmin.data(:, 2), 'm'); % MPa
% For shear stress
XY_m = stressCycle(XYmax.data(:, 2), XYmin.data(:, 2), 'm'); % MPa
YZ_m = stressCycle(YZmax.data(:, 2), YZmin.data(:, 2), 'm'); % MPa
ZX_m = stressCycle(YZmax.data(:, 2), YZmin.data(:, 2), 'm'); % MPa





