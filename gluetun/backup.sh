#!/bin/bash
rsync -r ./data/gluetun/ /mnt/docker/gluetun
rsync -r ./data/prowlarr/ /mnt/docker/prowlarr/
rsync -r ./data/radarr/ /mnt/docker/radarr/
rsync -r ./data/sonarr/ /mnt/docker/sonarr/
rsync -r ./data/qbittorrent/ /mnt/docker/qbittorrent