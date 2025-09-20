# SQL Server Setup for macOS

Quick setup for SQL Server on macOS using Homebrew and Docker.

## Requirements

- macOS 10.14+
- 4GB RAM minimum
- 2GB free disk space

## Quick Setup

Run the setup script:

```bash
chmod +x setup-sqlserver.sh && ./setup-sqlserver.sh
```

## Connection Info

After setup:
- **Server**: `localhost,1433`
- **Username**: `sa`
- **Password**: `YourStrong@Passw0rd`

## Manual Commands

```bash
# Check container status
docker ps

# Stop/Start SQL Server
docker stop sqlserver
docker start sqlserver

# Connect via sqlcmd
sqlcmd -S localhost,1433 -U sa -P 'YourStrong@Passw0rd'
```