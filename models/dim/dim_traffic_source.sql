-- models/dim_traffic_source.sql

{{ 
    config(
        materialized = 'table' 
    ) 
}}

WITH traffic_source_data AS (
    SELECT 
        ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS traffic_source_id,
        TRAFFIC_SOURCE
    FROM 
        {{ ref('staging_website_data') }}
    GROUP BY 
        TRAFFIC_SOURCE
)

SELECT 
    traffic_source_id AS traffic_source_key,
    TRAFFIC_SOURCE
FROM 
    traffic_source_data
ORDER BY 
    traffic_source_key
