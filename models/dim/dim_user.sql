-- models/dim_user.sql

{{ 
    config(
        materialized = 'table' 
    ) 
}}

WITH user_data AS (
    SELECT 
        ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS user_id,
        COUNTRY,
        DEVICE_TYPE,
        BROWSER
    FROM 
        {{ ref('staging_website_data') }}
    GROUP BY 
        COUNTRY, DEVICE_TYPE, BROWSER
)

SELECT 
    user_id AS user_key,
    COUNTRY,
    DEVICE_TYPE,
    BROWSER
FROM 
    user_data
ORDER BY 
    user_key
