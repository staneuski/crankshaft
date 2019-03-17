% Calculates safety factors for crankshaft and displays the minimum of them
postProcDict; % loading input data
charactStress; %importing data from txt files & calculating characteristics of cycles

%% Arrays initialisation
X = zeros(length(X_a), 1);   Y = zeros(length(X_a), 1);   Z = zeros(length(X_a), 1);
XY = zeros(length(X_a), 1);  YZ = zeros(length(X_a), 1);  ZX = zeros(length(X_a), 1);
sigma_equiv = zeros(length(X_a), 1);
n = zeros(length(X_a), 1);

%% Precalculactions

% Эквивалентный диаметр расчётного сечения
if d_refSection == 0 && F ~= 0
    d_eq = sqrt( 4*F/pi ); % mm
else
    clear F; d_eq = d_refSection;
end

% Константа материала, характеризующая его чувствительность к напряжениям
% и масштабному фактору
nu_sigma = 0.211 - 1.443e-04 * sigma_B;

% Коэффициенты абсолютных размеров расчётного сечения
eps_sigma = 1/2*( 1 + power(d_eq/d_0, -2*nu_sigma) );
eps_tau = 1/2*( 1 + power(d_eq/d_0, -3*nu_sigma) );

% Коэффициент упрочнения
beta_1t = 0.575*beta_1 + 0.425;

% Коэффициенты учитывающие размеры и технологические факторы (эффективные 
% коэффициенты концентрации напряжений)
K_sigma = 1/(eps_sigma * beta_1 * beta_eq);
K_tau = 1/(eps_tau * beta_1 * beta_1t);

% Коэффициенты влияния ассиметрии цикла
psi_sigma = 2e-02 + 2e-04 * sigma_B;
psi_tau = 1e-02 + 1e-04 * sigma_B;

%% Stresses calculations

% Предел выносливости материала
sigma_minus1 = (0.55 - 1e-04*sigma_B)*sigma_B;
tau_minus1 = 0.6*sigma_minus1;

for i = 1:length(X_a)
    % Расчёт эквивалентных напряжений в каждом направлении
    % Нормальные напряжения
    X(i) = K_sigma*X_a(i) + psi_sigma*X_m(i);
    Y(i) = K_sigma*Y_a(i) + psi_sigma*Y_m(i);
    Z(i) = K_sigma*Z_a(i) + psi_sigma*Z_m(i);

    % Касательные напряжения
    XY(i) = K_tau*XY_a(i) + psi_tau*XY_m(i);
    YZ(i) = K_tau*YZ_a(i) + psi_tau*YZ_m(i);
    ZX(i) = K_tau*ZX_a(i) + psi_tau*ZX_m(i);
    
    % Эквивалентное напряжение
    sigma_equiv(i) = 1/sqrt(2)*sqrt(power(X(i)-Y(i), 2) + power(Y(i)-Z(i), 2)...
        + power(Z(i) -X(i), 2)+ 6*(power(XY(i), 2)+power(YZ(i), 2)+power(ZX(i), 2)));

    % Коэффициенты запаса
    n(i) = sigma_minus1/sigma_equiv(i);
end

%% Calculating critical matrixes
[n_min, number_min] = min(n);

T_sigmaMax = [...
    Xmax.data(number_min, 2), XYmax.data(number_min, 2), ZXmax.data(number_min, 2);...
    XYmax.data(number_min, 2), Ymax.data(number_min, 2), YZmax.data(number_min, 2);...
    ZXmax.data(number_min, 2), YZmax.data(number_min, 2), Zmax.data(number_min, 2)];

T_sigmaMin = [...
    Xmin.data(number_min, 2), XYmin.data(number_min, 2), ZXmin.data(number_min, 2);...
    XYmin.data(number_min, 2), Ymin.data(number_min, 2), YZmin.data(number_min, 2);...
    ZXmin.data(number_min, 2), YZmin.data(number_min, 2), Zmin.data(number_min, 2)];

%% Displaing the results
delete postProcResults.txt; diary('postProcResults.txt'); diary on;

disp('Материал:'); disp(alloyGrade);
disp('Предел прочности, МПа:'); disp(sigma_B);

disp('Коэффициент упрочнения (beta_упр):'); disp(surfaceUp); disp(beta_eq);

disp('Коэффициент учитывающий качество обработки поверхности (beta_1):');
disp(surfaceType); disp(beta_1);

disp('/----------------------- Результаты расчёта ----------------------/');
disp(' ');

disp('Предел выносливости материала, МПа:'); disp(sigma_minus1);

disp('Константа материала, характеризующая его чувствительность к');
disp('напряжениям и масштабному фактору (nu_sigma):');
disp(nu_sigma);

disp('Коэффициенты абсолютных размеров расчётного сечения - epsilon');
disp('(для нормальных и касательных напряжений соответственно):');
disp(eps_sigma); disp(eps_tau);

disp('Коэффициенты учитывающие размеры и технологические факторы - K')
disp('- эффективные коэффициенты концентрации напряжений');
disp('(для нормальных и касательных напряжений соответственно):');
disp(K_sigma); disp(K_tau);

disp('Коэффициенты влияния ассиметрии цикла - psi');
disp('(для нормальных и касательных напряжений соответственно):'); 
disp(psi_sigma); disp(psi_tau);

disp(' ');	disp(' ');
disp('Номер элемента с минимальным коэффицентом запаса:'); disp( number_min );
disp('ля нагружения при максимальной нагрузке:');
disp( number_min + nodeNumberStartMax - 1 );
disp('Node ID для нагружения при минимальной нагрузке:');
disp( number_min + nodeNumberStartMin - 1 );

disp('Предел циклической прочности материала - sigma_-1, tau_-1');
disp('(для нормальных и касательных напряжений соответственно), МПа:'); 
disp( sigma_minus1 ); disp( tau_minus1 );

disp('Тензоры напряжений для конечного элемена, в котором коэффициент');
disp('запаса минимален:'); disp(' ');
disp('При максимальой нагрузке, МПа:');  disp( T_sigmaMax );
disp('При минимальной нагрузке, МПа:');  disp( T_sigmaMin );

disp('~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~'); disp(' ');
disp('Минимальный расчётный коэффициент запаса:'); disp( n_min );

if n_toCompare ~= 0
    disp('Коэффициент запаса для сравнения:');
	disp( n_toCompare );
	disp('Погрешность cо сравниваемым коэффициентом запаса, %:');
	disp( abs(n_toCompare - min(n))/n_toCompare*100 );
end

disp('~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~'); disp(' ');

disp('/-----------------------------------------------------------------/');
disp(' '); disp('Contact me to feedback:'); 
disp('https://github.com/StasF1 or stanislau.stasheuski@gmail.com'); disp(' ');
disp('© 2018 Stanislau Stasheuski'); diary off;

%% Saving the results
% Moving results to the folder
mkdir postProcANSYS.Results;
copyfile postProcDict.m postProcANSYS.Results/
movefile postProcResults.txt postProcANSYS.Results/;

%% Copying input data to the results folder
mkdir postProcANSYS.Results/inputStressData; cd inputStressData/
copyfile('Normal_Xmax.txt', '../postProcANSYS.Results/inputStressData/');
copyfile('Normal_Xmin.txt', '../postProcANSYS.Results/inputStressData/');
copyfile('Normal_Ymax.txt', '../postProcANSYS.Results/inputStressData/');
copyfile('Normal_Ymin.txt', '../postProcANSYS.Results/inputStressData/');
copyfile('Normal_Zmax.txt', '../postProcANSYS.Results/inputStressData/');
copyfile('Normal_Zmin.txt', '../postProcANSYS.Results/inputStressData/');
copyfile('Shear_XYmax.txt', '../postProcANSYS.Results/inputStressData/');
copyfile('Shear_XYmin.txt', '../postProcANSYS.Results/inputStressData/');
copyfile('Shear_YZmax.txt', '../postProcANSYS.Results/inputStressData/');
copyfile('Shear_YZmin.txt', '../postProcANSYS.Results/inputStressData/');
copyfile('Shear_XZmax.txt', '../postProcANSYS.Results/inputStressData/');
copyfile('Shear_XZmin.txt', '../postProcANSYS.Results/inputStressData/');
cd ../postProcANSYS.Results/; open postProcResults.txt; cd ../;
clear; clc;
