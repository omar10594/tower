# Utility Scripts

This directory contains helper scripts to manage your Tower server.

## Available Scripts

### setup.sh
Initial setup script for your server environment.

**What it does:**
- Checks for Docker and Docker Compose installation
- Creates `.env` file from template if it doesn't exist
- Shows your current UID/GID for configuration
- Creates necessary data directories

**Usage:**
```bash
./scripts/setup.sh
```

**When to use:**
- First time setting up the repository
- After cloning to a new server
- When you need to recreate the data directory structure

---

### backup.sh
Backs up your Docker configurations and data.

**What it backs up:**
- `.env` file (with timestamp)
- `docker-compose.yml` (with timestamp)
- Entire data directory (compressed tar.gz)

**Usage:**
```bash
./scripts/backup.sh
```

**Optional environment variables:**
```bash
BACKUP_DIR=./my-backups ./scripts/backup.sh
```

**When to use:**
- Before making major configuration changes
- Before updating containers
- As part of a scheduled backup routine (e.g., cron job)

**Setting up automated backups:**
```bash
# Add to crontab for daily backups at 2 AM
0 2 * * * cd /path/to/tower && ./scripts/backup.sh
```

---

### update.sh
Updates Docker container images to their latest versions.

**What it does:**
- Pulls the latest images for all services in your compose files
- Shows which images were updated
- Provides instructions for applying updates

**Usage:**
```bash
./scripts/update.sh
```

**When to use:**
- When you want to manually update your containers
- Before running Watchtower if you want to review changes first
- As part of your maintenance routine

**Note:** This script only pulls images. To apply updates, you need to recreate the containers:
```bash
docker compose up -d --force-recreate
```

---

## Making Scripts Executable

If the scripts aren't executable, run:
```bash
chmod +x scripts/*.sh
```

## Creating Custom Scripts

You can create your own scripts in this directory. Some ideas:

### Health Check Script
```bash
#!/bin/bash
# Check if all containers are running
docker compose ps
```

### Log Viewer Script
```bash
#!/bin/bash
# View logs from all containers
docker compose logs -f
```

### Cleanup Script
```bash
#!/bin/bash
# Remove unused Docker resources
docker system prune -a
```

## Best Practices

1. **Always backup before updates**: Run `backup.sh` before making changes
2. **Test scripts**: Test scripts in a development environment first
3. **Review changes**: Check what the script will do before running it
4. **Keep scripts updated**: Update scripts as your configuration changes
5. **Version control**: Commit custom scripts to track changes

## Troubleshooting

### Permission Denied
If you get "Permission denied" errors:
```bash
chmod +x scripts/script-name.sh
```

### Docker Not Found
Ensure Docker is in your PATH:
```bash
which docker
```

### Script Fails
Check the script's output for error messages and ensure:
- You're running from the repository root
- Required files exist (docker-compose.yml, .env)
- Docker daemon is running
