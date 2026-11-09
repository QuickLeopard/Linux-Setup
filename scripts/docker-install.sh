#!/usr/bin/env bash
set -euo pipefail

# 1. Privilege check
if [[ $EUID -ne 0 ]]; then
   echo "Error: This script must be run as root or with sudo."
   exit 1
fi

# Determine DNF version (DNF5 vs DNF4)
# Rocky Linux 10 transitions to DNF5; this ensures compatibility across versions.
if command -v dnf5 &> /dev/null; then
    DNF="dnf5"
    PLUGINS_PKG="dnf5-plugins"
else
    DNF="dnf"
    PLUGINS_PKG="dnf-plugins-core"
fi

# 2. Clean up conflicting packages
echo "==> Removing conflicting packages..."
$DNF remove -y docker \
                  docker-client \
                  docker-client-latest \
                  docker-common \
                  docker-latest \
                  docker-latest-logrotate \
                  docker-logrotate \
                  docker-engine \
                  podman \
                  runc || true

# 3. Install dependencies
echo "==> Installing dependencies..."
$DNF install -y $PLUGINS_PKG

# 4. Add Docker repository
echo "==> Adding Docker repository..."
# Rocky Linux is RHEL-compatible. Docker officially recommends the 'centos' repo for Rocky/Alma.
# If your environment strictly requires the 'rhel' repo, replace 'centos' with 'rhel' in the URL below.
$DNF config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo

# 5. Install Docker Engine and Compose Plugin
echo "==> Installing Docker Engine, Containerd, Buildx, and Compose..."
$DNF install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin --allowerasing

# 6. Start and enable Docker
echo "==> Starting and enabling Docker daemon..."
systemctl enable --now docker

# 7. Verification
echo "==> Verifying Docker Engine..."
docker run --rm hello-world

echo "==> Verifying Docker Compose Plugin..."
docker compose version

# 8. Optional: Non-root user configuration
if [[ -n "${SUDO_USER:-}" && "${SUDO_USER}" != "root" ]]; then
    echo "==> Adding user '${SUDO_USER}' to the 'docker' group..."
    usermod -aG docker "${SUDO_USER}"
    echo "Note: Run 'newgrp docker' or log out and back in to apply group changes."
fi

echo "==> Installation complete."
