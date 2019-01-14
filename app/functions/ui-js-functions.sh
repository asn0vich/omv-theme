#!/bin/bash

################################################################
# UI JS plugins


################################################################
# Custom header block

# backup omv file before editing
backup_workspace_js() {
if [ ! -f /var/www/openmediavault/js/omv/workspace/Workspace.js.bak ]; then
    cp /var/www/openmediavault/js/omv/workspace/Workspace.js /var/www/openmediavault/js/omv/workspace/Workspace.js.bak
fi
}

remove_workspace_js_backup() {
    rm -rf /var/www/openmediavault/js/omv/workspace/Workspace.js.bak
}

remove_header_text_or_logo() {
if [ -f /var/www/openmediavault/js/omv/workspace/Workspace.js.bak ]; then
    cp /var/www/openmediavault/js/omv/workspace/Workspace.js.bak /var/www/openmediavault/js/omv/workspace/Workspace.js
fi

if [ -f /var/www/openmediavault/images/custom-logo.png ]; then
    rm /var/www/openmediavault/images/custom-logo.png
fi

sed -i -e "/custom-logo-start/,/custom-logo-end/c\ " /var/www/openmediavault/css/theme-triton.min.css
}

# set an apply header text
set_header_text() {
remove_header_text_or_logo

DOMAIN_NAME=$(whiptail --inputbox "Insert custom title" 8 78 Name --title "Set text title" 3>&1 1>&2 2>&3)

exitstatus=$?
if [ $exitstatus = 0 ]; then
    echo "User selected Ok and entered " $DOMAIN_NAME
    sed -i "/var customHeaderText/c\var customHeaderText = '$DOMAIN_NAME';" /root/omv-theme/javascript/header-text.js
    sed -i -e '/buildHeader: function() {/,/},/c\buildHeader: function() {\n\/\/custom header\n},' /var/www/openmediavault/js/omv/workspace/Workspace.js
    sed -i -e "/\/\/custom header/r /root/omv-theme/javascript/header-text.js" /var/www/openmediavault/js/omv/workspace/Workspace.js
else
    echo "User selected Cancel."
fi

echo "(Exit status was $exitstatus)"
}


set_header_logo() {
remove_header_text_or_logo
LOGO_URL=$1

if [ -z "LOGO_URL" ]; then
    LOGO_URL=$(whiptail --inputbox "Insert logo url [hotlink to image should end in (jpg, png)]" 8 78 http:// --title "Set logo url" 3>&1 1>&2 2>&3)
fi

exitstatus=$?
if [ $exitstatus = 0 ] || [ -n "LOGO_URL" ]; then
    echo "User selected Ok and entered " $LOGO_URL
    wget $LOGO_URL -O /root/omv-theme/images/custom-logo.png
    cp /root/omv-theme/images/custom-logo.png /var/www/openmediavault/images/custom-logo.png
    sed -i -e '/buildHeader: function() {/,/},/c\buildHeader: function() {\n\/\/custom header\n},' /var/www/openmediavault/js/omv/workspace/Workspace.js
    sed -i -e "/\/\/custom header/r /root/omv-theme/javascript/header-logo.js" /var/www/openmediavault/js/omv/workspace/Workspace.js
    cat /root/omv-theme/css/header-logo.css >> /var/www/openmediavault/css/theme-triton.min.css
else
    echo "User selected Cancel."
fi

echo "(Exit status was $exitstatus)"
}



# End of custom header block
################################################################




do_snow() {
cp /root/omv-theme/javascript/let-it-snow.js /var/www/openmediavault/js/omv/module/public/let-it-snow.js
. /usr/share/openmediavault/scripts/helper-functions
omv_purge_internal_cache
}

remove_snow_plugin() {
rm -rf /var/www/openmediavault/js/omv/module/public/let-it-snow.js
. /usr/share/openmediavault/scripts/helper-functions
omv_purge_internal_cache
}
