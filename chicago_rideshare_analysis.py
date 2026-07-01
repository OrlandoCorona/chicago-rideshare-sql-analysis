"""
Análisis de viajes en taxi de Chicago (noviembre 2017).

Versión en script del notebook `chicago_rideshare_analysis.ipynb`: explora la
demanda por compañía y por barrio y contrasta si el clima influye en la
duración de los viajes de los sábados (prueba t de Welch).
"""

import pandas as pd
from matplotlib import pyplot as plt
from scipy import stats


# --- Carga de datos ---
df_companies = pd.read_csv('data/project_sql_result_01.csv')
df_areas = pd.read_csv('data/project_sql_result_04.csv')

# --- Top 10 de barrios por promedio de viajes ---
top10 = df_areas.sort_values('average_trips', ascending=False).head(10)
print(top10)

# --- Viajes por compañia ---
# Visualizamos el volumen de viajes por compañía para identificar las más activas

df_companies.sort_values('trips_amount', ascending=False).plot(
x='company_name',
y='trips_amount',
kind='bar',
figsize=(10,5),
legend=False
)
plt.title('Viajes por compañía de taxi')
plt.ylabel('Viajes')
plt.xlabel('Compañía')
plt.tight_layout()
plt.show()

# --- Prueba de hipotesis: clima vs duracion (sabados) ---
df = pd.read_csv('data/project_sql_result_07.csv')
df['start_ts'] = pd.to_datetime(df['start_ts'])
df['weekday'] = df['start_ts'].dt.dayofweek
df_sat = df[df['weekday'] == 5]
good = df_sat[df_sat['weather_conditions'] == 'Good']['duration_seconds']
bad = df_sat[df_sat['weather_conditions'] == 'Bad']['duration_seconds']

alpha = 0.05
stat, p_value = stats.ttest_ind(good, bad, equal_var=False)
print(f"t={stat:.3f}, p-value={p_value:.5f}")
print('Media Good:', good.mean())
print('Media Bad:', bad.mean())
if p_value < alpha:
    print('Rechazamos H0: el clima influye en la duracion de los viajes.')
else:
    print('No rechazamos H0.')
