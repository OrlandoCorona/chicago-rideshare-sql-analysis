# Chicago Rideshare SQL Analysis

Análisis de la demanda de viajes en taxi en **Chicago** (noviembre 2017) a
partir de resultados de consultas SQL, e identificación de si el **clima**
influye en la duración de los trayectos.

## Objetivo del negocio

Entender el comportamiento de la demanda de taxis para apoyar decisiones de
operación y marketing, respondiendo:

> ¿Qué compañías y barrios concentran más viajes, y afecta el clima a la
> duración de los trayectos los fines de semana?

## Tecnologías

- Python 3.11
- pandas — manipulación de datos
- Matplotlib — visualización
- SciPy — prueba de hipótesis (t de Welch)
- Jupyter Notebook
- SQL (origen de los datos)

## Dataset

Tres archivos CSV obtenidos de consultas SQL. Se incluyen en el repositorio por
ser ligeros; detalle en [`data/README.md`](data/README.md).

## Proceso de análisis

1. **Carga** de los resultados SQL (compañías, barrios y viajes con clima).
2. **Demanda por compañía:** ranking y visualización de viajes por empresa.
3. **Demanda por barrio:** Top 10 de barrios por promedio de viajes de destino.
4. **Prueba de hipótesis:** comparación de la duración de los viajes los sábados
   con clima *Good* vs *Bad* mediante una prueba t de Welch.

## Resultados

- **Flash Cab** y **Taxi Affiliation Services** son las compañías con más viajes.
- **Loop**, **River North** y **Streeterville** son los barrios con más destinos.
- El **p-valor < 0.05** lleva a rechazar la hipótesis nula: la duración promedio
  de los viajes los sábados **difiere significativamente** según el clima
  (los días de mal clima presentan trayectos más largos:
  ≈ 2427 s vs ≈ 2000 s).

## Conclusiones

El clima sí afecta la duración de los viajes los fines de semana, un factor a
considerar en la planificación de la oferta y en los tiempos estimados al
cliente. La demanda está concentrada en pocas compañías y barrios céntricos.

## Estructura del proyecto

```
chicago-rideshare-sql-analysis/
├── Notebook/
│   └── chicago_rideshare_analysis.ipynb   # análisis exploratorio
├── data/                                  # resultados de las consultas SQL
├── chicago_rideshare_analysis.py          # análisis en formato script
├── requirements.txt
├── LICENSE
└── README.md
```

## Cómo ejecutar

```bash
git clone https://github.com/OrlandoCorona/chicago-rideshare-sql-analysis.git
cd chicago-rideshare-sql-analysis

python -m venv venv
source venv/bin/activate        # En Windows: venv\Scripts\activate
pip install -r requirements.txt

jupyter notebook Notebook/chicago_rideshare_analysis.ipynb
```

Los datos ya están incluidos en `data/`, así que el notebook y el script
[`chicago_rideshare_analysis.py`](chicago_rideshare_analysis.py) se ejecutan sin pasos adicionales.

## Capturas sugeridas

En una carpeta `images/` puedes añadir:

- Viajes por compañía de taxi (barras).
- Top 10 de barrios por promedio de viajes.

## Trabajo futuro

- Incluir las consultas SQL originales en una carpeta `sql/`.
- Analizar la demanda por hora del día y día de la semana.
- Cruzar la duración con la distancia para estimar velocidad media.
