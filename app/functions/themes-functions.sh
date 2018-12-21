#!/bin/bash

################################################################
# theme functions

do_css_backup() {
if [ ! -f /root/omv-theme/backup/controlpanelabstract.inc ]; then
    cp /usr/share/php/openmediavault/controlpanel/controlpanelabstract.inc /root/omv-theme/backup/controlpanelabstract.inc
fi
}

remove_custom_theme() {
    echo 'OMV_WEBUI_THEME=triton' >> /etc/default/openmediavault
    rm -r /var/www/openmediavault/css/theme-custom.*.css
    cp /root/omv-theme/backup/controlpanelabstract.inc /usr/share/php/openmediavault/controlpanel/controlpanelabstract.inc
}

apply_theme(){
    themeName=$1

    echo 'OMV_WEBUI_THEME=triton' >> /etc/default/openmediavault
    rm -r /var/www/openmediavault/css/theme-custom.*.css
    cp /root/omv-theme/themes/$themeName.css /var/www/openmediavault/css/theme-custom.$themeName.css
    sed -i "/theme-custom/c\$fileName = \"css\/theme-custom.$themeName.css\";" /usr/share/php/openmediavault/controlpanel/controlpanelabstract.inc
}
