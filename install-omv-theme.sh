#!/bin/sh

cd /root/omv-theme/
chmod u+x omv-theme.sh
cp omv-theme.sh /usr/bin/omv-theme
cd /
exec omv-theme
