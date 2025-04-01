# LocalChat

LocalChat is a self-hosted project designed to provide a private and customizable search engine instance using SearxNG.

## Project Structure
LocalChat/
├── compose.yaml                # Docker Compose configuration for the project
├── README.md                   # Project documentation
└── searxng-instance/          # Directory containing SearxNG configuration and instance files
    └── searxng/
        ├── limiter.toml       # Configuration for rate limiting
        ├── settings.yml       # Main settings for SearxNG
        ├── settings.yml.new   # Template for new settings
        ├── uwsgi.ini         # uWSGI configuration for SearxNG
        └── uwsgi.ini.new     # Template for new uWSGI configuration

## Getting Started

### Prerequisites

- Docker and Docker Compose installed on your system.

### Setup and Run

1. Clone the repository:
   ```bash
   git clone <repository-url>
   cd LocalChat
   ```

2. Configure SearxNG:
   - Edit `searxng-instance/searxng/settings.yml` to customize your SearxNG instance.
   - Optionally, adjust `limiter.toml` and `uwsgi.ini` as needed.

3. Start the services using Docker Compose:
   ```bash
   docker-compose -f compose.yaml up -d
   ```

4. Access your SearxNG instance in your browser at `http://localhost:8080` (or the port specified in your `compose.yaml`).

## Configuration

- **Rate Limiting**: Modify `searxng-instance/searxng/limiter.toml` to adjust rate-limiting rules.
- **Settings**: Use `settings.yml` to configure search engine preferences, themes, and other options.
- **uWSGI**: Update `uwsgi.ini` for advanced server configurations.

## Troubleshooting

If you encounter issues, check the logs:
```bash
docker-compose -f compose.yaml logs
```

Ensure that the `settings.yml` and `uwsgi.ini` files are correctly configured.

## Contributing

Contributions are welcome! Feel free to submit issues or pull requests to improve this project.

## License

This project is licensed under the MIT License.

## Acknowledgments

- [SearxNG](https://github.com/searxng/searxng) - The open-source search engine powering this project.
