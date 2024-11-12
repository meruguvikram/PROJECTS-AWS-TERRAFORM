#!/bin/bash
sudo apt update
sudo apt install -y python3 python3-pip python3-virtualenv nginx jq
git clone ${GitRepoURL}
cp -r $(echo "${GitRepoURL}" | sed 's/.*\///' | sed 's/\.git//')/chapter3/code/backend . ; rm -rf $(echo "${GitRepoURL}" | sed 's/.*\///' | sed 's/\.git//') ; cd backend

sed -i "s/SELECTED_REGION/$(curl -s http://169.254.169.254/latest/dynamic/instance-identity/document | jq -r '.region')/g" main.py
              
# Create an Nginx configuration file
cat << EOF > /etc/nginx/sites-available/fastapi
server {
listen 80;
server_name ~.;
location / {
proxy_pass http://localhost:8000;
}
}
EOF
              
sudo ln -s /etc/nginx/sites-available/fastapi /etc/nginx/sites-enabled/
sudo systemctl restart nginx
virtualenv .venv
source .venv/bin/activate
pip install -r requirements.txt
python3 -m uvicorn main:app &
