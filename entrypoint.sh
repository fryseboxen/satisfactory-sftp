#!/bin/bash
set -e  # Exit immediately if any command fails

# 1. Setup Password
USER_PASS=${SFTP_PASSWORD:-changeme}
echo "steam:$USER_PASS" | chpasswd

# 2. Fix SSH Directory (Critical for stability)
# Sometimes Docker wipes this folder on restart; creating it here prevents crashes.
mkdir -p /var/run/sshd
chmod 0755 /var/run/sshd

# 3. Start SSH in background
service ssh start

# 4. Launch Game Server
# 'exec' ensures the game handles shutdown signals properly to save your world.
exec /init
