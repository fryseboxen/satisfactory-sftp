#!/bin/bash
# If you forgot to set a password in Flux, it defaults to 'changeme'
USER_PASS=${SFTP_PASSWORD:-changeme}

# Apply the password to the 'steam' user internally
echo "steam:$USER_PASS" | chpasswd

# Start the SFTP service
/usr/sbin/sshd
# Start the Satisfactory Game
/init