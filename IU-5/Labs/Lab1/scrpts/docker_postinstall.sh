#! /bin/bash

sudo usermod -aG docker $(whoami)
sudo systemctl start docker && sudo systemctl enable docker
