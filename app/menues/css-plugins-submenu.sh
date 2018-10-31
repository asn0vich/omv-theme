#!/bin/bash


open_header_background_color_menu() {
    calc_wt_size
    while true; do
      FUN=$(whiptail --title "OMV CSS UI PLUGINS" --menu "Setup Options" $WT_HEIGHT $WT_WIDTH $WT_MENU_HEIGHT --cancel-button Back --ok-button Select \
        "1 <<<<< Back" "" \
        "2 Set and apply background color" "" \
        "3 Revert to default" "" \
         \
        3>&1 1>&2 2>&3)
      RET=$?
      if [ $RET -eq 1 ]; then
        open_main_menu
      elif [ $RET -eq 0 ]; then
        case "$FUN" in
          1\ *) open_css_ui_menu ;;
          2\ *) set_header_background_color ;;
          3\ *) ;;
          *) whiptail --msgbox "Programmer error: unrecognized option" 20 40 1 ;;
        esac || whiptail --msgbox "There was an error running option $FUN" 20 40 1
      else
        exit 1
      fi
    done
}


#
# Main CSS UI plugins menu
#
open_css_ui_menu() {
    calc_wt_size
    while true; do
      FUN=$(whiptail --title "OMV CSS UI PLUGINS" --menu "Setup Options" $WT_HEIGHT $WT_WIDTH $WT_MENU_HEIGHT --cancel-button Back --ok-button Select \
        "1 <<<<< Back" "" \
        "2 Header background color" "" \
        "3 Header background image" "" \
        "4 Header background image y axis" "" \
         \
        3>&1 1>&2 2>&3)
      RET=$?
      if [ $RET -eq 1 ]; then
        open_main_menu
      elif [ $RET -eq 0 ]; then
        case "$FUN" in
          1\ *) open_main_menu ;;
          2\ *) open_header_background_color_menu ;;
          3\ *)
          do_header_backup
          open_custom_header_logo_menu ;;
          *) whiptail --msgbox "Programmer error: unrecognized option" 20 40 1 ;;
        esac || whiptail --msgbox "There was an error running option $FUN" 20 40 1
      else
        exit 1
      fi
    done
}