#!/bin/bash
sudo apt update
sudo apt install -y python3 python3-pip python3-virtualenv nginx jq

# Hardcoded Git repository URL
git clone https://github.com/Silas-cloudspace/cea-projects-userdata.git

# Dynamically extract the repository name
REPO_NAME=$(basename -s .git https://github.com/Silas-cloudspace/cea-projects-userdata.git)

# Copy and clean up backend code
cp -r $REPO_NAME/backend .
rm -rf $REPO_NAME
cd backend

# Replace SELECTED_REGION in main.py with the current instance's region
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

# Enable the Nginx configuration and restart Nginx
sudo ln -s /etc/nginx/sites-available/fastapi /etc/nginx/sites-enabled/
sudo systemctl restart nginx

# Set up Python virtual environment
virtualenv .venv
source .venv/bin/activate

# Install required Python packages
pip install -r requirements.txt

# Start the FastAPI application
python3 -m uvicorn main:app &
