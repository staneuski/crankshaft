# Описание
Программа определяет момент инерции маховика

# Порядок работы с программой
## Индикаторная диаграмма
- Файл из папки проекта Diesel-RK <название>.ind, но с удалёнными в нём строками с описанием (*кроме шапки таблицы*)
- Текстовый файл имеющий формат .ind с любым названием *содержащий шапку таблицы* и два столбца - один с углами, другой с давлением в цилиндре

**Файл должен быть сохранён в папке проекта**
## Корректировка данных и компиляция
1) В flywheelDict.m изменяем данные на данные своего двигателя
2) В MATLAB запускаем "Main"
3) Данные расчёта сохранятся в папке flywheel.Results

## Результаты работы
### Силы действующие на поршень
![alt text](https://github.com/StasF1/crankshaft/blob/master/etc/images/flywheel/forcesInCombustor.png)

### Силы в цилиндро-поршневой группе
![alt text](https://github.com/StasF1/crankshaft/blob/master/etc/images/flywheel/forcesTZK.png)

### Мгновенный и средний крутящие моменты
![alt text](https://github.com/StasF1/crankshaft/blob/master/etc/images/flywheel/torqueMoment.png)

### Работа крутящего момента
![alt text](https://github.com/StasF1/crankshaft/blob/master/etc/images/flywheel/workOfMoment.png)
---
### Пример отчёта
<pre><code>
Mean value of angular velocity of the crankshaft, rad/s
  167.5516

Maximum of work A, J
  377.4728

Minimum of work A, J
   -7.8348

Overwork of torque moment, J
  385.3075

/----------------------------- Results -----------------------------/
 
Flywheel moment of inertia, kg*m^2
    0.1177

Ratio of flywheel moment of inertia to motor mass moment of inertia
J_flywheel/Jmm
    8.0050

/-------------------------------------------------------------------/
</code></pre>
---
