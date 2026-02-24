WITH station_dimension AS (
    SELECT 
    START_STATION_ID,
    START_STATION_NAME,
    START_LAT,
    START_LNG 
    FROM
    {{ ref('stg_bike') }}
)

SELECT * FROM station_dimension