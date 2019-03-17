%% Data of the crankshaft and it's material

alloyGrade = '18ХГТ'; % Марка стали
sigma_B = 1080; % MPa, предел прочности материала

%% Reference section
% Указывать только один параметр (по которому и вести расчёт)! Другой
% принять за ноль.

% Площадь расчётного сечения
F = 19509; % mm^2, ignored if 0

% Диаметр расчётного сечения
d_refSection = 0; % millimeters, ignored if 0

%% Experimental data and coefficients
% Диаметр образца
d_0 = 7.5; % millimeters

% Коэффициент упрочнения
beta_eq = 1.2; surfaceUp = '<способ упрочнения поверхности>';

% Коэффициент учитывающий качество обработки поверхности
beta_1 = 0.87; surfaceType = '<способ обработки поверхности>';

%% Safety factor to compare (from KVAL e.g.)
n_toCompare = 1.69; % ignored if 0