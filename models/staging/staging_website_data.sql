{{ config(
    materialized='table'
) }}

with base as (
    select * from {{ source('raw_3_airflow', 'staging_website_data') }}
)

select * from base
