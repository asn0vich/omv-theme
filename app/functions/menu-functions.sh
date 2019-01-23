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

    echo "Check if previous omv-theme folder exists and delete them"
    rm -rf /root/omv-theme
    rm -rf /usr/bin/omv-theme

    echo "Creating omv-theme folder"
    cd /root/
    mkdir omv-theme
    cd omv-theme/

    echo "Pulling omv-theme from git repo..."
    wget --no-check-certificate https://github.com/virgil-av/omv-theme/archive/develop.tar.gz

    echo "extracting omv-theme to /root/omv-theme"

    tar -zxvf develop.tar.gz
    mv omv-theme-develop/* ./
    rm -rf master.tar.gz omv-theme-develop/

    echo "Creating executable omv-theme"
    chmod u+x install-omv-theme.sh
    ./install-omv-theme.sh

}

do_uninstall() {
  # remove custom theme
  apply_theme "default"
  # remove custom js
  remove_snow_plugin
  remove_header_text_or_logo
  remove_workspace_js_backup
  # remove custom css
  remove_header_background_color
  remove_hide_header
  remove_header_bg_img
  remove_font_size_and_weight

  # remove app
  rm -rf /root/omv-theme
  rm -rf /usr/bin/omv-theme
  exit 1
}