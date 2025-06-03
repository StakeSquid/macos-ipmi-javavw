FROM --platform=linux/amd64 debian:bullseye

ENV DEBIAN_FRONTEND=noninteractive
ENV JAVA_VERSION=jre1.8.0_451
ENV JAVA_HOME=/usr/java/${JAVA_VERSION}
ENV PATH="${JAVA_HOME}/bin:${PATH}"

# Install required packages
RUN apt-get update && apt-get install -y \
    xfce4 xfce4-goodies tightvncserver dbus-x11 \
    curl wget git python3 python3-pip \
    libxext6 libxi6 libxtst6 libxrender1 libxt6 libxrandr2 \
    libasound2 libfreetype6 ca-certificates xdg-utils \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Copy Oracle Java
RUN mkdir -p /usr/java
COPY jre-8u451-linux-x64.tar.gz /usr/java/

RUN cd /usr/java && \
    tar -xzf jre-8u451-linux-x64.tar.gz && \
    rm jre-8u451-linux-x64.tar.gz && \
    ln -s ${JAVA_HOME}/bin/javaws /usr/bin/javaws

# Setup VNC password and xstartup
RUN mkdir -p /root/.vnc && \
    echo "vncpassword" | vncpasswd -f > /root/.vnc/passwd && \
    chmod 600 /root/.vnc/passwd && \
    echo '#!/bin/sh\nxrdb $HOME/.Xresources\nstartxfce4 &' > /root/.vnc/xstartup && \
    chmod +x /root/.vnc/xstartup

# Install noVNC
RUN git clone https://github.com/novnc/noVNC.git /opt/novnc && \
    git clone https://github.com/novnc/websockify /opt/novnc/utils/websockify && \
    ln -s /opt/novnc/vnc.html /opt/novnc/index.html

# Add startup script
COPY start.sh /start.sh
RUN chmod +x /start.sh

EXPOSE 6080
CMD ["/start.sh"]