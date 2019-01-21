#!/bin/bash

################################################################
# UI CSS plugins



#######################################
# header bg color

set_header_background_color() {
COLOR_CODE=$1

if [ -z "$COLOR_CODE" ]; then
    COLOR_CODE=$(whiptail --inputbox "Insert color hex or color name, example of hex color #ff0000 or red" 8 78 "#ff0000" --title "Set background color" 3>&1 1>&2 2>&3)
    exitstatus=$?
fi

if [ $exitstatus = 0 ] || [ -n "$COLOR_CODE" ]; then
    echo "User selected Ok and entered " $COLOR_CODE

    # create the style
    style="div#header{background: $COLOR_CODE !important; /*custom-background-color*/}"

    # trim the empty lines
    ex -s +'v/\S/d' -cwq /var/www/openmediavault/css/theme-triton.min.css

    # add a new line and apply the custom css
    sed -i "$ a \\\n" /var/www/openmediavault/css/theme-triton.min.css
    sed -i "$ a $style" /var/www/openmediavault/css/theme-triton.min.css
else
    echo "User selected Cancel."
fi

echo "(Exit status was $exitstatus)"
}

remove_header_background_color() {
    sed -i -e "/div#header{background:/,\/*custom-background-color*\/},/c\ " /var/www/openmediavault/css/theme-triton.min.css
}

# end header bg color
#######################################




#######################################
# hide header

set_hide_header() {
    cat /root/omv-theme/css/remove-header.css >> /var/www/openmediavault/css/theme-triton.min.css
}

remove_hide_header() {
    sed -i -e "/remove-header-start/,/remove-header-end/c\ " /var/www/openmediavault/css/theme-triton.min.css
}

# end hide header
#######################################



#######################################
# custom header background image

set_header_bg_img() {
BGIMG_URL=$1

if [ -z "$BGIMG_URL" ]; then
    BGIMG_URL=$(whiptail --inputbox "Insert background image url [hotlink to image should end in (jpg, png)]" 8 78 http:// --title "Set logo url" 3>&1 1>&2 2>&3)
    exitstatus=$?
fi

if [ $exitstatus = 0 ] || [ -n "$BGIMG_URL" ]; then
    echo "User selected Ok and entered " $BGIMG_URL

    # download and copy image to omv image folders
    wget $BGIMG_URL -O /root/omv-theme/images/custom-background.png
    cp /root/omv-theme/images/custom-background.png /var/www/openmediavault/images/custom-background.png

    # trim the empty lines
    ex -s +'v/\S/d' -cwq /var/www/openmediavault/css/theme-triton.min.css

    #add the css
    cat /root/omv-theme/css/background-image.css >> /var/www/openmediavault/css/theme-triton.min.css
else
    echo "User selected Cancel."
fi

echo "(Exit status was $exitstatus)"
}

remove_header_bg_img() {
    sed -i -e "/custom-background-image-start/,/custom-background-image-end/c\ " /var/www/openmediavault/css/theme-triton.min.css
}

# end custom header background image
#######################################



#######################################
# custom font size and weight

set_font_size_and_weight() {
FONT_SIZE=$(whiptail --inputbox "It should be a number" 8 78 "12" --title "Font size" 3>&1 1>&2 2>&3)
FONT_WEIGHT=$(whiptail --inputbox "Can be a number (100-900) or text normal, bold, bolder, lighter, google font-weight property values" 8 78 "bold" --title "Font Weight" 3>&1 1>&2 2>&3)

exitstatus=$?
if [ $exitstatus = 0 ]; then
    echo $FONT_SIZE $FONT_WEIGHT
    sed -i -e "/font-size:/,/;/c\ font-size:"$FONT_SIZE"px !important;\n font-weight:$FONT_WEIGHT !important;" /root/omv-theme/css/font.css
    cat /root/omv-theme/css/font.css >> /var/www/openmediavault/css/theme-triton.min.css

else
    echo "User selected Cancel."
fi
}

remove_font_size_and_weight() {
    sed -i -e "/custom-font-preset-start/,/custom-font-preset-end/c\ " /var/www/openmediavault/css/theme-triton.min.css
}

# end custom font size and weight
#######################################


#######################################
# fix triton css

fix_default_css(){
wget https://raw.githubusercontent.com/openmediavault/openmediavault/master/deb/openmediavault/var/www/openmediavault/css/theme-triton.min.css -O /var/www/openmediavault/css/theme-triton.min.css
}
# end fix triton css
#######################################