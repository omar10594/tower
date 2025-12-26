#!/bin/bash

# Setup script for Tower server
# This script helps with initial setup of the Docker environment

set -e

echo "================================================"
echo "Tower Server Setup Script"
echo "================================================"
echo ""

# Check if Docker is installed
if ! command -v docker &> /dev/null; then
    echo "ERROR: Docker is not installed or not in PATH"
    echo "Please install Docker first"
    exit 1
fi

# Check if Docker Compose is installed
if ! docker compose version &> /dev/null; then
    echo "ERROR: Docker Compose is not installed or not available"
    echo "Please install Docker Compose plugin"
    exit 1
fi

echo "✓ Docker and Docker Compose are installed"
echo ""

# Create .env file if it doesn't exist
if [ ! -f .env ]; then
    echo "Creating .env file from template..."
    cp .env.example .env
    echo "✓ .env file created"
    echo "⚠️  Please edit .env file and configure your settings"
    echo ""
else
    echo "✓ .env file already exists"
    echo ""
fi

# Get user/group IDs
CURRENT_UID=$(id -u)
CURRENT_GID=$(id -g)
echo "Your current UID: $CURRENT_UID"
echo "Your current GID: $CURRENT_GID"
echo ""

# Create data directories
echo "Creating data directories..."
DATA_PATH=${DATA_PATH:-./data}
mkdir -p "$DATA_PATH"
echo "✓ Data directory created at: $DATA_PATH"
echo ""

# Display next steps
echo "================================================"
echo "Setup Complete!"
echo "================================================"
echo ""
echo "Next steps:"
echo "1. Edit the .env file with your configuration"
echo "2. Review docker-compose.yml and customize services"
echo "3. Start services with: docker compose up -d"
echo "4. Check status with: docker compose ps"
echo ""
echo "Optional: Check examples/ directory for additional services"
echo ""
