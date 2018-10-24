#!/bin/bash

# Updated 24 Oct 2018
# for Kali 2018.3

RED='\033[1;31m'
GRN='\033[1;32m'
YEL='\033[1;33m'
BLU='\033[1;34m'
NC='\033[0m' # No Color

# This script assumes you've already taken the necessary initial steps to setup network connectivity and install vmware tools
# You probably want at least 'apt install open-vm-tools-desktop' to copy and paste this script and/or the URL to wget it.
echo -e "${YEL}--Starting script, updating, and installing commonly used programs${NC}"
dpkg --add-architecture i386 # Add support for 32bit stuff (ex. Ollydbg)
apt update
apt upgrade -y # Update/upgrade everything
apt full-upgrade -y
apt autoremove -y
apt clean # No, seriously, update/upgrade everything
apt update
apt upgrade -y
apt full-upgrade -y
apt autoremove -y
# Now install the stuff we need.
apt install sublist3r eyewitness open-vm-tools-desktop fuse exfat-utils exfat-fuse python3-bs4 libreoffice network-manager-openvpn-gnome network-manager-openconnect-gnome wine html2text ntpdate -y

# For Hashcat, you still need --force, but it works
# https://hashcat.net/wiki/doku.php?id=frequently_asked_questions#i_may_have_the_wrong_driver_installed_what_should_i_do
apt install ocl-icd-libopencl1 opencl-headers clinfo -y

# Other Notes
# Install FoxyProxy Basic - Setup for Zap/Burp

#### Things I haven't been able to automate ####
# Turn on Global Dark Theme in Tweak Tools -> Appearance
	# Applications = Kali-X-Dark and Icons = Vibrancy-Kali-Full-Dark
	# /usr/share/glib-2.0/schemas/20_kali-defaults.gschema.override
# https://extensions.gnome.org/extension/1465/desktop-icons/
	# https://linuxconfig.org/how-to-install-gnome-shell-extensions-from-zip-file-using-command-line-on-ubuntu-18-04-bionic-beaver-linuxg

# Set global dark theme
echo '[Settings]' > /root/.config/gtk-3.0/settings.ini
echo 'gtk-application-prefer-dark-theme=1' >> /root/.config/gtk-3.0/settings.ini

# Stop blanking my screen
gsettings set org.gnome.desktop.session idle-delay 0 # Settings -> Power -> Blank Screen -> Never

# Turn off Dash to Dock Intelligent Autohide (I hate my dock dissappearing)
dconf write /org/gnome/shell/extensions/dash-to-dock/dock-fixed true

echo -e "${YEL}--Upgrading and installing useful PIP stuff${NC}"
# Upgrade then install some useful pip stuff
pip install --upgrade pip
pip install whatportis
pip install pinggraph
# apt-get install gtk-recordmydesktop # do I use this anymore?
# apt-get install libav-tools # do I use this anymore?

echo -e "${YEL}--Adding command line options${NC}"
# Add syntax to vim
echo "syntax on" >> /root/.vimrc

# Add stuff to .bashrc
echo -e "\n" >> /root/.bashrc
echo "# ADDING STUFF FROM SETUP SCRIPT" >> /root/.bashrc
echo "# colorcat" >> /root/.bashrc
echo "alias ccat='pygmentize -O bg=dark,style=colorful'" >> /root/.bashrc
echo "# some more ls aliases" >> /root/.bashrc
echo "alias ll='ls -l'" >> /root/.bashrc
echo "alias la='ls -A'" >> /root/.bashrc
echo "alias l='ls -CF'" >> /root/.bashrc

echo -e "${YEL}--Gathering BBK's Scripts${NC}"
wget --quiet -O /usr/local/bin/decode.sh https://gist.githubusercontent.com/BeanBagKing/019252de635f8748d36e47ee2d57d3b1/raw
	chmod 755 /usr/local/bin/decode.sh
wget --quiet -O /usr/local/bin/scripts_update.sh https://gist.githubusercontent.com/BeanBagKing/2f9ad70daf8d793f1a8e4c2d096897ba/raw
	chmod 755 /usr/local/bin/scripts_update.sh
wget --quiet -O /usr/local/bin/catsploit.sh https://gist.githubusercontent.com/BeanBagKing/ad75307f8cff18d8a0a2/raw/catsploit.sh
	chmod 755 /usr/local/bin/catsploit.sh
wget --quiet -O /usr/local/bin/nsesearch.sh https://gist.githubusercontent.com/BeanBagKing/c2a4f9a498a086c1b7f9/raw/nsesearch.sh
	chmod 755 /usr/local/bin/nsesearch.sh

echo -e "${YEL}--Installing Sublime${NC}"
wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | apt-key add -
apt install apt-transport-https
echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
apt update
apt install sublime-text

echo -e "${YEL}--Prepping Scripts${NC}"
# Make a dir for our scripts.
mkdir /root/Scripts
# We don't want to give away more info than necessary, replace the default apache page (should we server stuff with Apache)
rm /var/www/html/index.html
# And replace with blank page
touch /var/www/html/index.html

echo -e "${YEL}--Gathering Other Useful Scripts${NC}"
# Some helpful scripts
wget --quiet -O /usr/local/bin/pingi https://gist.githubusercontent.com/brunobraga/7259197/raw
	chmod 755 /usr/local/bin/pingi
wget --quiet -O /usr/local/bin/diffi https://gist.githubusercontent.com/BeanBagKing/1822327b6d19424be2893e1cb5044c80/raw
	chmod 755 /usr/local/bin/diffi
wget --quiet -P /root/Scripts https://raw.githubusercontent.com/pentestmonkey/unix-privesc-check/1_x/unix-privesc-check
	chmod 755 /root/Scripts/unix-privesc-check

git clone https://github.com/13Cubed/Abeebus /root/Scripts/Abeebus &> /dev/null
git clone https://github.com/13Cubed/Rebeebus /root/Scripts/Rebeebus &> /dev/null
git clone https://github.com/DidierStevens/DidierStevensSuite /root/Scripts/DidierStevensSuite &> /dev/null
git clone https://github.com/BeanBagKing/kali_update /root/Scripts/kali_update &> /dev/null
git clone https://github.com/GDSSecurity/Windows-Exploit-Suggester /root/Scripts/Windows-Exploit-Suggester &> /dev/null
git clone https://github.com/huntergregal/mimipenguin /root/Scripts/mimipenguin &> /dev/null
git clone https://github.com/lbarman/kali-tools /root/Scripts/kali-tools &> /dev/null
git clone https://github.com/pentestmonkey/unix-privesc-check /root/Scripts/unix-privesc-check2 &> /dev/null
git clone https://github.com/PenturaLabs/Linux_Exploit_Suggester /root/Scripts/Linux_Exploit_Suggester &> /dev/null
git clone https://github.com/rebootuser/LinEnum /root/Scripts/LinEnum &> /dev/null
git clone https://github.com/RUB-NDS/PRET /root/Scripts/PRET &> /dev/null

tar -C /root/Scripts -czf /root/Scripts/upc2.tar.gz unix-privesc-check2 # compress for easy moving - extract with tar -zxvf upc2.tar.gz

echo -e "${YEL}--Creating application shortcuts${NC}"
# Setup shortcuts for ~stuff~
chmod 755 /root/Scripts/Abeebus/abeebus.py
ln -s /root/Scripts/Abeebus/abeebus.py /usr/local/bin/abeebus.py
chmod 755 /root/Scripts/Rebeebus/rebeebus.py
ln -s /root/Scripts/Rebeebus/rebeebus.py /usr/local/bin/rebeebus.py
chmod 755 /root/Scripts/kali_update/update.sh 
ln -s /root/Scripts/kali_update/update.sh /usr/local/bin/update.sh
chmod 755 /root/Scripts/kali-tools/kali.py
ln -s /root/Scripts/kali-tools/kali.py /usr/local/bin/kali.py
chmod 755 /root/Scripts/PRET/pret.py
ln -s /root/Scripts/PRET/pret.py /usr/local/bin/pret.py

echo -e "${RED}--Building NSESearch Data File${NC}"
/usr/local/bin/scripts_update.sh
echo -e "${GRN}--FIN - Consider running update.sh${NC}"
