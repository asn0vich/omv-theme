#!/bin/sh

# remove old code and pull the new one
rm -rf /root/omv-theme
git clone https://github.com/virgil-av/omv-theme.git
cd /root/omv-theme

# make main scripts executable
chmod +x omv-theme.sh
chmod +x update-theme.sh
chmod +x omv-theme2.sh

# clean scripts from /usr/bin
rm -r /usr/bin/omv-theme
rm -r /usr/bin/omv-theme2
rm -r /usr/bin/update-theme

# copy and create scripts for execution
cp /root/omv-theme/omv-theme.sh /usr/bin/omv-theme
cp /root/omv-theme/update-theme.sh /usr/bin/update-theme

echo "#!/bin/sh" >> /usr/bin/omv-theme2
echo "/bin/bash /root/omv-theme/omv-theme2" >> /usr/bin/omv-theme2

exec omv-theme