# Examples Directory

This directory contains additional Docker Compose files for various service categories. You can use these files standalone or combine them with the main `docker-compose.yml`.

## Available Configurations

### 1. Media Services (`docker-compose.media.yml`)
Media server solutions for streaming your content:
- **Plex**: Popular media server with client apps for all platforms
- **Jellyfin**: Open-source alternative to Plex, completely free
- **Emby**: Another media server option with premium features

**Usage:**
```bash
docker compose -f docker-compose.yml -f examples/docker-compose.media.yml up -d
```

### 2. Download Management (`docker-compose.downloads.yml`)
Automated media management and download tools:
- **Sonarr**: TV show automation and management
- **Radarr**: Movie automation and management
- **Lidarr**: Music automation and management
- **Prowlarr**: Indexer manager for *arr apps
- **qBittorrent**: Torrent download client with web UI

**Usage:**
```bash
docker compose -f docker-compose.yml -f examples/docker-compose.downloads.yml up -d
```

### 3. Monitoring Services (`docker-compose.monitoring.yml`)
Monitor your server's health and performance:
- **Grafana**: Beautiful dashboards for metrics visualization
- **Prometheus**: Metrics collection and storage (requires prometheus.yml config)
- **Uptime Kuma**: Website and service uptime monitoring
- **Netdata**: Real-time performance monitoring
- **Scrutiny**: S.M.A.R.T. hard drive monitoring (requires device configuration)

**Important Notes:**
- **Prometheus**: Copy `examples/prometheus.yml` to your data directory before starting
- **Scrutiny**: Edit the compose file to match your actual storage devices (use `lsblk` to see them)

**Usage:**
```bash
# Copy prometheus config first
cp examples/prometheus.yml ${DATA_PATH:-./data}/prometheus.yml
docker compose -f docker-compose.yml -f examples/docker-compose.monitoring.yml up -d
```

### 4. Network & Security (`docker-compose.network.yml`)
Network management and security services:
- **Nginx Proxy Manager**: Easy reverse proxy with Let's Encrypt
- **Traefik**: Modern reverse proxy with automatic SSL (requires acme.json setup)
- **Pi-hole**: Network-wide ad blocking and DNS
- **WireGuard**: Secure VPN for remote access

**Important Notes:**
- **Traefik**: Before starting, create acme.json: `touch acme.json && chmod 600 acme.json` in your data directory

**Usage:**
```bash
docker compose -f docker-compose.yml -f examples/docker-compose.network.yml up -d
```

## Combining Multiple Files

You can combine any number of these files:

```bash
# All services
docker compose \
  -f docker-compose.yml \
  -f examples/docker-compose.media.yml \
  -f examples/docker-compose.downloads.yml \
  -f examples/docker-compose.monitoring.yml \
  -f examples/docker-compose.network.yml \
  up -d

# Just media and downloads
docker compose \
  -f docker-compose.yml \
  -f examples/docker-compose.media.yml \
  -f examples/docker-compose.downloads.yml \
  up -d
```

## Creating Custom Configurations

Feel free to:
1. Copy any of these files as a template
2. Remove services you don't need
3. Add services from other files
4. Create your own custom compose files

## Port Reference

Quick reference for default ports (can be changed in `.env`):

### Core Services
- Portainer: 9000, 9443
- Heimdall: 8080

### Media
- Plex: 32400
- Jellyfin: 8096
- Emby: 8097

### Downloads
- Sonarr: 8989
- Radarr: 7878
- Lidarr: 8686
- Prowlarr: 9696
- qBittorrent: 8080

### Monitoring
- Grafana: 3000
- Prometheus: 9090
- Uptime Kuma: 3001
- Netdata: 19999
- Scrutiny: 8090

### Network
- Nginx Proxy Manager: 80, 443, 81
- Pi-hole: 53, 8053
- WireGuard: 51820
- Traefik: 80, 443, 8080

## Notes

- All services use environment variables from `.env`
- Adjust paths to match your Unraid shares
- Some services require additional configuration after first launch
- Check individual service documentation for detailed setup
