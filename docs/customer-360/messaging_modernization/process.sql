SET 'auto.offset.reset' = 'earliest';

-- Register the initial stream
CREATE STREAM rabbit (timestamp VARCHAR KEY,
                      transaction VARCHAR,
                      amount VARCHAR,
                      userid VARCHAR
) WITH (
  KAFKA_TOPIC='from-rabbit',
  VALUE_FORMAT='json',
  PARTITIONS=6
);

-- Convert the transactions stream to typed fields
CREATE STREAM rabbit_transactions 
  WITH (KAFKA_TOPIC = 'rabbit_transactions') AS
  SELECT ROWTIME AS TX_TIMESTAMP,
         TRANSACTION AS TX_TYPE,
         SUBSTRING(AMOUNT,1,1) AS CURRENCY,
         CAST(SUBSTRING(AMOUNT,2,LEN(AMOUNT)-1) AS DECIMAL(9,2)) AS TX_AMOUNT,
         CAST(USERID AS INT) AS USERID
  FROM rabbit
  WHERE TIMESTAMP IS NOT NULL
  EMIT CHANGES;
