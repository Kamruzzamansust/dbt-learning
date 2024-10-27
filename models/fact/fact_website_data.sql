{{ 
    config(
        materialized = 'table' 
    ) 
}}

SELECT 
    d.date_key,
    u.user_key,
    ts.traffic_source_key,
    dv.device_key,
    s.page_views AS total_page_views,
    s.session_duration_sec AS total_session_duration,
    s.bounce_rate_percent AS total_bounce_rate_sec,
    s.conversion AS total_conversion
FROM 
    {{ ref('staging_website_data') }} s
JOIN {{ ref('dim_date') }} d ON DATE(s.date) = d.date_key
JOIN {{ ref('dim_user') }} u ON s.country = u.country 
    AND s.device_type = u.device_type 
    AND s.browser = u.browser
JOIN {{ ref('dim_traffic_source') }} ts ON s.traffic_source = ts.traffic_source
JOIN {{ ref('dim_device_type') }} dv ON s.device_type = dv.device_type
ORDER BY 
    d.date_key, u.user_key, ts.traffic_source_key, dv.device_key
