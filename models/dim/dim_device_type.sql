-- models/dim_device.sql

{{ 
    config(
        materialized = 'table' 
    ) 
}}

WITH device_data AS (
    SELECT 
        ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS device_id,
        DEVICE_TYPE
    FROM 
        {{ ref('staging_website_data') }}
    GROUP BY 
        DEVICE_TYPE
)

SELECT 
    device_id AS device_key,
    DEVICE_TYPE
FROM 
    device_data
ORDER BY 
    device_key
