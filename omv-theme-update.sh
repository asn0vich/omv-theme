#!/bin/sh

rm -rf /root/omv-theme/
git clone https://github.com/virgil-av/omv-theme.git
cd /root/omv-theme

chmod +x omv-theme.sh
chmod +x update-theme.sh
chmod +x omv-theme2.sh

rm -rf /usr/bin/omv-theme
cp /root/omv-theme/omv-theme.sh /usr/bin/omv-theme
cp /root/omv-theme/omv-theme2.sh /usr/bin/omv-theme2
exec omv-theme