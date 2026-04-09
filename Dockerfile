FROM wolveix/satisfactory-server:latest

USER root

# Install SFTP and clean up temporary files to keep the image stable
RUN apt-get update && apt-get install -y openssh-server && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin no/' /etc/ssh/sshd_config

# Expose Game and SFTP ports
EXPOSE 7777/udp 7777/tcp 8888/tcp 22/tcp

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
