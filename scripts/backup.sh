#!/bin/bash

# Backup script for Docker container configurations
# This script backs up container volumes and configurations

set -e

BACKUP_DIR=${BACKUP_DIR:-./backups}
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
DATA_PATH=${DATA_PATH:-./data}

echo "================================================"
echo "Tower Server Backup Script"
echo "================================================"
echo ""

# Create backup directory
mkdir -p "$BACKUP_DIR"

# Backup .env file
echo "Backing up .env file..."
if [ -f .env ]; then
    cp .env "$BACKUP_DIR/.env.$TIMESTAMP"
    echo "✓ .env backed up"
else
    echo "⚠️  No .env file found"
fi

# Backup docker-compose.yml
echo "Backing up docker-compose.yml..."
if [ -f docker-compose.yml ]; then
    cp docker-compose.yml "$BACKUP_DIR/docker-compose.yml.$TIMESTAMP"
    echo "✓ docker-compose.yml backed up"
else
    echo "⚠️  No docker-compose.yml file found"
fi

# Backup data directory
echo "Backing up data directory..."
if [ -d "$DATA_PATH" ]; then
    tar -czf "$BACKUP_DIR/data_$TIMESTAMP.tar.gz" "$DATA_PATH"
    echo "✓ Data directory backed up"
else
    echo "⚠️  No data directory found at: $DATA_PATH"
fi

echo ""
echo "================================================"
echo "Backup Complete!"
echo "================================================"
echo "Backup location: $BACKUP_DIR"
echo "Timestamp: $TIMESTAMP"
echo ""
