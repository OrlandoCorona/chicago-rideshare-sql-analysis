-- Análisis de viajes en taxi de Chicago (noviembre 2017)
-- Consultas usadas para generar los datasets del análisis.

-- 1) Número de viajes por compañía de taxi (15-16 de noviembre de 2017)
--    -> project_sql_result_01.csv
SELECT
    cabs.company_name        AS company_name,
    COUNT(trips.trip_id)     AS trips_amount
FROM trips
JOIN cabs ON cabs.cab_id = trips.cab_id
WHERE CAST(trips.start_ts AS date) BETWEEN '2017-11-15' AND '2017-11-16'
GROUP BY cabs.company_name
ORDER BY trips_amount DESC;

-- 2) Promedio de viajes que terminan en cada barrio (noviembre 2017)
--    -> project_sql_result_04.csv
SELECT
    neighborhoods.name                         AS dropoff_location_name,
    AVG(sub.trips_amount)                       AS average_trips
FROM (
    SELECT
        trips.dropoff_location_id          AS location_id,
        CAST(trips.start_ts AS date)       AS trip_date,
        COUNT(trips.trip_id)               AS trips_amount
    FROM trips
    WHERE EXTRACT(MONTH FROM trips.start_ts) = 11
      AND EXTRACT(YEAR  FROM trips.start_ts) = 2017
    GROUP BY location_id, trip_date
) AS sub
JOIN neighborhoods ON neighborhoods.neighborhood_id = sub.location_id
GROUP BY neighborhoods.name
ORDER BY average_trips DESC;

-- 3) Viajes del Loop al Aeropuerto O'Hare los sábados, con clima y duración
--    -> project_sql_result_07.csv
SELECT
    trips.start_ts                                        AS start_ts,
    CASE
        WHEN weather.description LIKE '%rain%'
          OR weather.description LIKE '%storm%' THEN 'Bad'
        ELSE 'Good'
    END                                                   AS weather_conditions,
    trips.duration_seconds                                AS duration_seconds
FROM trips
JOIN weather_records AS weather
  ON weather.ts = date_trunc('hour', trips.start_ts)
WHERE trips.pickup_location_id  = 50      -- Loop
  AND trips.dropoff_location_id = 63      -- O'Hare
  AND EXTRACT(DOW FROM trips.start_ts) = 6;   -- sábados
