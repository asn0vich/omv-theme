#!/bin/sh
# omv-theme https://github.com/Wolf2000Pi/omv-theme  Version 1.0
# by Wolf2000

cd /root/omv-theme/

chmod +x omv-theme.sh
chmod +x omv-theme-update.sh
chmod +x omv-theme2.sh

cp omv-theme.sh /usr/bin/omv-theme
cp omv-theme-update.sh /usr/bin/omv-theme-update

echo "#!/bin/sh" >> /usr/bin/omv-theme2
echo "./root/omv-theme/omv-theme2" >> /usr/bin/omv-theme2

cd
exec omv-theme

