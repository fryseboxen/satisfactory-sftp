FROM wolveix/satisfactory-server:latest

USER root
# Install SFTP software
RUN apt-get update && apt-get install -y openssh-server && \
    mkdir /var/run/sshd && \
    # Allow the 'steam' user to use SFTP
    sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin no/' /etc/ssh/sshd_config

# Tell the container to use our custom start-up script
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]