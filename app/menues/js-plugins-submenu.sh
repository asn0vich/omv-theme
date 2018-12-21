#!/bin/bash

#
# Custom text header menu
#

open_custom_header_text_menu() {
    calc_wt_size
    while true; do
      FUN=$(whiptail --title "OMV CUSTOM TEXT HEADER" --menu "Setup Options" $WT_HEIGHT $WT_WIDTH $WT_MENU_HEIGHT --cancel-button Back --ok-button Select \
        "1 <<<<< Back" "" \
        "2 Set header text" "" \
        "3 Revert changes" "" \
         \
        3>&1 1>&2 2>&3)
      RET=$?
      if [ $RET -eq 1 ]; then
        open_ui_menu
      elif [ $RET -eq 0 ]; then
        case "$FUN" in
          1\ *) open_ui_menu ;;
          2\ *) set_header_text ;;
          3\ *) remove_header_text_or_logo ;;
          *) whiptail --msgbox "Programmer error: unrecognized option" 20 40 1 ;;
        esac || whiptail --msgbox "There was an error running option $FUN" 20 40 1
      else
        exit 1
      fi
    done
}

#
# Custom logo header menu
#

open_custom_header_logo_menu() {
    calc_wt_size
    while true; do
      FUN=$(whiptail --title "OMV CUSTOM LOGO HEADER" --menu "Setup Options" $WT_HEIGHT $WT_WIDTH $WT_MENU_HEIGHT --cancel-button Back --ok-button Select \
        "1 <<<<< Back" "" \
        "2 Set logo" "" \
        "3 Revert changes" "" \
         \
        3>&1 1>&2 2>&3)
      RET=$?
      if [ $RET -eq 1 ]; then
        open_ui_menu
      elif [ $RET -eq 0 ]; then
        case "$FUN" in
          1\ *) open_ui_menu ;;
          2\ *) set_header_logo ;;
          3\ *) remove_header_text_or_logo ;;
          *) whiptail --msgbox "Programmer error: unrecognized option" 20 40 1 ;;
        esac || whiptail --msgbox "There was an error running option $FUN" 20 40 1
      else
        exit 1
      fi
    done
}

#
# Custom logo header menu
#

open_make_it_snow_menu() {
    calc_wt_size
    while true; do
      FUN=$(whiptail --title "OMV Make it snow" --menu "Setup Options" $WT_HEIGHT $WT_WIDTH $WT_MENU_HEIGHT --cancel-button Back --ok-button Select \
        "1 <<<<< Back" "" \
        "2 Make it snow" "" \
        "3 No more snow please" "" \
         \
        3>&1 1>&2 2>&3)
      RET=$?
      if [ $RET -eq 1 ]; then
        open_ui_menu
      elif [ $RET -eq 0 ]; then
        case "$FUN" in
          1\ *) open_ui_menu ;;
          2\ *) do_snow ;;
          3\ *) remove_snow_plugin ;;
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
        "2 Custom text header config" "" \
        "3 Custom logo header config" "" \
        "4 Make it snow" "" \
         \
        3>&1 1>&2 2>&3)
      RET=$?
      if [ $RET -eq 1 ]; then
        open_main_menu
      elif [ $RET -eq 0 ]; then
        case "$FUN" in
          1\ *) open_main_menu ;;
          2\ *)
          backup_workspace_js
          open_custom_header_text_menu ;;
          3\ *)
          backup_workspace_js
          open_custom_header_logo_menu ;;
          4\ *) open_make_it_snow_menu ;;
          *) whiptail --msgbox "Programmer error: unrecognized option" 20 40 1 ;;
        esac || whiptail --msgbox "There was an error running option $FUN" 20 40 1
      else
        exit 1
      fi
    done
}