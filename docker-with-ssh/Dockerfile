FROM ubuntu:22.04

USER root
WORKDIR /root




COPY ENTRYPOINT.sh /

RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    dnsutils \
    sudo \
    git \
    ifupdown \
    iproute2 \
    iptables \
    iputils-ping \
    net-tools \
    openvswitch-switch \
    openvswitch-testcontroller \
    tcpdump \
    vim \
    x11-xserver-utils \
    xterm \
    lsb-release \
    openssh-server \
 && rm -rf /var/lib/apt/lists/* \
 && touch /etc/network/interfaces \
 && chmod +x /ENTRYPOINT.sh
 
# Create a user “sshuser” and group “sshgroup”
RUN groupadd sshgroup && useradd -ms /bin/bash -g sshgroup sshuser
# Create sshuser directory in home
RUN mkdir -p /home/sshuser/.ssh
# Copy the ssh public key in the authorized_keys file. The id_rsa.pub below is a public key file you get from ssh-keygen. They are under ~/.ssh directory by default.
COPY id_rsa.pub /home/sshuser/.ssh/authorized_keys
# change ownership of the key file. 
RUN chown sshuser:sshgroup /home/sshuser/.ssh/authorized_keys && chmod 600 /home/sshuser/.ssh/authorized_keys
# Start SSH service
RUN service ssh start

# Disable SSL Verification for Git
RUN git config --global http.sslVerify false && \
    git clone https://github.com/alainzhiyanov/mininet.git /mininet && \
    cd /mininet && \
    util/install.sh -a

# Install Python packages
RUN pip3 install pymodbus==2.4.0 serial pyserial-asyncio

EXPOSE 6633 6653 6640 22

ENTRYPOINT ["/ENTRYPOINT.sh"]
