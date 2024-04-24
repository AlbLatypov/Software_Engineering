#!/bin/bash
echo "python 3 installing...---------------------------------------"
sudo yum -y install python3

echo "Create env...------------------------------------------------"
python3 -m venv venv

echo "Activate env...-----------------------------------------------"
source venv/bin/activate

echo "Installing gdown...-------------------------------------------"
pip install gdown

echo "Get script:...------------------------------------------------"
gdown --id 1MQgkNUZqu-ts7SYgbbv2A7AN4f_MfQHu -O install_docker.sh

echo "Chmod 755-----------------------------------------------------"
chmod 755 install_docker.sh

echo "Start installing docker....."
sh install_docker.sh

echo "Check version....---------------------------------------------"
docker -v

echo "Check systemctl status docker. Start if nesse..."
