#!/bin/bash

YEL='\033[1;33m'
RED='\033[1;31m'
GRN='\033[1;32m'
NC='\033[0m' # No Color

# This script assumes you've already taken the necessary initial steps to setup network connectivity and install vmware tools
# You probably want at least open-vm-tools-desktop to copy and paste this script and/or the URL to wget it.
echo -e "${YEL}--${NC}Starting script, installing commonly used programs"
dpkg --add-architecture i386 # Add support for 32bit stuff (ex. Ollydbg)
apt update
apt install open-vm-tools-desktop fuse exfat-utils exfat-fuse python3-bs4 cherrytree libreoffice network-manager-openvpn-gnome network-manager-openconnect-gnome wine32 html2text -y

# Other Notes
# Install FoxyProxy Basic - Setup for Zap/Burp
# Install TamperData
# Install Cookie Manager + or whatever that one is

# Turn on Global Dark Theme in Tweak Tools -> Appearance
# Turn off Intelligent autohide in Tweak Tools -> Extensions -> Dash to Dock
# Turn on Places status indicator in Tweak Tools -> Extensions

echo -e "${YEL}--${NC}Upgrading and installing useful PIP stuff"
# Upgrade then install some useful pip stuff
pip install --upgrade pip
pip install whatportis
pip install pinggraph
# apt-get install gtk-recordmydesktop # do I use this anymore?
# apt-get install libav-tools # do I use this anymore?

echo -e "${YEL}--${NC}Adding command line options"
# Add syntax to vim
echo "syntax on" >> .vimrc

# Add stuff to .bashrc
echo -e "\n" >> .bashrc
echo "# ADDING STUFF FROM SETUP SCRIPT" >> .bashrc
echo "# colorcat" >> .bashrc
echo "alias ccat='pygmentize -O bg=dark,style=colorful'" >> .bashrc
echo "# Python SimpleHTTPServer Shortcut" >> .bashrc
echo "alias simplehttp='python -m SimpleHTTPServer'" >> .bashrc
echo "# Open current directory in file explorer" >> .bashrc
echo "alias opendir='nautilus . 2>/dev/null'" >> .bashrc
echo "# some more ls aliases" >> .bashrc
echo "alias ll='ls -l'" >> .bashrc
echo "alias la='ls -A'" >> .bashrc
echo "alias l='ls -CF'" >> .bashrc

echo -e "${YEL}--${NC}Gathering BBK's Scripts"
wget --quiet -O /usr/local/bin/decode.sh https://gist.githubusercontent.com/BeanBagKing/019252de635f8748d36e47ee2d57d3b1/raw
	chmod 755 /usr/local/bin/decode.sh
wget --quiet -O /usr/local/bin/scripts_update.sh https://gist.githubusercontent.com/BeanBagKing/2f9ad70daf8d793f1a8e4c2d096897ba/raw
	chmod 755 /usr/local/bin/scripts_update.sh
wget --quiet -O /usr/local/bin/update.sh https://gist.githubusercontent.com/BeanBagKing/b4e6ee2858ed92604a91/raw
	chmod 755 /usr/local/bin/update.sh
wget --quiet -O /usr/local/bin/catsploit.sh https://gist.githubusercontent.com/BeanBagKing/ad75307f8cff18d8a0a2/raw/catsploit.sh
	chmod 755 /usr/local/bin/catsploit.sh
wget --quiet -O /usr/local/bin/nsesearch.sh https://gist.githubusercontent.com/BeanBagKing/c2a4f9a498a086c1b7f9/raw/nsesearch.sh
	chmod 755 /usr/local/bin/nsesearch.sh

echo -e "${YEL}--${NC}Installing Sublime"
wget --quiet -O /root/Downloads/sublime.deb https://download.sublimetext.com/sublime-text_build-3126_amd64.deb
	dpkg -i /root/Downloads/sublime.deb
	rm /root/Downloads/sublime.deb -f

echo -e "${YEL}--${NC}Prepping Scripts"
# Make a dir for our scripts.
mkdir /root/Scripts
touch /root/Scripts/index.html # Comment this out for directory browsing
# We don't want to give away more info than necessary, replace the default apache page!
rm /var/www/html/index.html
# And replace with blank page
touch /var/www/html/index.html

echo -e "${YEL}--${NC}Gathering Other Useful Scripts"
# Some helpful scripts
wget --quiet -O /usr/local/bin/pingi https://gist.githubusercontent.com/brunobraga/7259197/raw
	chmod 755 /usr/local/bin/pingi
wget --quiet -O /usr/local/bin/diffi https://gist.githubusercontent.com/BeanBagKing/1822327b6d19424be2893e1cb5044c80/raw
	chmod 755 /usr/local/bin/diffi
wget --quiet -P /root/Scripts https://raw.githubusercontent.com/pentestmonkey/unix-privesc-check/1_x/unix-privesc-check
	chmod 755 /root/Scripts/unix-privesc-check

git clone https://github.com/13Cubed/Abeebus /root/Scripts/Abeebus &> /dev/null
git clone https://github.com/ChrisTruncer/EyeWitness /root/Scripts/EyeWitness &> /dev/null
git clone https://github.com/drwetter/testssl.sh /root/Scripts/testssl &> /dev/null
git clone https://github.com/EmpireProject/Empire /root/Scripts/Empire &> /dev/null
git clone https://github.com/GDSSecurity/Windows-Exploit-Suggester /root/Scripts/Windows-Exploit-Suggester &> /dev/null
git clone https://github.com/huntergregal/mimipenguin /root/Scripts/mimipenguin &> /dev/null
git clone https://github.com/lbarman/kali-tools /root/Scripts/kali-tools &> /dev/null
git clone https://github.com/m4ll0k/WPSeku /root/Scripts/WPSeku &> /dev/null
git clone https://github.com/pentestmonkey/unix-privesc-check /root/Scripts/unix-privesc-check2 &> /dev/null
git clone https://github.com/PenturaLabs/Linux_Exploit_Suggester /root/Scripts/Linux_Exploit_Suggester &> /dev/null
git clone https://github.com/rebootuser/LinEnum /root/Scripts/LinEnum &> /dev/null
git clone https://github.com/RUB-NDS/PRET /root/Scripts/PRET &> /dev/null

echo -e "${YEL}--${NC}Running a few setups"
/root/Scripts/EyeWitness/setup/setup.sh # Go ahead and run the setup
/root/Scripts/Empire/setup/install.sh # Go ahead and run the setup
tar -C /root/scripts -czf /root/Scripts/upc2.tar.gz unix-privesc-check2 # compress for easy moving - extract with tar -zxvf upc2.tar.gz

echo -e "${YEL}--${NC}Creating application shortcuts"
# Setup shortcuts for ~stuff~
echo '#!/bin/bash' > /usr/local/bin/abeebus
echo 'cd /root/Scripts/Abeebus/ && ./abeebus.py "$@"' >> /usr/local/bin/abeebus
chmod 755 abeebus
echo '#!/bin/bash' > /usr/local/bin/eyewitness
echo 'cd /root/Scripts/EyeWitness/ && ./EyeWitness.py "$@"' >> /usr/local/bin/eyewitness
chmod 755 eyewitness
echo '#!/bin/bash' > /usr/local/bin/kali
echo 'cd /root/Scripts/kali-tools/ && ./kali.py "$@"' >> /usr/local/bin/kali
chmod 755 kali
echo '#!/bin/bash' > /usr/local/bin/pret
echo 'cd /root/Scripts/PRET/ && ./pret.py "$@"' >> /usr/local/bin/pret
chmod 755 pret
echo '#!/bin/bash' > /usr/local/bin/wpseku
echo 'cd /root/Scripts/WPSeku/ && ./wpseku.py "$@"' >> /usr/local/bin/wpseku
chmod 755 wpseku
echo '#!/bin/bash' > /usr/local/bin/empire
echo 'cd /root/Scripts/Empire/ && ./empire.py "$@"' >> /usr/local/bin/empire
chmod 755 empire
echo '#!/bin/bash' > /usr/local/bin/testssl
echo 'cd /root/Scripts/testssl/ && ./testssl.sh "$@"' >> /usr/local/bin/testssl
chmod 755 testssl

echo -e "${RED}--${NC}Building NSESearch Data File"
/usr/local/bin/scripts_update.sh

echo -e "${YEL}--${NC}Downloading OpenCL - ${RED}Install this later${NC}"
wget --quiet -O /root/Downloads/opencl.tgz http://registrationcenter-download.intel.com/akdlm/irc_nas/9019/opencl_runtime_16.1.1_x64_ubuntu_6.4.0.25.tgz
echo -e "${GRN}--${NC}Manually install OpenCL drivers (GUI Install - Downloads Folder)"
echo -e "${GRN}--${NC}FIN - Consider running update.sh"