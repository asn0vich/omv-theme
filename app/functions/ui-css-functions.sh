#!/bin/bash

################################################################
# UI CSS plugins

#
# Custom header background color
#

set_header_background_color() {
COLOR_CODE=$(whiptail --inputbox "Insert color hex or color name, example of hex color #ff0000 or red" 8 78 "#ff0000" --title "Set background color" 3>&1 1>&2 2>&3)

exitstatus=$?
if [ $exitstatus = 0 ]; then
    echo "User selected Ok and entered " $COLOR_CODE
    style="\\n\n div#header{background: $COLOR_CODE !important; /*custom-background-color*/}"
    cp /var/www/openmediavault/css/theme-triton.min.css /root/omv-theme/backup/header-bg-color.bak
    # echo $style >> /var/www/openmediavault/css/theme-triton.min.css
    sed -i "$ a \\\n $style" /var/www/openmediavault/css/theme-triton.min.css
else
    echo "User selected Cancel."
fi

echo "(Exit status was $exitstatus)"
}


revert_header_background_color() {
    sed -i -e '/div#header{background:/,\/*custom-background-color*\/},/c\ ' /var/www/openmediavault/css/theme-triton.min.css
}



#
# Remove header
#

set_remove_header() {
    style="div#header{display: none !important;}
div[id^=\"workspace-node-tree-\"].x-panel.x-workspace-node-tree,
div[id^=\"ext-comp-\"][id$=\"-center\"],
div[id^=\"workspace-node-tree-\"][id$=\"-splitter\"]{
	top: 0 !important;
	height: 100vh !important;
}

div[id^=\"workspace-node-tree-\"][id$=\"-body\"],
div[id^=\"ext-comp-\"][id$=\"-body\"]{
	height: 100vh !important;
}"
    sed -i "$ a \\\n $style" /var/www/openmediavault/css/theme-triton.min.css
}


revert_remove_header() {
    sed -i -e '/div#header{background:/,\/*custom-background-color*\/},/c\ ' /var/www/openmediavault/css/theme-triton.min.css
}


