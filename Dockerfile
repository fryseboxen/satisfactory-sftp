FROM wolveix/satisfactory-server:latest

USER root

# Install SSH and clean up in one layer
RUN apt-get update && apt-get install -y openssh-server && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Fix SSH config for login
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config && \
    sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config

# Expose Game and SFTP ports
EXPOSE 7777/udp 7777/tcp 8888/tcp 22/tcp

# Copy and force permissions
COPY entrypoint.sh /entrypoint.sh
RUN chmod 755 /entrypoint.sh

# Explicitly use bash to launch the script to avoid Exit 127
ENTRYPOINT ["/bin/bash", "/entrypoint.sh"]
