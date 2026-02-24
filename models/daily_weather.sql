WITH daily_weather AS (
    SELECT 
    DATE(TIME) AS DAILY_WEATHER,
    WEATHER,
    TEMP,
    PRESSURE,
    HUMIDITY,
    CLOUDS
    FROM 
    {{source('demo','weather')}}
),
daily_weather_agg AS (
    SELECT 
    DAILY_WEATHER,
    WEATHER,
    ROUND(AVG(TEMP),2) AS avg_temp,
    ROUND(AVG(PRESSURE),2) AS avg_pressure,
    ROUND(AVG(HUMIDITY),2) AS avg_humidity,
    ROUND(AVG(CLOUDS),2) AS avg_clouds
    FROM daily_weather
    GROUP BY DAILY_WEATHER,WEATHER
    qualify ROW_NUMBER() OVER (PARTITION BY DAILY_WEATHER ORDER BY COUNT(WEATHER) DESC)=1
)

SELECT * FROM daily_weather_agg