#!/bin/bash

################################################################
# theme functions

do_css_backup() {
if [ ! -f /root/omv-theme/backup/controlpanelabstract.inc ]; then
    cp /usr/share/php/openmediavault/controlpanel/controlpanelabstract.inc /root/omv-theme/backup/controlpanelabstract.inc
fi
}

do_omv_triton() {
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

do_omv_black() {
    echo 'OMV_WEBUI_THEME=triton' >> /etc/default/openmediavault
    rm -r /var/www/openmediavault/css/theme-custom.*.css
    cp /root/omv-theme/themes/theme-black.css /var/www/openmediavault/css/theme-custom.black.css
    sed -i '/theme-custom/c\$fileName = "css\/theme-custom.black.css";' /usr/share/php/openmediavault/controlpanel/controlpanelabstract.inc
}

do_omv_cherry() {
    echo 'OMV_WEBUI_THEME=triton' >> /etc/default/openmediavault
    rm -r /var/www/openmediavault/css/theme-custom.*.css
    cp /root/omv-theme/themes/theme-sour-cherry.css /var/www/openmediavault/css/theme-custom.sour-cherry.css
    sed -i '/theme-custom/c\$fileName = "css\/theme-custom.sour-cherry.css";' /usr/share/php/openmediavault/controlpanel/controlpanelabstract.inc
}

do_omv_green() {
    echo 'OMV_WEBUI_THEME=triton' >> /etc/default/openmediavault
    rm -r /var/www/openmediavault/css/theme-custom.*.css
    cp /root/omv-theme/themes/theme-green-peace.css /var/www/openmediavault/css/theme-custom.green-peace.css
    sed -i '/theme-custom/c\$fileName = "css\/theme-custom.green-peace.css";' /usr/share/php/openmediavault/controlpanel/controlpanelabstract.inc
}

do_omv_old_gold() {
    echo 'OMV_WEBUI_THEME=triton' >> /etc/default/openmediavault
    rm -r /var/www/openmediavault/css/theme-custom.*.css
    cp /root/omv-theme/themes/theme-old-gold.css /var/www/openmediavault/css/theme-custom.old-gold.css
    sed -i '/theme-custom/c\$fileName = "css\/theme-custom.old-gold.css";' /usr/share/php/openmediavault/controlpanel/controlpanelabstract.inc
}

do_omv_condensed_black() {
    echo 'OMV_WEBUI_THEME=triton' >> /etc/default/openmediavault
    rm -r /var/www/openmediavault/css/theme-custom.*.css
    cp /root/omv-theme/themes/theme-condensed-black.css /var/www/openmediavault/css/theme-custom.condensed-black.css
    sed -i '/theme-custom/c\$fileName = "css\/theme-custom.condensed-black.css";' /usr/share/php/openmediavault/controlpanel/controlpanelabstract.inc
}

do_omv_black_and_white() {
    echo 'OMV_WEBUI_THEME=triton' >> /etc/default/openmediavault
    rm -r /var/www/openmediavault/css/theme-custom.*.css
    cp /root/omv-theme/themes/theme-black.css /var/www/openmediavault/css/theme-custom.black.css
    sed -i '/theme-custom/c\$fileName = "css\/theme-custom.black.css";' /usr/share/php/openmediavault/controlpanel/controlpanelabstract.inc
}
