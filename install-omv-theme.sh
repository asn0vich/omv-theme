#!/bin/bash

cd /root/omv-theme/

chmod +x omv-theme.sh
chmod +x omv-theme2.sh

cp omv-theme.sh /usr/bin/omv-theme
cp omv-theme2.sh /usr/bin/omv-theme

cd
exec omv-theme

