#!/bin/sh


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

################################################################
# UI plugins

#
# Custom header
#

set_header_text() {
DOMAIN_NAME=$(whiptail --inputbox "Insert custom title" 8 78 Name --title "Set text title" 3>&1 1>&2 2>&3)

exitstatus=$?
if [ $exitstatus = 0 ]; then
    echo "User selected Ok and entered " $DOMAIN_NAME
    sed -i "/customHeaderText/c\var customHeaderText = '$DOMAIN_NAME';" /root/omv-theme/javascript/header-text.js
else
    echo "User selected Cancel."
fi

echo "(Exit status was $exitstatus)"
}


set_header_logo_url() {
LOGO_URL=$(whiptail --inputbox "Insert logo url" 8 78 http:// --title "Set logo url" 3>&1 1>&2 2>&3)

exitstatus=$?
if [ $exitstatus = 0 ]; then
    echo "User selected Ok and entered " $LOGO_URL
    sed -i "/customLogoUrl/c\var customLogoUrl = '$LOGO_URL';" /root/omv-theme/javascript/header-logo.js
else
    echo "User selected Cancel."
fi

echo "(Exit status was $exitstatus)"
}

do_header_backup() {
if [ ! -f /root/omv-theme/backup/Workspace.js ]; then
    cp /var/www/openmediavault/js/omv/workspace/Workspace.js /root/omv-theme/backup/Workspace.js
fi
}

do_header_text() {
if [ -f /root/omv-theme/backup/Workspace.js ]; then
    cp /root/omv-theme/backup/Workspace.js /var/www/openmediavault/js/omv/workspace/Workspace.js
fi
sed -i -e '/buildHeader: function() {/,/},/c\buildHeader: function() {\n\/\/custom header\n},' /var/www/openmediavault/js/omv/workspace/Workspace.js
sed -i -e "/\/\/custom header/r /root/omv-theme/javascript/header-text.js" /var/www/openmediavault/js/omv/workspace/Workspace.js


}

do_remove_header_domain() {
if [ -f /root/omv-theme/backup/Workspace.js ]; then
    cp /root/omv-theme/backup/Workspace.js /var/www/openmediavault/js/omv/workspace/Workspace.js
fi
}


################################################################
# Menu stuff I am not familiar with

INTERACTIVE=True
ASK_TO_REBOOT=0
#BLACKLIST=/etc/modprobe.d/raspi-blacklist.conf
#CONFIG=/boot/config.txt

calc_wt_size() {
  # NOTE: it's tempting to redirect stderr to /dev/null, so supress error
  # output from tput. However in this case, tput detects neither stdout or
  # stderr is a tty and so only gives default 80, 24 values
  WT_HEIGHT=17
  WT_WIDTH=$(tput cols)

  if [ -z "$WT_WIDTH" ] || [ "$WT_WIDTH" ]; then
    WT_WIDTH=25
  fi
  if [ "$WT_WIDTH" ]; then
    WT_WIDTH=35
  fi
  WT_MENU_HEIGHT=$(($WT_HEIGHT-7))
}


set_config_var() {
  lua - "$1" "$2" "$3" <<EOF > "$3.bak"
local key=assert(arg[1])
local value=assert(arg[2])
local fn=assert(arg[3])
local file=assert(io.open(fn))
local made_change=false
for line in file:lines() do
  if line:match("^#?%s*"..key.."=.*$") then
    line=key.."="..value
    made_change=true
  end
  print(line)
end

if not made_change then
  print(key.."="..value)
end
EOF
mv "$3.bak" "$3"
}

get_config_var() {
  lua - "$1" "$2" <<EOF
local key=assert(arg[1])
local fn=assert(arg[2])
local file=assert(io.open(fn))
for line in file:lines() do
  local val = line:match("^#?%s*"..key.."=(.*)$")
  if (val ~= nil) then
    print(val)
    break
  end
end
EOF
}

do_finish() {
  #disable_raspi_config_at_boot
  if [ $ASK_TO_REBOOT -eq 1 ]; then
    whiptail --yesno "Would you like to reboot now?" 20 60 2
    if [ $? -eq 0 ]; then # yes
      sync
      reboot
    fi
  fi
  exit 0
}


################################################################
# functional and information

do_about() {
  whiptail --msgbox "\

  OMV THEME v.1.2.1

  Check https://github.com/virgil-av/omv-theme.git for updates and how to guide.
  Project maintained by Virgil A. @ 2018
  App is meant vor OpenMediaVault v4.x

  I take no responsibility if this breaks your OMV UI, use this tool at your own risk.
  Most customizations have a revert option  which should should fix any problems related to omv-theme
  When reverting always remember to clear your browser cache.

  Project was forked from https://github.com/Wolf2000Pi/omv-theme Version 1.0.2 by Wolf2000.
" 20 70 1
}

do_update_omv_theme() {
  # revert plugins before update
  do_remove_header_domain
  do_omv_triton
  # do update
  cd ~
  exec omv-theme-update
}

do_uninstall() {
  # revert plugins before update
  do_remove_header_domain
  do_omv_triton
  # do uninstall

  rm -r /var/www/openmediavault/css/theme-custom.*.css
  rm -rf /root/omv-theme
  rm -r /usr/bin/omv-theme
  rm -r /usr/bin/omv-theme2
  rm -r /usr/bin/omv-theme-update
  exit 1
}


################################################################
# Menu needs to sit at the bottom it seems

###############################################################
# Special menus for some ui plugins

#
# Custom header menu
#

open_custom_header_menu() {
    calc_wt_size
    while true; do
      FUN=$(whiptail --title "OMV CUSTOM HEADER" --menu "Setup Options" $WT_HEIGHT $WT_WIDTH $WT_MENU_HEIGHT --cancel-button Back --ok-button Select \
        "1 <<<<< Back" "" \
        "2 Set header text" "" \
        "3 Apply header text to UI" "" \
        "4 Set logo url" "" \
        "5 Apply logo to UI" "" \
        "6 Remove OMV logo" "" \
        "7 Revert changes" "" \
         \
        3>&1 1>&2 2>&3)
      RET=$?
      if [ $RET -eq 1 ]; then
        open_ui_menu
      elif [ $RET -eq 0 ]; then
        case "$FUN" in
          1\ *) open_ui_menu ;;
          2\ *) set_header_text ;;
          3\ *) do_header_text ;;
          4\ *) set_header_logo_url ;;
          5\ *) do_header_text ;;
          6\ *) do_header_text ;;
          7\ *) do_remove_header_domain ;;
          *) whiptail --msgbox "Programmer error: unrecognized option" 20 40 1 ;;
        esac || whiptail --msgbox "There was an error running option $FUN" 20 40 1
      else
        exit 1
      fi
    done
}

# END of Special menus for some ui plugins
###############################################################


#
# Theme menu
#
open_theme_menu() {
    calc_wt_size
    while true; do
      FUN=$(whiptail --title "OMV CSS THEMES" --menu "Setup Options" $WT_HEIGHT $WT_WIDTH $WT_MENU_HEIGHT --cancel-button Back --ok-button Select \
        "1 <<<<< Back" "" \
        "2 Restore Default" "" \
        "3 Theme Blackish" "" \
        "4 Theme Sour Cherry" "" \
        "5 Theme Green Peace" "" \
        "6 Theme Old Gold" "" \
         \
        3>&1 1>&2 2>&3)
      RET=$?
      if [ $RET -eq 1 ]; then
        open_main_menu
      elif [ $RET -eq 0 ]; then
        case "$FUN" in
          1\ *) open_main_menu ;;
          2\ *) do_omv_triton ;;
          3\ *) do_omv_black ;;
          4\ *) do_omv_cherry ;;
          5\ *) do_omv_green ;;
          6\ *) do_omv_old_gold ;;
          *) whiptail --msgbox "Programmer error: unrecognized option" 20 40 1 ;;
        esac || whiptail --msgbox "There was an error running option $FUN" 20 40 1
      else
        exit 1
      fi
    done
}

#
# Main UI plugins menu
#
open_ui_menu() {
    calc_wt_size
    while true; do
      FUN=$(whiptail --title "OMV UI PLUGINS" --menu "Setup Options" $WT_HEIGHT $WT_WIDTH $WT_MENU_HEIGHT --cancel-button Back --ok-button Select \
        "1 <<<<< Back" "" \
        "2 Custom header config" "" \
         \
        3>&1 1>&2 2>&3)
      RET=$?
      if [ $RET -eq 1 ]; then
        open_main_menu
      elif [ $RET -eq 0 ]; then
        case "$FUN" in
          1\ *) open_main_menu ;;
          2\ *)
          do_header_backup
          open_custom_header_menu ;;
          *) whiptail --msgbox "Programmer error: unrecognized option" 20 40 1 ;;
        esac || whiptail --msgbox "There was an error running option $FUN" 20 40 1
      else
        exit 1
      fi
    done
}

#
# Main menu
#
open_main_menu() {
    calc_wt_size
    while true; do
      FUN=$(whiptail --title "OMV THEME v1.2.1" --menu "Setup Options" $WT_HEIGHT $WT_WIDTH $WT_MENU_HEIGHT --cancel-button Exit --ok-button Select \
        "1 Themes (CSS)" "" \
        "2 UI plugins (JS)" "" \
        "3 About" ""\
        "4 Update" "" \
        "5 Uninstall" "" \
         \
        3>&1 1>&2 2>&3)
      RET=$?
      if [ $RET -eq 1 ]; then
        do_finish
      elif [ $RET -eq 0 ]; then
        case "$FUN" in
          1\ *)
          do_css_backup
          open_theme_menu
          ;;
          2\ *) open_ui_menu ;;
          3\ *) do_about ;;
          4\ *) do_update_omv_theme ;;
          5\ *) do_uninstall ;;
          *) whiptail --msgbox "Programmer error: unrecognized option" 20 40 1 ;;
        esac || whiptail --msgbox "There was an error running option $FUN" 20 40 1
      else
        exit 1
      fi
    done
}

open_main_menu

