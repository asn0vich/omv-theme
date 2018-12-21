#!/bin/bash

################################################################
# functional and information

do_about() {
  whiptail --msgbox "\
  OMV THEME CHANGER

  A simple tool that allows you to switch omv themes, apply custom css and functionality.
  Project is hosted on https://github.com/virgil-av/omv-theme.git

  Project maintained by Virgil A. JavaScript Frontend developer.

  Theme is compatible with OMV v4.x (possible compatibility with v3.x and v2.x)

  Use this tool at your own risk, I take no responsibility if this tool damages your server in any way.

  If you encounter any problems check the omv forum: https://forum.openmediavault.org/index.php/Thread/24286

" 20 70 1
}

do_update_omv_theme() {
  # do update
  cd ~
  # remove old code and pull the new one
  rm -rf /root/omv-theme
  git clone https://github.com/virgil-av/omv-theme.git
  cd /root/omv-theme

  # make main scripts executable
  chmod +x omv-theme.sh
  # clean scripts from /usr/bin
  rm -rf /usr/bin/omv-theme
  # copy and create scripts for execution
  cp /root/omv-theme/omv-theme.sh /usr/bin/omv-theme

  exec omv-theme
}

do_uninstall() {
  # remove custom theme
  remove_custom_theme
  # remove custom js
  remove_snow_plugin
  remove_header_text_or_logo
  remove_workspace_js_backup
  # remove custom css
  remove_header_background_color
  remove_hide_header
  remove_header_bg_img
  remove_font_size_and_weight

  # do uninstall
  rm -rf /var/www/openmediavault/css/theme-custom.*.css
  rm -rf /root/omv-theme
  rm -rf /usr/bin/omv-theme
  exit 1
}