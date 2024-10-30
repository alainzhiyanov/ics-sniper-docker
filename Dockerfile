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
 && rm -rf /var/lib/apt/lists/* \
 && touch /etc/network/interfaces \
 && chmod +x /ENTRYPOINT.sh

# Disable SSL Verification for Git
RUN git config --global http.sslVerify false && \
    git clone https://github.com/alainzhiyanov/mininet.git /mininet && \
    cd /mininet && \
    util/install.sh -a

# Install Python packages
RUN pip3 install pymodbus==2.4.0 serial pyserial-asyncio

EXPOSE 6633 6653 6640

ENTRYPOINT ["/ENTRYPOINT.sh"]
