# Описание
Программа определяет максимальную и минимальную силу К действующую на шатуны. Углы между ними и плоскостью симметрии колена вала при действии экстримальных нагрузок

### Блок-схема работы программы на примере расчёта колена вала на циклическую прочность (с определением коэффициента запаса в postProcessingANSYS)
![alt text](https://github.com/StasF1/crankshaft/blob/master/etc/images/conrodForces/conrodForcesToPostProcANSYS.png)
[postProcessingANSYS](https://github.com/StasF1/crankshaft/tree/master/postProcessingANSYS)

# Порядок работы с программой
## Индикаторная диаграмма
- Файл из папки проекта Diesel-RK <название>.ind, но с удалёнными в нём строками с описанием (*кроме шапки таблицы*)
- Текстовый файл имеющий формат .ind с любым названием *содержащий шапку таблицы* и два столбца - один с углами, другой с давлением в цилиндре

**Файл должен быть сохранён в папке проекта**
## Корректировка данных и компиляция
1) В conrodForcesDict.m изменяем данные на данные своего двигателя (в случае рядного двигателя выставляем crankshaftAngle = 0 и combustionAngle = 0)
2) В MATLAB запускаем "Main"
3) Данные расчёта сохранятся в папке conrodForces.Results

## Результаты работы
### Силы в цилиндро-поршневой группе
![alt text](https://github.com/StasF1/crankshaft/blob/master/etc/images/conrodForces/forcesTZK.png)

Бирозовыми точками обозначается минимум и максимум действующих вдоль шатуна сил

### Варианты нагружения коленчатого вала при экремальных нагрузках
Максимальная нагрузка      |  Минимальная нагрузка
:-------------------------:|:-------------------------:
![alt text](https://github.com/StasF1/crankshaft/blob/master/etc/images/conrodForces/loadingModels-Max.png)  |  ![alt text](https://github.com/StasF1/crankshaft/blob/master/etc/images/conrodForces/loadingModels-Min.png)

---
### Пример отчёта
<pre><code>
Crank angle (alpha) when force K is maximum, deg

  366

Crank angle (alpha) when force K is minimum, deg

  12

Crank angle is zero (alpha = 0) at TDC

/--------------------- Results ----------------------/

Matrix of pushing conrod forces, N / 1e+05
    Maximum   Minimum
    1.0765   -0.0542
    0.0716    0.1242

Matrix of angles beetween conrods & crankshaft, deg
   Max   Min
    -8   -16
   130   125

"-" is anticlockwise direction,
"+" is clockwise direction

/----------------------------------------------------/
</code></pre>
---
