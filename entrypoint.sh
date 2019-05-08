#!/bin/sh
# Invokes butterfly shell and other stuff
echo -e "devops123\ndevops123" | passwd root
echo "PATH=$PATH:$HOME/bin:/stuff" >> ~/.bash_profile
echo "export PATH" >>  ~/.bash_profile
source  ~/.bash_profile
cp -arp /stuff/.aws/* ~/.aws/ 
ssh-add /stuff/.ssh/devops.pem
#butterfly.server.py --motd=/stuff/motd --i-hereby-declare-i-dont-want-any-security-whatsoever --port=8888 --unsecure --host=0.0.0.0
butterfly.server.py --motd=/stuff/motd --login --port=8888 --unsecure --host=0.0.0.0
cd /stuff
