FROM dorowu/ubuntu-desktop-lxde-vnc:focal

ENV DEBIAN_FRONTEND=noninteractive DONT_PROMPT_WSL_INSTALL=true

# ADD VSCODE STUFF AND INSTALL IT AND OTHER REQUIRED STUFF
RUN wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg \
    && install -o root -g root -m 644 packages.microsoft.gpg /etc/apt/trusted.gpg.d/ \
    && sh -c 'echo "deb [arch=amd64 signed-by=/etc/apt/trusted.gpg.d/packages.microsoft.gpg] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list' \
    && apt -qq update && apt dist-upgrade -y  && apt install -qq --no-install-recommends --allow-unauthenticated -y \
    python3-pip \
    git \ 
    code \
    npm  \
    unzip \
    && apt clean && rm -rf /var/lib/apt/lists/* 

RUN pip3 install --no-cache-dir \
  invoke \
  rellu \
  docutils \
  robotframework \
  robotframework-seleniumlibrary \
  && wget -q https://github.com/mozilla/geckodriver/releases/download/v0.27.0/geckodriver-v0.27.0-linux64.tar.gz \
  && tar -C /bin -xvf geckodriver-v*-linux64.tar.gz && rm -f geckodriver-v*-linux64.tar.gz\
  && wget -q https://chromedriver.storage.googleapis.com/86.0.4240.22/chromedriver_linux64.zip \
  && unzip chromedriver_linux64.zip -d /bin && rm -f chromedriver_linux64.zip


EXPOSE 443

# ADD coder USER
# SOURCE: https://github.com/eficode-academy/code-server/blob/master/docker-images/Dockerfile
RUN adduser --gecos '' --disabled-password coder
RUN usermod -a -G sudo coder
USER coder
ENV HOME=/home/coder
WORKDIR /home/coder
# Set password and other coder user things are handled with noVNC environment parameters in docker-compose.yaml


# TODO: Create loop that install extensions
RUN code --verbose --log debug --install-extension redhat.vscode-yaml && \
    code --verbose --log debug --install-extension TomiTurtiainen.rf-intellisense
    

#TODO: NoVNC binary should be executed under root, under coder it not work
USER root