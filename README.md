# О crankshaft
Репозиторий представляет из себя несколько MATLAB программ (каждая в своей папке), рассчитывающих угол сектора противовеса, момент инерции маховика, максимальные и минимальные силы, действующие на коленчатый вал и проводит пост-обработку данных из ANSYS c расчётом коэффициента запаса.

В каждой папке присутсвует описание работы подпрограмм.
# Требования
1. **MATLAB**
2. **ANSYS** (для [postProcessingANSYS](https://github.com/StasF1/crankshaft/tree/master/postProcessingANSYS) и получения полей напряжений)

# [История версий](https://github.com/StasF1/crankshaft/releases)
|Версия|Описание|Скачать|
|-----:|------:|:--|
|[v1.0](https://github.com/StasF1/crankshaft/tree/v1.0)|Несколько разных репозиториев (MATLAB-программ) объединены в один|[.tar.gz](https://github.com/StasF1/crankshaft/archive/v1.0.tar.gz), [.zip](https://github.com/StasF1/crankshaft/archive/v1.0.zip)|

# Порядок работы с программой
Коротко (для любой из подпрограмм):
- `<subscript name>Dict.m` - файл словаря с настройками подпрограммы.
- Запуск подпрограммы в _Command Window_:
    ```MATLAB
    Main.m
    ```

Подробнее (для каждой подпрограммы):
- [**conrodForces**](https://github.com/StasF1/crankshaft/tree/master/conrodForces) - определение максимальной и минимальной силы **К** действующей на шатун(ы).
- [**flywheel**](https://github.com/StasF1/crankshaft/tree/master/flywheel) - определение момента инерции маховика.
- [**postProcessingANSYS**](https://github.com/StasF1/crankshaft/tree/master/postProcessingANSYS) - определение коэфициента запаса циклической прочности (на основе полученных в ANSYS распределений напряжений).
- [**sectorAngle**](https://github.com/StasF1/crankshaft/tree/master/sectorAngle) - определение угла сектора противовеса.
    
# Структура
```gitignore
crankshaft
├── conrodForces
├── flywheel
├── postProcessingANSYS
│   └── inputStressData
└── sectorAngle
```
