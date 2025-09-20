#!/bin/bash

# === Step 0: Install Homebrew if not installed ===
if ! command -v brew &> /dev/null
then
    echo "[INFO] Homebrew not found. Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
    echo "[INFO] Homebrew already installed."
fi

# === Step 1: Install Docker Desktop ===
if ! ls /Applications | grep -q "Docker.app"; then
    echo "[INFO] Installing Docker Desktop..."
    brew install --cask docker
else
    echo "[INFO] Docker Desktop already installed."
fi

# === Step 2: Install Azure Data Studio ===
if [ ! -d "/Applications/Azure Data Studio.app" ]; then
    echo "[INFO] Installing Azure Data Studio..."
    brew install --cask azure-data-studio
else
    echo "[INFO] Azure Data Studio already installed."
fi

# === Step 3: Ensure Docker daemon is running ===
echo "[INFO] Checking if Docker daemon is running..."
if ! docker info &> /dev/null; then
    echo "[WARNING] Docker is not running. Starting Docker Desktop..."
    open -a Docker

    # Wait until Docker daemon is available
    until docker info &> /dev/null; do
        sleep 5
        echo "[INFO] Waiting for Docker to start..."
    done
fi
echo "[INFO] Docker is running."

# === Step 4: Pull SQL Server image ===
echo "[INFO] Pulling SQL Server 2022 image..."
docker pull mcr.microsoft.com/mssql/server:2022-latest

# === Step 5: Run SQL Server container ===
echo "[INFO] Starting SQL Server container..."
docker rm -f sqlserver &> /dev/null
docker run -e "ACCEPT_EULA=Y" -e "MSSQL_SA_PASSWORD=YourStrong@Passw0rd" \
   -p 1433:1433 --name sqlserver \
   -d mcr.microsoft.com/mssql/server:2022-latest

# === Step 6: Verify container ===
echo "[INFO] Checking running containers..."
docker ps | grep sqlserver

echo "======================================"
echo " - SQL Server is running on localhost:1433"
echo "   + Username: sa"
echo "   + Password: YourStrong@Passw0rd"
echo "   + GUI: Open Azure Data Studio and connect"
echo "======================================"
