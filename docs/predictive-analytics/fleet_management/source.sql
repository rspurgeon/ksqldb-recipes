-- Stream of fleet descriptions
CREATE SOURCE CONNECTOR fleet_description WITH (
  'connector.class'          = 'MongoDbAtlasSource',
  'name'                     = 'recipe-mongodb-fleet_description',
  'kafka.api.key'            = '<my-kafka-api-key>',
  'kafka.api.secret'         = '<my-kafka-api-secret>',
  'connection.host'          = '<database-host-address>',
  'connection.user'          = '<database-username>',
  'connection.password'      = '<database-password>',
  'database'                 = '<database-name>',
  'collection'               = '<database-collection-name>',
  'poll.await.time.ms'       = '5000',
  'poll.max.batch.size'      = '1000',
  'copy.existing'            = 'true',
  'output.data.format'       = 'JSON'
  'tasks.max'                = '1');

-- Stream of current location of each vehicle in the fleet
CREATE SOURCE CONNECTOR fleet_location WITH (
  'connector.class'          = 'PostgresSource',
  'name'                     = 'recipe-postgres-fleet_location',
  'kafka.api.key'            = '<my-kafka-api-key>',
  'kafka.api.secret'         = '<my-kafka-api-secret>',
  'connection.host'          = '<my-database-endpoint>',
  'connection.port'          = '5432',
  'connection.user'          = 'postgres',
  'connection.password'      = '<my-database-password>',
  'db.name'                  = '<db-name>',
  'table.whitelist'          = 'fleet_location',
  'timestamp.column.name'    = 'created_at',
  'output.data.format'       = 'JSON',
  'db.timezone'              = 'UTC',
  'tasks.max'                = '1');
