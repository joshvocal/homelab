#!/bin/bash
docker exec -t immich_postgres pg_dumpall -c -U postgres | gzip > "/mnt/docker/immich-app/dump.sql.gz"

rsync -r . /mnt/docker/immich-app