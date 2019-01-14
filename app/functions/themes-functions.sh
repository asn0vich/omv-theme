#!/bin/bash

################################################################
# theme functions

do_css_backup() {
if [ ! -f /root/omv-theme/backup/controlpanelabstract.inc ]; then
    cp /usr/share/php/openmediavault/controlpanel/controlpanelabstract.inc /root/omv-theme/backup/controlpanelabstract.inc
fi
}

remove_custom_theme() {
    rm -r /var/www/openmediavault/css/theme-custom.*.css
    rm -r /var/www/openmediavault/css/theme-custom.css
#    cp /root/omv-theme/backup/controlpanelabstract.inc /usr/share/php/openmediavault/controlpanel/controlpanelabstract.inc
}

apply_theme(){
    themeName=$1

    rm -r /var/www/openmediavault/css/theme-custom.*.css
    rm -r /var/www/openmediavault/css/theme-custom.css
    cp /root/omv-theme/themes/$themeName.css /var/www/openmediavault/css/theme-custom.css
#    sed -i "/theme-custom/c\$fileName = \"css\/theme-custom.$themeName.css\";" /usr/share/php/openmediavault/controlpanel/controlpanelabstract.inc
    source /usr/share/openmediavault/scripts/helper-functions && omv_purge_internal_cache

}
