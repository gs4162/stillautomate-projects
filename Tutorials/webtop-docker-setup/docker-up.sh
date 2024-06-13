#!/bin/bash

# Load environment variables from .env file
set -a
source .env
set +a

# Stop and remove the container and volumes if persistence is false
if [ "$PERSISTENCE" = "false" ]; then
  echo "Stopping and removing the existing container and volumes..."
  docker compose down -v

  echo "Removing persistent volume data..."
  rm -rf ./webtop_volume*
fi

echo "Starting the container..."
docker compose up -d
