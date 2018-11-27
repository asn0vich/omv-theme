#!/bin/bash

#
# Main menu
#
open_main_menu() {
    calc_wt_size
    while true; do
      FUN=$(whiptail --title "OMV THEME v1.7.1" --menu "Setup Options" $WT_HEIGHT $WT_WIDTH $WT_MENU_HEIGHT --cancel-button Exit --ok-button Select \
        "1 Themes" "" \
        "2 JS plugins " "" \
        "3 CSS plugins " "" \
        "4 About" ""\
        "5 Update" "" \
        "6 Uninstall" "" \
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
          3\ *) open_css_ui_menu ;;
          4\ *) do_about ;;
          5\ *) do_update_omv_theme ;;
          6\ *) do_uninstall ;;
          *) whiptail --msgbox "Programmer error: unrecognized option" 20 40 1 ;;
        esac || whiptail --msgbox "There was an error running option $FUN" 20 40 1
      else
        exit 1
      fi
    done
}