#!/bin/bash

echo "Uncomment to run this"

# Uncomment
# docker compose down -v  # CAUTION! Deletes all Immich data to start from scratch.
# docker compose pull     # Update to latest version of Immich (if desired)
# docker compose create   # Create Docker containers for Immich apps without running them.
# docker start immich_postgres    # Start Postgres server
# sleep 10    # Wait for Postgres server to start up
# gunzip < "/mnt/docker/immich-app/dump.sql.gz" | docker exec -i immich_postgres psql -U postgres -d immich    # Restore Backup
# docker compose up -d    # Start remainder of Immich apps