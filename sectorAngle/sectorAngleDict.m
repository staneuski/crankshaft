% Dates of the engine

% Engine data
D = 8.2; % centimetres 
S = 9.3; % centimetres 

% Crankshaft data
ro = 7860; % kg/m^3, density
Mcsh = 3.285; % kg, crankshaft mass
y_cntr = 15.984; % millimetres, length to the center mass point
b = 19.09; % millimetres, thickness of the web
m_pd = 200; % kg/m^2
n = 2; % number of conrods on the one crankpin

% Sector data
R_1 = 71.7/2; % millimetres
R_2 = 87; % millimetres

% Geometry limits
% At least the one MUST be greater than sector dimensions!
R_2_lim = 90.5; % millimetres, limit of radius of sector angle
b_lim = 25; % millimetres, limit of web thickness

% Path to save the results (to save to the current folder set 0)
pathToSave = 0; % 'HDD/yourPath'