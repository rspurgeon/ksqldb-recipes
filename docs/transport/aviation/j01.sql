SET 'auto.offset.reset' = 'earliest';

CREATE TABLE CUSTOMER_BOOKINGS AS 
  SELECT C.*, B.ID, B.FLIGHT_ID
  FROM   BOOKINGS B
          INNER JOIN CUSTOMERS C
              ON B.CUSTOMER_ID = C.ID;
