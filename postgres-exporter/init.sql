-- Creates (or re-passwords) a dedicated read-only role for postgres_exporter.
-- pg_monitor is a built-in Postgres role (10+) that grants SELECT on the
-- pg_stat_* views and EXECUTE on monitoring functions without superuser.
DO $$
BEGIN
  IF NOT EXISTS (SELECT FROM pg_roles WHERE rolname = 'postgres_exporter') THEN
    CREATE ROLE postgres_exporter LOGIN;
  END IF;
END
$$;

ALTER ROLE postgres_exporter WITH PASSWORD :'exporter_password';
GRANT pg_monitor TO postgres_exporter;
