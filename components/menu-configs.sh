#!/bin/bash
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
  do_revert_header
  do_omv_triton
  # do update
  cd ~
  exec omv-theme-update
}

do_uninstall() {
  # revert plugins before update
  do_revert_header
  do_omv_triton
  # do uninstall

  rm -r /var/www/openmediavault/css/theme-custom.*.css
  rm -rf /root/omv-theme
  rm -r /usr/bin/omv-theme
  rm -r /usr/bin/omv-theme2
  rm -r /usr/bin/omv-theme-update
  exit 1
}