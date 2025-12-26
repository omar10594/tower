# Tower - n8n with Cloudflare Tunnel

A simple Docker Compose setup to run [n8n](https://n8n.io/) (workflow automation tool) with a Cloudflare Tunnel for secure external access.

This setup is designed for use on an **Unraid** host, but can be adapted for other systems.

## 🚀 Quick Start

1. **Clone the repository**
   ```bash
   git clone https://github.com/omar10594/tower-n8n.git
   cd tower
   ```

2. **Configure environment variables**
   ```bash
   cp .env.example .env
   ```
   
   Edit `.env` and set your values:
   - `N8N_HOST`: Your n8n hostname
   - `WEBHOOK_URL`: Your public URL for webhooks (usually your Cloudflare Tunnel URL)
   - `TIMEZONE`: Your timezone (e.g., `America/New_York`)
   - `N8N_ENCRYPTION_KEY`: Generate a secure random string for encryption
   - `CF_TUNNEL_TOKEN`: Your Cloudflare Tunnel token

3. **Start the services**
   ```bash
   docker-compose up -d
   ```

4. **Access n8n**
   - Local: http://localhost:5678
   - External: Through your Cloudflare Tunnel URL

## 📋 Services

- **n8n**: Workflow automation tool running on port 5678
- **cloudflared**: Cloudflare Tunnel for secure external access

## 🔧 Configuration

### Cloudflare Tunnel Setup

1. Create a Cloudflare Tunnel in your Cloudflare dashboard
2. Configure the tunnel to point to `http://n8n:5678`
3. Copy the tunnel token and add it to your `.env` file

### n8n Encryption Key

Generate a secure encryption key:
```bash
openssl rand -base64 32
```

## 📦 Data Persistence

n8n data is persisted in `/mnt/user/appdata/n8n_data` on the Unraid host. This ensures your workflows and data are safely stored on the array.

To backup your workflows:

```bash
tar czf n8n-backup.tar.gz -C /mnt/user/appdata/n8n_data .
```

If you're not using Unraid, modify the volume path in [docker-compose.yml](docker-compose.yml) to match your preferred location.

## 🛑 Stopping Services

```bash
docker-compose down
```

To remove volumes as well:
```bash
docker-compose down -v
```

## 📝 License

This is a reference/template repository. Feel free to use it as a starting point for your own n8n deployments.

## 🤝 Contributing

This repository is intentionally kept simple. If you have improvements, feel free to fork and adapt it to your needs.
