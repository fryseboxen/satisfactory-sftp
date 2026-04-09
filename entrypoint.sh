#!/bin/bash
set -e

# 1. Setup Password
USER_PASS=${SFTP_PASSWORD:-changeme}
echo "steam:$USER_PASS" | chpasswd

# 2. Setup SSH Directory
mkdir -p /var/run/sshd
chmod 0755 /var/run/sshd

# 3. Start SSH daemon (using the direct path to prevent service errors)
/usr/sbin/sshd

# 4. Launch the base image's initialization
# This handles the SteamCMD download and the Satisfactory server start
exec /init
