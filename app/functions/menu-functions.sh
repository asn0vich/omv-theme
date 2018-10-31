#!/bin/bash

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
  # remove old code and pull the new one
  rm -rf /root/omv-theme
  git clone https://github.com/virgil-av/omv-theme.git
  cd /root/omv-theme

  # make main scripts executable
  chmod +x omv-theme.sh
  chmod +x omv-theme2.sh

  # clean scripts from /usr/bin
  rm -r /usr/bin/omv-theme
  rm -r /usr/bin/omv-theme2

  # copy and create scripts for execution
  cp /root/omv-theme/omv-theme.sh /usr/bin/omv-theme

  echo "#!/bin/bash" >> /usr/bin/omv-theme2
  chmod +x /usr/bin/omv-theme2
  echo "cd /root/omv-theme/" >> /usr/bin/omv-theme2
  echo "/bin/bash omv-theme2.sh" >> /usr/bin/omv-theme2

  exec omv-theme
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