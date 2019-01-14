#!/bin/bash

################################################################
# theme functions

do_css_backup() {
exit 0
}

remove_custom_theme() {
    rm -rf /var/www/openmediavault/css/theme-custom.*

}

apply_theme(){
    THEME_NAME=$1

    rm -rf /var/www/openmediavault/css/theme-custom.*
    cp /root/omv-theme/themes/$THEME_NAME.css /var/www/openmediavault/css/theme-custom.css

    source /usr/share/openmediavault/scripts/helper-functions && omv_purge_internal_cache

}
