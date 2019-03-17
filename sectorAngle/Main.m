% Calculates the sector angle of the crankshaft's back balance 
projectFolder = pwd;	sectorAngleDict;

%% Converting data to metres from sectorAngleDict.m
D = D*1e-02;                    S = S*1e-02;
y_cntr = y_cntr*1e-03;          b = b*1e-03;
R_1 = R_1*1e-03;                R_2 = R_2*1e-03;
R_2_lim = R_2_lim*1e-03;        b_lim = b_lim*1e-03;

%% Precalculations
A = pi*power(D, 2)/4; % m^2, piston area
R = S/2; % m, radius of the cranksahft
m_k = Mcsh*y_cntr/(R*A); % kg/m^2, crankshaft mass
m_vr = m_k + n*2/3*m_pd; % kg/m^2

% Calculating the sector angle argument
arg = 3*m_vr*R*A / (4*ro*b*(power(R_2, 3) - power(R_1, 3)));

%% Increasing sizes of the sector if needed
delete sectorAngleResults.txt; diary('sectorAngleResults.txt');

if arg > 1 % Argument of arcsin > 1
    disp('Warning!');
    disp('Sector angle is complex when programm using input data.');
    disp('Radius of sector angle (R_2) & thickness of the web (b) was increased.');
    disp(' ');
    % Warn = imread('Warning.jpg'); image(Warn); % Opening the image
end

while arg > 1 && R_2 < R_2_lim % Increasing radius of sector angle (until R_2 < R_2_lim)
    R_2 = R_2 + 1e-06;
    arg = 3*m_vr*R*A / (4*ro*b*(power(R_2, 3) - power(R_1, 3)));
end

while arg > 1  && b < b_lim % Increasing thickness of the web (if R_2 reached R_2_lim)
    b = b + 1e-06;
    arg = 3*m_vr*R*A / (4*ro*b*(power(R_2, 3) - power(R_1, 3)));
end

%% Calculating sector angle 
alpha = 2*asind( arg );

%% Displaying the results
disp('Piston area, scuare metres'); disp(A);

if round( R_2*1e+04 ) ~= round( R_2_lim*1e+04 )
    disp('Radius of sector angle, millimetres'); disp( R_2*1e+03 );
else
    disp('Radius of sector angle (reached the limit), millimetres');
    disp( R_2*1e+03 );
end

if (round( R_2*1e+06 ) == round( R_2_lim*1e+06 ))...
        && (round( b*1e+06 ) == round( b_lim*1e+06 ))
    
    disp('Thickness of the web (reached the limit), millimetres');
    disp( b*1e+03 );
    disp('/----------- Result -----------/'); disp(' ');
    disp('Error! All limits reached their edges. Crankshaft do not balanced.');
    disp('Try to increase size limits.'); disp(' ');
    
else
    disp('Thickness of the web, millimetres'); disp( b*1e+03 );
    disp('/----------- Result -----------/');
    disp(' '); disp('Crankshaft sector angle, ged'); disp(alpha);
end

disp('/------------------------------/');
disp(' '); disp('Contact me to feedback:'); disp('stanislau.stasheuski@gmail.com');
disp(' '); disp('© 2018 Stanislau Stasheuski');
diary off; open sectorAngleResults.txt;

%% Moving results to the results folder
if isa(pathToSave, 'double') == 1  % Saving the results to the folder in current directory
    mkdir sectorAngle.Results;
    copyfile('sectorAngleDict.m', 'sectorAngle.Results/');
    movefile('sectorAngleResults.txt', 'sectorAngle.Results/');
	
else % Saving the results to the folder in setted directory	
    copyfile('sectorAngleDict.m', pathToSave);
    movefile('sectorAngleResults.txt', pathToSave);
    cd(pathToSave);
    mkdir sectorAngle.Results;
    movefile('sectorAngleDict.m', 'sectorAngle.Results/');
    movefile('sectorAngleResults.txt', 'sectorAngle.Results/');
	
end
cd(projectFolder);

%% Clearing memory

clear; clc;
