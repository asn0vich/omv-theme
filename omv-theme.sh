#!/bin/sh
# Project forked from https://github.com/Wolf2000Pi/omv-theme Version 1.0.2 by Wolf2000

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

do_about() {
  whiptail --msgbox "\
Project forked from https://github.com/Wolf2000Pi/omv-theme Version 1.0.2 by Wolf2000.
Check https://github.com/virgil-av/omv-theme.git for updates and how to guide.

Project maintained by Virgil Avram @ 2018
Plugin is meant vor OpenMediaVault v4.x
" 20 70 1
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



do_omv_triton() {
echo 'OMV_WEBUI_THEME=triton' >> /etc/default/openmediavault
rm -r /var/www/openmediavault/css/theme-custom.*.css
sed -i '126s/.*/$fileName = "css\/theme-custom.css";/' /usr/share/php/openmediavault/controlpanel/controlpanelabstract.inc
exec omv-theme
}

do_omv_black() {
echo 'OMV_WEBUI_THEME=triton' >> /etc/default/openmediavault
rm -r /var/www/openmediavault/css/theme-custom.*.css
cp /root/omv-theme/theme-black.css /var/www/openmediavault/css/theme-custom.black.css
sed -i '126s/.*/$fileName = "css\/theme-custom.black.css";/' /usr/share/php/openmediavault/controlpanel/controlpanelabstract.inc
exec omv-theme
}

do_omv_cherry() {
echo 'OMV_WEBUI_THEME=triton' >> /etc/default/openmediavault
rm -r /var/www/openmediavault/css/theme-custom.*.css
cp /root/omv-theme/theme-sour-cherry.css /var/www/openmediavault/css/theme-custom.sour-cherry.css
sed -i '126s/.*/$fileName = "css\/theme-custom.sour-cherry.css";/' /usr/share/php/openmediavault/controlpanel/controlpanelabstract.inc
exec omv-theme
}

do_omv_green() {
echo 'OMV_WEBUI_THEME=triton' >> /etc/default/openmediavault
rm -r /var/www/openmediavault/css/theme-custom.*.css
cp /root/omv-theme/theme-green-peace.css /var/www/openmediavault/css/theme-custom.green-peace.css
sed -i '126s/.*/$fileName = "css\/theme-custom.green-peace.css";/' /usr/share/php/openmediavault/controlpanel/controlpanelabstract.inc
exec omv-theme
}

do_update_omv_theme() {
  cd ~
  exec omv-theme-update
}

do_uninstall() {
  rm -r /var/www/openmediavault/css/theme-custom.*.css
  sed -i '126s/.*/$fileName = "css\/theme-custom.css";/' /usr/share/php/openmediavault/controlpanel/controlpanelabstract.inc
  rm -rf /root/omv-theme
  rm -r /usr/bin/omv-theme
  rm -r /usr/bin/omv-theme-update
}


#
# Interactive use loop
#
calc_wt_size
while true; do
  FUN=$(whiptail --title "OMV GUI-Theme config" --menu "Setup Options" $WT_HEIGHT $WT_WIDTH $WT_MENU_HEIGHT --cancel-button Exit --ok-button Select \
    "1 About" "" \
    "2 Update" "" \
    "3 Uninstall" ""\
    "4 Theme Default" "" \
    "5 Theme Blackish" "" \
    "6 Theme Sour Cherry" "" \
    "7 Theme Green Peace" "" \
     \
    3>&1 1>&2 2>&3)
  RET=$?
  if [ $RET -eq 1 ]; then
    do_finish
  elif [ $RET -eq 0 ]; then
    case "$FUN" in
      1\ *) do_about ;;
	  2\ *) do_update_omv_theme ;;
	  3\ *) do_uninstall ;;
      4\ *) do_omv_triton ;;
      5\ *) do_omv_black ;;
      6\ *) do_omv_cherry ;;
      7\ *) do_omv_green ;;
      *) whiptail --msgbox "Programmer error: unrecognized option" 20 40 1 ;;
    esac || whiptail --msgbox "There was an error running option $FUN" 20 40 1
  else
    exit 1
  fi
done