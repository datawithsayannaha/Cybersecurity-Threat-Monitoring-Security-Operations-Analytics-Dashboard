CREATE TABLE gold.dim_users (
    user_key INT IDENTITY(1,1) PRIMARY KEY,
    user_id VARCHAR(100),
    location VARCHAR(100),
    risk_level VARCHAR(50)
);
GO

CREATE TABLE gold.dim_devices (
    device_key INT IDENTITY(1,1) PRIMARY KEY,
    device_id VARCHAR(100),
    device_type VARCHAR(100),
    os_version VARCHAR(100)
);
GO

CREATE TABLE gold.dim_threats (
    threat_key INT IDENTITY(1,1) PRIMARY KEY,
    threat_id VARCHAR(100),
    threat_type VARCHAR(100),
    severity VARCHAR(50),
    status VARCHAR(50)
);
GO

CREATE TABLE gold.fact_security_events (
    event_key INT IDENTITY(1,1) PRIMARY KEY,
    event_id VARCHAR(100),
    user_id VARCHAR(100),
    device_id VARCHAR(100),
    threat_id VARCHAR(100),
    event_timestamp DATETIME,
    risk_score INT,
    action_taken VARCHAR(100)
);
GO

ALTER TABLE gold.fact_security_events
ALTER COLUMN event_timestamp VARCHAR(100);

CREATE TABLE gold.fact_network_activity (
    network_key INT IDENTITY(1,1) PRIMARY KEY,
    ip_address VARCHAR(100),
    country VARCHAR(100),
    city VARCHAR(100),
    browser VARCHAR(100),
    failed_attempts INT
);
GO
ALTER TABLE gold.fact_network_activity
ALTER COLUMN failed_attempts VARCHAR(100);