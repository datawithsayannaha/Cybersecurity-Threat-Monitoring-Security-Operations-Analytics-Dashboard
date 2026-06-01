CREATE OR ALTER VIEW gold.vw_users_clean AS

SELECT
    user_id,
    MAX(location) AS location,
    MAX(risk_level) AS risk_level
FROM gold.dim_users
GROUP BY user_id;

SELECT * FROM gold.vw_users_clean

CREATE OR ALTER VIEW gold.vw_devices_clean AS
SELECT DISTINCT
    device_id,
    device_type,
    os_version
FROM gold.dim_devices;
SELECT * FROM gold.vw_devices_clean

CREATE OR ALTER VIEW gold.vw_threats_clean AS
SELECT DISTINCT
    threat_id,
    threat_type,
    severity,
    status
FROM gold.dim_threats;
SELECT * FROM gold.vw_threats_clean

CREATE OR ALTER VIEW gold.vw_security_events_clean AS
SELECT
    event_key,
    event_id,
    user_id,
    device_id,
    threat_id,
    event_timestamp,

    CASE
        WHEN action_taken IS NULL THEN 'UNKNOWN'
        ELSE action_taken
    END AS action_taken,

    CASE
        WHEN risk_score IS NULL THEN 0
        ELSE risk_score
    END AS risk_score

FROM gold.fact_security_events;

SELECT TOP 100 *
FROM gold.vw_security_events_clean;

CREATE OR ALTER VIEW gold.vw_network_activity_clean AS
SELECT
    network_key,
    ip_address,
    country,
    city,
    browser,

    CASE
        WHEN TRY_CAST(failed_attempts AS FLOAT) < 0 THEN 0
        ELSE TRY_CAST(failed_attempts AS FLOAT)
    END AS failed_attempts

FROM gold.fact_network_activity;
SELECT * from gold.vw_network_activity_clean