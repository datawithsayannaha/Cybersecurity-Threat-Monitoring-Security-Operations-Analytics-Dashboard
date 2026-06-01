CREATE OR ALTER VIEW gold.vw_security_analytics AS

SELECT
    e.event_key,
    e.event_id,
    e.user_id,

    u.location,
    u.risk_level,

    e.event_timestamp,

    CAST(TRY_CAST(e.event_timestamp AS DATETIME) AS DATE) AS event_date,

    YEAR(TRY_CAST(e.event_timestamp AS DATETIME)) AS event_year,

    DATEPART(QUARTER, TRY_CAST(e.event_timestamp AS DATETIME)) AS event_quarter,

    MONTH(TRY_CAST(e.event_timestamp AS DATETIME)) AS event_month_no,

    DATENAME(MONTH, TRY_CAST(e.event_timestamp AS DATETIME)) AS event_month_name,

    DATENAME(WEEKDAY, TRY_CAST(e.event_timestamp AS DATETIME)) AS weekday_name,

    e.action_taken,

    CASE
        WHEN e.action_taken = 'LOCKED' THEN 3
        WHEN e.action_taken = 'FAILED' THEN 2
        ELSE 1
    END AS risk_score,

    CASE
        WHEN e.action_taken = 'LOCKED' THEN 'Critical'
        WHEN e.action_taken = 'FAILED' THEN 'High'
        ELSE 'Normal'
    END AS risk_category,

    CASE
        WHEN e.action_taken = 'FAILED' THEN 1
        ELSE 0
    END AS failed_flag,

    CASE
        WHEN e.action_taken = 'LOCKED' THEN 1
        ELSE 0
    END AS locked_flag

FROM gold.vw_security_events_clean e

LEFT JOIN gold.vw_users_clean u
    ON e.user_id = u.user_id;

SELECT * from gold.vw_security_analytics
