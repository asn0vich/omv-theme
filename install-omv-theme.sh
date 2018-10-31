#!/bin/sh
# omv-theme https://github.com/Wolf2000Pi/omv-theme  Version 1.0
# by Wolf2000

cd /root/omv-theme/

chmod +x omv-theme.sh
chmod +x omv-theme2.sh

cp omv-theme.sh /usr/bin/omv-theme

echo "#!/bin/bash" >> /usr/bin/omv-theme2
echo "cd /root/omv-theme/" >> /usr/bin/omv-theme2
echo "/bin/bash omv-theme2.sh" >> /usr/bin/omv-theme2
chmod +x /usr/bin/omv-theme2

cd
exec omv-theme

