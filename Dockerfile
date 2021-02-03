FROM node:15.7.0

# Adding trusting keys to apt for repositories
RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -

# Adding Google Chrome to the repositories
RUN sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list'

# Updating apt to see and install Google Chrome
RUN apt-get -y update

# Magic happens
RUN apt-get install -y google-chrome-stable

# Installing Unzip
RUN apt-get install -yqq unzip

# Download the Chrome Driver
RUN wget -O /tmp/chromedriver.zip http://chromedriver.storage.googleapis.com/`curl -sS chromedriver.storage.googleapis.com/LATEST_RELEASE`/chromedriver_linux64.zip

# Unzip the Chrome Driver into /usr/local/bin directory
RUN unzip /tmp/chromedriver.zip chromedriver -d /usr/local/bin/

# Set display port as an environment variable
ENV DISPLAY=:4444

# Get resources
COPY . ./

# Create app directory
WORKDIR ./

# Install App Dependencies
RUN npm install

# Command to be executed when the image is run
CMD webdriver-manager start

# Install Java needed for Selenium WebDriver to run
RUN apt-get update
RUN apt-get -y install default-jre

# Update WebDriver
RUN ./node_modules/protractor/bin/webdriver-manager update --versions.standalone 3.0.1

# Run Protractor once the image is run
CMD npx protractor conf.js