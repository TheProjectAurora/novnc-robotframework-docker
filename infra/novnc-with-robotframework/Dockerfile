FROM dorowu/ubuntu-desktop-lxde-vnc:focal

###########################################################################
# NoVNC Setup + Microsoft Visual Studio Code installation with plugins
ENV DEBIAN_FRONTEND=noninteractive DONT_PROMPT_WSL_INSTALL=true
RUN set -xe \
    && wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg \
    && install -o root -g root -m 644 packages.microsoft.gpg /etc/apt/trusted.gpg.d/ \
    && sh -c 'echo "deb [arch=amd64 signed-by=/etc/apt/trusted.gpg.d/packages.microsoft.gpg] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list' \
    && apt -qq update && apt dist-upgrade -y \
    && apt install -qq --no-install-recommends --allow-unauthenticated -y \
      git \ 
      code \
      npm  \
      unzip \
      nano \
    && apt clean && rm -rf /var/lib/apt/lists/* 
# GENERATE SSL CERT
COPY novnc_openssl.cnf /etc/nginx/ssl/novnc_openssl.cnf
RUN set -xe \
    && openssl req -x509 -config /etc/nginx/ssl/novnc_openssl.cnf -nodes -days 365 -newkey rsa:2048 -keyout /etc/nginx/ssl/nginx.key -out /etc/nginx/ssl/nginx.crt
EXPOSE 443
# ADD coder USER
# SOURCE: https://github.com/eficode-academy/code-server/blob/master/docker-images/Dockerfile
# Set password and other coder user things are handled with noVNC environment parameters in docker-compose.yaml
RUN set -xe \
    && adduser --gecos '' --disabled-password coder \
    && set -xe  && usermod -a -G sudo coder
USER coder
ENV HOME=/home/coder
WORKDIR /home/coder
# TODO: Create loop that install extensions
RUN set -xe && \
    code --verbose --log debug --install-extension redhat.vscode-yaml && \
    code --verbose --log debug --install-extension TomiTurtiainen.rf-intellisense
#TODO: NoVNC binary should be executed under root, under coder it not work
USER root

###########################################################################
# TOOLING
#####
# INSTALL: https://robotframework.org/
RUN set -xe \
    && apt -qq update \
    && apt install -qq --no-install-recommends --allow-unauthenticated -y \
      python3 \
      python3-pip \
    && apt clean && rm -rf /var/lib/apt/lists/*  \
    && pip3 install --no-cache-dir \
      robotframework
#####
# INSTALL: https://github.com/robotframework/Selenium2Library + Required browser drivers
RUN pip3 install --no-cache-dir \
      invoke \
      rellu \
      docutils \
      robotframework-seleniumlibrary \
  # Firefox geckodriver: https://github.com/mozilla/geckodriver/releases
    && wget -q https://github.com/mozilla/geckodriver/releases/download/v0.29.0/geckodriver-v0.29.0-linux64.tar.gz \
    && tar -C /bin -xvf geckodriver-v*-linux64.tar.gz && rm -f geckodriver-v*-linux64.tar.gz\
  # Chrome driver: https://chromedriver.chromium.org/downloads
    && wget -q https://chromedriver.storage.googleapis.com/88.0.4324.96/chromedriver_linux64.zip \
    && unzip chromedriver_linux64.zip -d /bin && rm -f chromedriver_linux64.zip
#####
# INSTALL: https://github.com/MarketSquare/robotframework-browser
RUN set -xe \
    && curl -sL https://deb.nodesource.com/setup_14.x | sudo bash - \
    && apt -qq update \
    && apt install -qq --no-install-recommends --allow-unauthenticated -y \
      nodejs \
      # webkit require also
      libgstreamer-plugins-bad1.0-0 \
      libenchant1c2a \
      libgles2 \
    && apt clean && rm -rf /var/lib/apt/lists/* \
    && pip3 install --no-cache-dir \
      robotframework-browser \
    && rfbrowser init