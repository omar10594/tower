# Getting Started with Tower

This guide will help you get your home server up and running quickly.

## Prerequisites

Before you begin, ensure you have:

1. **Unraid Server** (or any Linux host with Docker)
2. **Docker** installed and running
3. **Docker Compose** (v2 or later)
4. **Git** (to clone this repository)
5. **Portainer** (optional, but recommended)

## Step-by-Step Setup

### 1. Clone the Repository

SSH into your Unraid server and navigate to your preferred location:

```bash
cd /mnt/user/appdata  # Or your preferred location
git clone https://github.com/omar10594/tower.git
cd tower
```

### 2. Run Initial Setup

The setup script will help you get started:

```bash
./scripts/setup.sh
```

This creates your `.env` file and necessary directories.

### 3. Configure Environment Variables

Edit the `.env` file with your settings:

```bash
nano .env
```

**Important settings to configure:**

```env
# Your timezone (find yours at: https://en.wikipedia.org/wiki/List_of_tz_database_time_zones)
TZ=America/New_York

# Get these by running 'id' in your Unraid terminal
PUID=99    # Usually 99 for Unraid
PGID=100   # Usually 100 for Unraid

# Adjust these paths to match your Unraid shares
DATA_PATH=/mnt/user/appdata/tower
MEDIA_PATH=/mnt/user/media
DOWNLOADS_PATH=/mnt/user/downloads

# Set a port for Portainer (if not already installed)
PORTAINER_PORT=9000
```

**Pro Tip:** On Unraid, run `id` to get your PUID and PGID. Usually it's:
- PUID: 99
- PGID: 100

### 4. Review the Main Compose File

Take a look at what services will be started:

```bash
cat docker-compose.yml
```

The default configuration includes:
- **Portainer**: Container management (port 9000)
- **Heimdall**: Application dashboard (port 8080)
- **Watchtower**: Automatic updates

### 5. Start Core Services

Start the basic services:

```bash
docker compose up -d
```

Wait a few moments for containers to start, then check status:

```bash
docker compose ps
```

### 6. Access Your Services

Open your web browser and navigate to:

- **Portainer**: `http://your-server-ip:9000`
  - Create admin account on first login
  - This is your container management interface

- **Heimdall**: `http://your-server-ip:8080`
  - Configure links to all your services
  - Acts as your server dashboard

### 7. Add More Services (Optional)

Choose from the example configurations:

#### Option A: Add Media Services
```bash
docker compose -f docker-compose.yml -f examples/docker-compose.media.yml up -d
```

#### Option B: Add Download Management
```bash
docker compose -f docker-compose.yml -f examples/docker-compose.downloads.yml up -d
```

#### Option C: Add Monitoring
```bash
docker compose -f docker-compose.yml -f examples/docker-compose.monitoring.yml up -d
```

#### Option D: Add Multiple Categories
```bash
docker compose \
  -f docker-compose.yml \
  -f examples/docker-compose.media.yml \
  -f examples/docker-compose.downloads.yml \
  up -d
```

## Using with Portainer

### Method 1: Deploy from Git Repository

1. Open Portainer (http://your-server-ip:9000)
2. Go to **Stacks** → **Add stack**
3. Select **Repository** tab
4. Fill in:
   - **Repository URL**: `https://github.com/omar10594/tower`
   - **Compose path**: `docker-compose.yml`
   - **Branch**: `main`
5. Add environment variables from your `.env` file
6. Click **Deploy the stack**

### Method 2: Copy/Paste Compose File

1. Open Portainer
2. Go to **Stacks** → **Add stack**
3. Select **Web editor** tab
4. Copy the contents of `docker-compose.yml`
5. Paste into the editor
6. Add environment variables
7. Click **Deploy the stack**

## Next Steps

### Configure Individual Services

Each service needs initial configuration:

1. **Portainer** (9000): Set admin password
2. **Heimdall** (8080): Add application links
3. **Plex** (32400): Claim server and add libraries
4. **Sonarr/Radarr**: Configure download clients and indexers
5. **Pi-hole** (8053): Set as your DNS server

### Set Up Reverse Proxy (Recommended)

For easier access with domain names:

1. Deploy Nginx Proxy Manager:
   ```bash
   docker compose -f examples/docker-compose.network.yml up -d nginx-proxy-manager
   ```

2. Access at `http://your-server-ip:81`
   - Default login: `admin@example.com` / `changeme`
   - Change these immediately!

3. Add proxy hosts for each service
4. Enable SSL certificates with Let's Encrypt

### Regular Maintenance

Schedule regular maintenance tasks:

1. **Backups** (recommended weekly):
   ```bash
   ./scripts/backup.sh
   ```

2. **Updates** (check monthly):
   ```bash
   ./scripts/update.sh
   docker compose up -d --force-recreate
   ```

3. **Monitor Resources**: Use Netdata or Grafana

## Common First-Time Issues

### Port Already in Use

**Problem**: Error like "port 9000 is already allocated"

**Solution**: Change the port in `.env`:
```env
PORTAINER_PORT=9001
```

### Permission Errors

**Problem**: Containers can't write to directories

**Solution**: Check PUID and PGID in `.env` match your Unraid user:
```bash
id  # Run this to see your IDs
```

### Can't Access Services

**Problem**: Services don't respond

**Solutions**:
1. Check if container is running: `docker compose ps`
2. Check logs: `docker compose logs [service-name]`
3. Verify ports aren't blocked by firewall
4. Ensure you're using the correct server IP

### Watchtower Updates Everything Automatically

**Problem**: Watchtower updates containers without warning

**Solution**: Adjust Watchtower configuration or disable it:
```bash
docker compose stop watchtower
```

## Getting Help

- Check the main [README.md](README.md) for detailed documentation
- Review logs: `docker compose logs -f [service-name]`
- Check each service's official documentation
- Visit the Unraid forums

## Quick Reference Commands

```bash
# Start all services
docker compose up -d

# Stop all services
docker compose down

# View logs
docker compose logs -f

# Update containers
docker compose pull && docker compose up -d

# Check status
docker compose ps

# Restart a service
docker compose restart [service-name]

# Remove everything (careful!)
docker compose down -v
```

---

**Congratulations!** Your home server is now set up. Explore the example configurations and customize to your needs.
