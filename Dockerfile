FROM dpetersen/dev-container-base:v1.7
MAINTAINER Don Petersen <don@donpetersen.net>

RUN curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash - && \
    sudo apt-get install -y nodejs && \
# Yarn
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list && \
    sudo apt-get update && \
    sudo apt-get install yarn

# Chromedriver and Chrome for e2e tests, stolen from:
# https://hub.docker.com/r/robcherry/docker-chromedriver/~/dockerfile/
# Install Chrome WebDriver
RUN CHROMEDRIVER_VERSION=`curl -sS chromedriver.storage.googleapis.com/LATEST_RELEASE` && \
    sudo mkdir -p /opt/chromedriver-$CHROMEDRIVER_VERSION && \
    sudo chown dev /opt/chromedriver-$CHROMEDRIVER_VERSION && \
    curl -sS -o /tmp/chromedriver_linux64.zip http://chromedriver.storage.googleapis.com/$CHROMEDRIVER_VERSION/chromedriver_linux64.zip && \
    unzip -qq /tmp/chromedriver_linux64.zip -d /opt/chromedriver-$CHROMEDRIVER_VERSION && \
    rm /tmp/chromedriver_linux64.zip && \
    chmod +x /opt/chromedriver-$CHROMEDRIVER_VERSION/chromedriver && \
    sudo ln -fs /opt/chromedriver-$CHROMEDRIVER_VERSION/chromedriver /usr/local/bin/chromedriver
# Install Google Chrome
RUN curl -sS -o - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add - && \
    echo "deb http://dl.google.com/linux/chrome/deb/ stable main" | sudo tee --append /etc/apt/sources.list.d/google-chrome.list && \
    sudo apt-get -yqq update && \
    sudo apt-get -yqq install google-chrome-stable

RUN sudo apt-get install -y xvfb

# Allow npm install as the dev user
RUN mkdir /home/dev/.npm-global

# Drop in zsh environment configuring script
ADD S51_npm_unversioned /home/dev/.zsh.d/S51_npm_unversioned
ADD angular_cli_run_once.sh /home/dev/angular_cli_run_once.sh
ADD run_xvfb.sh /home/dev/run_xvfb.sh
