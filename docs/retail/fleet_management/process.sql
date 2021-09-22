---------------------------------------------------------------------------------------------------
-- Register sources:
---------------------------------------------------------------------------------------------------
-- stream of locations:
CREATE STREAM locations (
        vehicle_id int,
        latitude float,
        longitude float,
        timestamp varchar
    ) with (
        kafka_topic = 'locations',
        value_format = 'json'
    );

-- fleet lookup table:
CREATE TABLE fleet (
        vehicle_id int,
        driver_last_name varchar,
        license_plate varchar
    ) with (
        kafka_topic = 'descriptions',
        value_format = 'json'
    );

-- enrich fleet location stream with more fleet information:
CREATE STREAM fleet_location_enhanced AS
    SELECT
        vehicle_id,
        latitude,
        longitude,
        timestamp,
        f.driver_laste_name,
        f.license_plate
    FROM locations l
        LEFT JOIN fleet f ON l.vehicle_id = f.vehicle_id;
