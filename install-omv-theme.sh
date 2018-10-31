#!/bin/bash

cd /root/omv-theme/
chmod +x omv-theme.sh
cp omv-theme.sh /usr/bin/omv-theme
cd
exec omv-theme
