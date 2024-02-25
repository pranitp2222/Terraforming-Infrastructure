#!/bin/bash

# Install dependecies here:

curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash - && sudo apt-get install -y nodejs

# Run NPM to install the NPM Node packages needed for the code
# You will start this NodeJS script by executing the command: node app.js
# from the directory where app.js is located. The program `pm2` can be
# used to auto start NodeJS applications (as they don't have a normal
# systemd service handler).
# <https://pm2.keymetrics.io/docs/usage/quick-start/>. This will require
# the install of PM2 via npm as well.
cd /home/ubuntu

sudo -u ubuntu git clone git@github.com:illinoistech-itm/ppatil19.git

sudo apt update
sudo apt install -y git build-essential nginx


sudo systemctl enable nginx
sudo systemctl start nginx

sudo cp /home/ubuntu/ppatil19/ITMO-544/MP1/default /etc/nginx/sites-available/default

sudo systemctl daemon-reload
sudo systemctl restart nginx

sudo apt-get update

curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash - && sudo apt-get install -y nodejs
cd /home/ubuntu

sudo -u ubuntu npm install @aws-sdk/client-s3 @aws-sdk/client-sns @aws-sdk/client-rds @aws-sdk/client-secrets-manager mysql2

sudo apt-get install -y ca-certificates curl gnupg
sudo mkdir -p /etc/apt/keyrings

curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg

NODE_MAJOR=20
echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_$NODE_MAJOR.x nodistro main" | sudo tee /etc/apt/sources.list.d/nodesource.list

sudo apt-get update
sudo apt-get install nodejs -y

sudo npm install multer
sudo npm install multer-s3

npm init -y  # command to create a default package.json file
npm i @aws-sdk/client-s3

npm install pm2 -g

npm install express


# Command to clone your private repo via SSH usign the Private key
####################################################################
# Note - change "hajek.git" to be your private repo name (hawk ID) #
####################################################################
#sudo -u ubuntu git clone git@github.com:illinoistech-itm/jhajek.git

# Start the nodejs app where it is located via PM2
# https://pm2.keymetrics.io/docs/usage/quick-start
cd /home/ubuntu/ppatil19/ITMO-544/MP1/

sudo pm2 start app.js

# Delete the RSA private key once setup is finished
rm /home/ubuntu/.ssh/id_ed25519