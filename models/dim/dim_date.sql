-- models/dim_date.sql

{{ 
    config(
        materialized = 'table'  
    ) 
}}

WITH date_range AS (
    SELECT 
        DISTINCT DATE(DATE) AS date_value
    FROM 
        {{ ref('staging_website_data') }}
),

dates AS (
    SELECT
        date_value,
        EXTRACT(YEAR FROM date_value) AS year,
        EXTRACT(MONTH FROM date_value) AS month,
        EXTRACT(DAY FROM date_value) AS day,
        TO_CHAR(date_value, 'Month') AS month_name,
        EXTRACT(DOW FROM date_value) AS day_of_week,
        CASE 
            WHEN EXTRACT(DOW FROM date_value) IN (0, 6) THEN 'Weekend'
            ELSE 'Weekday'
        END AS weekend_weekday
    FROM 
        date_range
)

SELECT 
    date_value AS date_key,
    year,
    month,
    day,
    month_name,
    day_of_week,
    weekend_weekday
FROM 
    dates
ORDER BY 
    date_key
