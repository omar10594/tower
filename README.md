# Tower - Home Server Docker Configuration

A comprehensive Docker Compose template repository for managing self-hosted services on Unraid (or any Docker host) using Portainer. This repository provides a organized structure for running various services with full control over your home server setup.

## Overview

This repository contains Docker Compose configurations and scripts for managing a home server. It's designed to work with Unraid OS and Portainer but can be adapted for any Docker environment.

## Features

- 🐳 **Docker Compose Templates**: Pre-configured services ready to deploy
- 📦 **Modular Design**: Separate compose files for different service categories
- 🔒 **Security Focused**: Environment variables for sensitive data
- 📝 **Well Documented**: Clear examples and usage instructions
- 🔧 **Utility Scripts**: Automation for setup, backup, and updates
- 🎯 **Portainer Compatible**: Designed to work seamlessly with Portainer

## Quick Start

1. **Clone the repository**
   ```bash
   git clone https://github.com/omar10594/tower.git
   cd tower
   ```

2. **Run the setup script**
   ```bash
   ./scripts/setup.sh
   ```

3. **Configure your environment**
   ```bash
   cp .env.example .env
   nano .env  # Edit with your settings
   ```

4. **Start the basic services**
   ```bash
   docker compose up -d
   ```

5. **Access your services**
   - Portainer: `http://your-server-ip:9000`
   - Heimdall: `http://your-server-ip:8080`

## Repository Structure

```
tower/
├── docker-compose.yml          # Main compose file with essential services
├── .env.example                # Environment variables template
├── examples/                   # Additional service configurations
│   ├── docker-compose.media.yml
│   ├── docker-compose.downloads.yml
│   ├── docker-compose.monitoring.yml
│   └── docker-compose.network.yml
└── scripts/                    # Utility scripts
    ├── setup.sh                # Initial setup script
    ├── backup.sh               # Backup configurations
    └── update.sh               # Update containers
```

## Core Services

The main `docker-compose.yml` includes:

- **Portainer**: Container management UI
- **Heimdall**: Application dashboard for easy access to all services
- **Watchtower**: Automatic container updates

## Available Service Categories

### Media Services (`examples/docker-compose.media.yml`)
- Plex, Jellyfin, Emby - Media servers

### Download Management (`examples/docker-compose.downloads.yml`)
- Sonarr, Radarr, Lidarr - Media automation
- Prowlarr - Indexer manager
- qBittorrent - Download client

### Monitoring (`examples/docker-compose.monitoring.yml`)
- Grafana, Prometheus - Metrics and dashboards
- Uptime Kuma - Status monitoring
- Netdata - Real-time performance monitoring
- Scrutiny - Hard drive health monitoring

### Network & Security (`examples/docker-compose.network.yml`)
- Nginx Proxy Manager, Traefik - Reverse proxies
- Pi-hole - Network-wide ad blocking
- WireGuard - VPN server

## Using Multiple Compose Files

You can combine multiple compose files for your specific needs:

```bash
# Start core + media services
docker compose -f docker-compose.yml -f examples/docker-compose.media.yml up -d

# Start core + downloads + monitoring
docker compose -f docker-compose.yml \
  -f examples/docker-compose.downloads.yml \
  -f examples/docker-compose.monitoring.yml up -d
```

## Configuration

### Environment Variables

Copy `.env.example` to `.env` and customize:

```bash
# Timezone
TZ=America/New_York

# User/Group IDs (important for Unraid)
PUID=1000
PGID=1000

# Paths - Adjust to your Unraid shares
DATA_PATH=/mnt/user/appdata
MEDIA_PATH=/mnt/user/media
DOWNLOADS_PATH=/mnt/user/downloads
```

### Unraid-Specific Settings

For Unraid servers, typical paths are:
- Application data: `/mnt/user/appdata`
- Media files: `/mnt/user/media`
- Downloads: `/mnt/user/downloads`

Get your PUID/PGID by running: `id` in the Unraid terminal

## Portainer Deployment

### Option 1: Portainer Stacks
1. Open Portainer
2. Go to Stacks → Add Stack
3. Copy the contents of `docker-compose.yml`
4. Add environment variables from `.env`
5. Deploy

### Option 2: Portainer Git Repository
1. Open Portainer
2. Go to Stacks → Add Stack
3. Select "Repository" option
4. Enter this repository URL
5. Specify the compose file path
6. Add environment variables
7. Deploy

## Scripts

### Setup Script
```bash
./scripts/setup.sh
```
Initializes the environment and creates necessary directories.

### Backup Script
```bash
./scripts/backup.sh
```
Backs up configurations and data to the `backups/` directory.

### Update Script
```bash
./scripts/update.sh
```
Pulls latest container images.

## Common Commands

```bash
# Start all services
docker compose up -d

# Stop all services
docker compose down

# View logs
docker compose logs -f [service-name]

# Restart a service
docker compose restart [service-name]

# Update and restart services
docker compose pull
docker compose up -d --force-recreate

# Check running containers
docker compose ps
```

## Customization

This repository is designed as a template. Feel free to:
- Add or remove services based on your needs
- Modify port mappings
- Adjust volume paths for your Unraid setup
- Create custom compose files for your specific use cases

## Best Practices

1. **Use Environment Variables**: Keep sensitive data in `.env` (never commit this file)
2. **Regular Backups**: Run the backup script regularly
3. **Update Regularly**: Keep containers updated with Watchtower or manual updates
4. **Monitor Resources**: Use the monitoring stack to track server health
5. **Test Changes**: Test configuration changes on a copy before applying to production

## Troubleshooting

### Permission Issues
If you encounter permission errors, ensure your PUID and PGID match your Unraid user:
```bash
id  # Run this in Unraid terminal to get your IDs
```

### Port Conflicts
If a port is already in use, change it in the `.env` file:
```bash
PORTAINER_PORT=9001  # Changed from 9000
```

### Container Won't Start
Check logs for the specific container:
```bash
docker compose logs [service-name]
```

## Contributing

This is a personal server configuration, but contributions and suggestions are welcome! Feel free to:
- Open issues for bugs or suggestions
- Submit pull requests with improvements
- Share your own compose configurations

## License

This project is provided as-is for personal and educational use. Feel free to use and modify as needed.

## Acknowledgments

- LinuxServer.io for their excellent container images
- The open-source community for the amazing self-hosted software
- Unraid for providing a great server OS

## Support

For issues or questions:
- Check existing issues in this repository
- Consult the official documentation for each service
- Join the Unraid community forums

---

**Note**: This is a template repository. Customize it to fit your specific needs and infrastructure.
