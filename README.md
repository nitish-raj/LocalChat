<div align="center">

# 🤖 LocalChat

**A Complete Self-Hosted AI Chat Platform with Integrated Search & Monitoring**

[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)
[![Docker](https://img.shields.io/badge/Docker-Compose-blue.svg)](https://docs.docker.com/compose/)
[![SearxNG](https://img.shields.io/badge/Search-SearxNG-green.svg)](https://github.com/searxng/searxng)
[![Open WebUI](https://img.shields.io/badge/UI-Open%20WebUI-orange.svg)](https://github.com/open-webui/open-webui)

*Privacy-focused, locally-hosted AI chat with powerful search capabilities and comprehensive monitoring*

</div>

## ✨ Features

- **🤖 AI Chat Interface**: Modern web UI powered by Open WebUI for seamless AI interactions
- **🔍 Integrated Search**: Private SearxNG instance for web search without tracking
- **🧠 Local AI Models**: Run AI models locally using Ollama with GPU acceleration support
- **📊 Comprehensive Monitoring**: Built-in Grafana dashboards, Prometheus metrics, and Loki logging
- **🔒 Privacy-First**: All data stays on your infrastructure - no external API calls required
- **🚀 Easy Deployment**: One-command Docker Compose setup with automatic updates
- **📄 Document Processing**: Apache Tika integration for document analysis and processing
- **🔧 Extensible**: Pipeline support for custom AI workflows and integrations
- **🌐 Reverse Proxy**: Caddy server with automatic HTTPS and security headers
- **💾 Vector Database**: Qdrant for advanced AI capabilities and embeddings

## 🏗️ Architecture

LocalChat consists of multiple integrated services:

```
┌─────────────────┐    ┌─────────────────┐    ┌─────────────────┐
│   Open WebUI    │    │     Ollama      │    │    SearxNG      │
│   (Port 3000)   │◄──►│  (Port 11434)   │    │   (Port 8080)   │
└─────────────────┘    └─────────────────┘    └─────────────────┘
         │                       │                       │
         └───────────────────────┼───────────────────────┘
                                 │
┌─────────────────┐    ┌─────────▼─────────┐    ┌─────────────────┐
│     Caddy       │    │      Redis        │    │   Apache Tika   │
│  (Ports 80/443) │    │   (Cache/Queue)   │    │   (Port 9998)   │
└─────────────────┘    └───────────────────┘    └─────────────────┘
         │                       │                       │
         └───────────────────────┼───────────────────────┘
                                 │
┌─────────────────┐    ┌─────────▼─────────┐    ┌─────────────────┐
│    Grafana      │    │    Prometheus     │    │      Loki       │
│   (Port 3001)   │◄──►│   (Port 9090)     │◄──►│   (Port 3100)   │
└─────────────────┘    └───────────────────┘    └─────────────────┘
```

## 📁 Project Structure

```
LocalChat/
├── compose.yaml                    # Main Docker Compose configuration
├── update-and-start.sh            # Automated update and startup script
├── Caddyfile                      # Reverse proxy configuration
├── LICENSE                        # Apache 2.0 License
├── README.md                      # This file
├── searxng/                       # SearxNG search engine configuration
│   ├── settings.yml               # Main SearxNG settings
│   ├── limiter.toml              # Rate limiting configuration
│   ├── uwsgi.ini                 # uWSGI server configuration
│   └── favicons.toml             # Search engine favicons
├── grafana-provisioning/          # Grafana dashboards and datasources
│   ├── dashboards/               # Pre-configured monitoring dashboards
│   └── datasources/              # Prometheus and Loki datasource configs
├── loki-config/                   # Loki logging configuration
│   └── local-config.yaml
└── prometheus/                    # Prometheus monitoring configuration
    └── prometheus.yml
```

## 🚀 Quick Start

### Prerequisites

- **Docker & Docker Compose**: Latest versions recommended
- **Hardware**:
  - Minimum: 4GB RAM, 2 CPU cores
  - Recommended: 8GB+ RAM, 4+ CPU cores
  - Optional: NVIDIA GPU for accelerated AI inference

### Installation

1. **Clone the repository**:
   ```bash
   git clone https://github.com/your-username/LocalChat.git
   cd LocalChat
   ```

2. **Configure environment variables** (optional):
   ```bash
   # Copy and edit environment files as needed
   cp searxng/.env.example searxng/.env
   # Edit configuration files in searxng/, grafana-provisioning/, etc.
   ```

3. **Start all services**:
   ```bash
   # Quick start
   docker compose up -d
   
   # Or use the update script for latest images
   ./update-and-start.sh
   ```

4. **Access your services**:
   - **AI Chat Interface**: http://localhost:3000
   - **Search Engine**: http://localhost:8080
   - **Monitoring Dashboard**: http://localhost:3001
   - **Metrics**: http://localhost:9090

### First-Time Setup

1. **Download AI Models** (via Ollama):
   ```bash
   # Access Ollama container
   docker exec -it ollama ollama pull llama2
   docker exec -it ollama ollama pull codellama
   ```

2. **Configure Open WebUI**:
   - Navigate to http://localhost:3000
   - Create your admin account
   - Connect to local Ollama instance
   - Configure search integration with SearxNG

## ⚙️ Configuration

### SearxNG Search Engine
- **Settings**: Edit [`searxng/settings.yml`](searxng/settings.yml) for search engines, themes, and privacy settings
- **Rate Limiting**: Modify [`searxng/limiter.toml`](searxng/limiter.toml) for request throttling
- **Server Config**: Adjust [`searxng/uwsgi.ini`](searxng/uwsgi.ini) for performance tuning

### AI Models (Ollama)
```bash
# List available models
docker exec -it ollama ollama list

# Pull specific models
docker exec -it ollama ollama pull mistral
docker exec -it ollama ollama pull codellama:13b

# Remove models
docker exec -it ollama ollama rm model-name
```

### Monitoring & Logging
- **Grafana**: Access dashboards at http://localhost:3001 (admin/admin)
- **Prometheus**: Metrics available at http://localhost:9090
- **Loki**: Centralized logging with automatic log aggregation

### Reverse Proxy (Caddy)
- **HTTPS**: Automatic certificate management
- **Security**: Pre-configured security headers and CSP
- **Custom Domains**: Edit [`Caddyfile`](Caddyfile) for custom domain setup

## 🔧 Advanced Usage

### GPU Acceleration
The compose file includes NVIDIA GPU support. Ensure you have:
- NVIDIA Docker runtime installed
- Compatible GPU drivers

### Custom Pipelines
Add custom AI workflows using the pipelines service:
```bash
# Access pipelines container
docker exec -it pipelines /bin/bash
```

### Backup & Restore
```bash
# Backup volumes
docker run --rm -v localchat_ollama:/data -v $(pwd):/backup alpine tar czf /backup/ollama-backup.tar.gz -C /data .

# Restore volumes
docker run --rm -v localchat_ollama:/data -v $(pwd):/backup alpine tar xzf /backup/ollama-backup.tar.gz -C /data
```

## 📊 Monitoring

LocalChat includes comprehensive monitoring out of the box:

- **System Metrics**: CPU, memory, disk usage via cAdvisor
- **Application Logs**: Centralized logging with Loki
- **Custom Dashboards**: Pre-built Grafana dashboards for all services
- **Alerting**: Configure alerts for system health and performance

## 🛠️ Troubleshooting

### Common Issues

1. **Services won't start**:
   ```bash
   # Check logs
   docker compose logs
   
   # Restart specific service
   docker compose restart service-name
   ```

2. **GPU not detected**:
   ```bash
   # Verify NVIDIA runtime
   docker run --rm --gpus all nvidia/cuda:11.0-base nvidia-smi
   ```

3. **Search not working**:
   ```bash
   # Check SearxNG logs
   docker compose logs searxng
   
   # Restart SearxNG
   docker compose restart searxng
   ```

4. **Performance issues**:
   - Increase Docker memory limits
   - Check available disk space
   - Monitor resource usage in Grafana

### Getting Help

- **Issues**: Report bugs and feature requests on [GitHub Issues](https://github.com/your-username/LocalChat/issues)
- **Discussions**: Join community discussions on [GitHub Discussions](https://github.com/your-username/LocalChat/discussions)
- **Documentation**: Check the [Wiki](https://github.com/your-username/LocalChat/wiki) for detailed guides

## 🤝 Contributing

We welcome contributions! Please see our [Contributing Guidelines](CONTRIBUTING.md) for details.

### Development Setup

1. Fork the repository
2. Create a feature branch: `git checkout -b feature-name`
3. Make your changes and test thoroughly
4. Submit a pull request with a clear description

### Areas for Contribution

- 🐛 Bug fixes and performance improvements
- 📚 Documentation and tutorials
- 🎨 UI/UX enhancements
- 🔧 New integrations and features
- 🧪 Testing and quality assurance

## 📄 License

This project is licensed under the Apache License 2.0 - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

LocalChat is built on the shoulders of amazing open-source projects:

- **[Open WebUI](https://github.com/open-webui/open-webui)** - Modern AI chat interface
- **[Ollama](https://github.com/ollama/ollama)** - Local AI model runtime
- **[SearxNG](https://github.com/searxng/searxng)** - Privacy-respecting search engine
- **[Grafana](https://github.com/grafana/grafana)** - Monitoring and observability
- **[Prometheus](https://github.com/prometheus/prometheus)** - Metrics collection
- **[Loki](https://github.com/grafana/loki)** - Log aggregation
- **[Caddy](https://github.com/caddyserver/caddy)** - Modern web server
- **[Qdrant](https://github.com/qdrant/qdrant)** - Vector database

## 🌟 Star History

If you find LocalChat useful, please consider giving it a star! ⭐

---

<div align="center">

**Made with ❤️ for the open-source community**

[Report Bug](https://github.com/your-username/LocalChat/issues) · [Request Feature](https://github.com/your-username/LocalChat/issues) · [Documentation](https://github.com/your-username/LocalChat/wiki)

</div>
