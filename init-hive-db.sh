#!/bin/bash
set -e

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" <<-EOSQL
  CREATE USER hue WITH PASSWORD 'hue';
  CREATE DATABASE hue;
  GRANT ALL PRIVILEGES ON DATABASE hue TO hue;

SELECT 'GRANT SELECT,INSERT,UPDATE,DELETE ON "' || schemaname || '"."' || tablename || '" TO hue ;'
FROM pg_tables
WHERE tableowner = CURRENT_USER and schemaname = 'public';

EOSQL
