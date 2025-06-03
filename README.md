# macOS IPMI Java Web Start Container

A Docker container that provides Java Web Start (javaws) functionality through a web browser interface, specifically designed for accessing IPMI console applications on macOS systems where Java Web Start is no longer natively supported.

## Features

- **Cross-platform Java Web Start**: Run legacy JNLP applications in a containerized Linux environment
- **Web-based Access**: Access through any modern web browser via noVNC
- **IPMI Console Support**: Specifically configured for server management console applications
- **Persistent Storage**: Mount local JNLP files for easy access
- **High Resolution**: Supports 1920x1080 desktop resolution

## Prerequisites

- Docker Desktop for Mac
- Docker Compose

## Quick Start

1. Clone this repository:
   ```bash
   git clone <repository-url>
   cd macos-ipmi-javavw
   ```

2. Create a `jnlp` directory and place your JNLP file:
   ```bash
   mkdir -p jnlp
   # Copy your JNLP file to jnlp/launch.jnlp
   ```

3. Start the container:
   ```bash
   docker-compose up -d
   ```

4. Access the desktop through your web browser:
   ```
   http://localhost:6080
   ```

5. Use the VNC password: `vncpassword`

## Usage

### Automatic JNLP Launch
If you place a JNLP file at `jnlp/launch.jnlp`, it will be automatically launched when the container starts.

### Manual JNLP Launch
1. Access the desktop at `http://localhost:6080`
2. Open a terminal in the XFCE desktop
3. Run: `javaws /data/your-file.jnlp`

### Custom Configuration
- **VNC Password**: Default is `vncpassword` - modify in Dockerfile if needed
- **Resolution**: Default is 1920x1080 - modify in `start.sh`
- **Ports**: Default web access on port 6080 - modify in `docker-compose.yml`

## Architecture

- **Base**: Debian Bullseye (Linux/AMD64)
- **Desktop**: XFCE4
- **Java**: Oracle JRE 8u451
- **VNC**: TightVNC Server
- **Web Interface**: noVNC

## File Structure

```
.
├── Dockerfile              # Container build configuration
├── docker-compose.yml     # Service orchestration
├── start.sh               # Container startup script
├── jre-8u451-linux-x64.tar.gz  # Oracle Java Runtime
└── jnlp/                  # Mount point for JNLP files
```

## Troubleshooting

### Java Web Start Issues
- Ensure JNLP files are properly formatted and accessible
- Check Java console output in the VNC session
- Verify network connectivity for downloading required JARs

### VNC Connection Issues
- Ensure port 6080 is not in use by another application
- Check Docker container logs: `docker-compose logs`
- Verify the container is running: `docker-compose ps`

### Performance Issues
- Increase Docker Desktop memory allocation
- Consider reducing VNC resolution in `start.sh`

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Submit a pull request

## Security Notice

This container runs with root privileges and includes a default VNC password. Use only in trusted environments and consider changing the default password for production use.