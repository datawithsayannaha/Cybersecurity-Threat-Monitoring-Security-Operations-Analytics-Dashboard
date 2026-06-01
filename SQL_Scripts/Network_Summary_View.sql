CREATE OR ALTER VIEW gold.vw_network_summary AS
SELECT
    country AS connection_status,
    city AS protocol,

    COUNT(*) AS total_connections,

    AVG(failed_attempts) AS avg_failed_attempts,
    MAX(failed_attempts) AS max_failed_attempts,
    MIN(failed_attempts) AS min_failed_attempts

FROM gold.vw_network_activity_clean
GROUP BY
    country,
    city;

SELECT *
FROM gold.vw_network_summary;
