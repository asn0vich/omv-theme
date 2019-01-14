#!/bin/bash

################################################################
# theme functions

apply_theme(){
    THEME_NAME=$1

    #remove any previous custom css
    rm -rf /var/www/openmediavault/css/theme-custom.*

    #clean way to apply or remove custom theme, if default return back to triton theme also set file owner to omv
    if [ $THEME_NAME -ne "default" ]; then
        cp /root/omv-theme/themes/$THEME_NAME.css /var/www/openmediavault/css/theme-custom.css
        chown openmediavault-webgui:openmediavault-webgui /var/www/openmediavault/css/theme-custom.css
    fi

    # clean omv cache so the changes take effect
    source /usr/share/openmediavault/scripts/helper-functions && omv_purge_internal_cache
}
