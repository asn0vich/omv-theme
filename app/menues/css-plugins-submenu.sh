#!/bin/bash

header_bg_color_menu() {
    calc_wt_size
    while true; do
      FUN=$(whiptail --title "OMV CSS UI PLUGINS" --menu "Setup Options" $WT_HEIGHT $WT_WIDTH $WT_MENU_HEIGHT --cancel-button Back --ok-button Select \
        "1 <<<<< Back" "" \
        "2 Set and apply color" "" \
        "3 Revert to default" "" \
         \
        3>&1 1>&2 2>&3)
      RET=$?
      if [ $RET -eq 1 ]; then
        open_main_menu
      elif [ $RET -eq 0 ]; then
        case "$FUN" in
          1\ *) open_css_ui_menu ;;
          2\ *)
          remove_header_background_color
          set_header_background_color ;;
          3\ *) remove_header_background_color ;;
          *) whiptail --msgbox "Programmer error: unrecognized option" 20 40 1 ;;
        esac || whiptail --msgbox "There was an error running option $FUN" 20 40 1
      else
        exit 1
      fi
    done
}

header_bg_image_menu() {
    calc_wt_size
    while true; do
      FUN=$(whiptail --title "OMV CSS UI PLUGINS" --menu "Setup Options" $WT_HEIGHT $WT_WIDTH $WT_MENU_HEIGHT --cancel-button Back --ok-button Select \
        "1 <<<<< Back" "" \
        "2 Set and apply bg image" "" \
        "3 Revert to default" "" \
         \
        3>&1 1>&2 2>&3)
      RET=$?
      if [ $RET -eq 1 ]; then
        open_main_menu
      elif [ $RET -eq 0 ]; then
        case "$FUN" in
          1\ *) open_css_ui_menu ;;
          2\ *)
          remove_header_bg_img
          set_header_bg_img ;;
          3\ *) remove_header_bg_img ;;
          *) whiptail --msgbox "Programmer error: unrecognized option" 20 40 1 ;;
        esac || whiptail --msgbox "There was an error running option $FUN" 20 40 1
      else
        exit 1
      fi
    done
}

remove_header_menu() {
    calc_wt_size
    while true; do
      FUN=$(whiptail --title "OMV CSS UI PLUGINS" --menu "Setup Options" $WT_HEIGHT $WT_WIDTH $WT_MENU_HEIGHT --cancel-button Back --ok-button Select \
        "1 <<<<< Back" "" \
        "2 Remove header" "" \
        "3 Revert to default" "" \
         \
        3>&1 1>&2 2>&3)
      RET=$?
      if [ $RET -eq 1 ]; then
        open_main_menu
      elif [ $RET -eq 0 ]; then
        case "$FUN" in
          1\ *) open_css_ui_menu ;;
          2\ *)
          remove_hide_header
          set_hide_header ;;
          3\ *) remove_hide_header ;;
          *) whiptail --msgbox "Programmer error: unrecognized option" 20 40 1 ;;
        esac || whiptail --msgbox "There was an error running option $FUN" 20 40 1
      else
        exit 1
      fi
    done
}

font_menu() {
    calc_wt_size
    while true; do
      FUN=$(whiptail --title "OMV CSS UI PLUGINS" --menu "Setup Options" $WT_HEIGHT $WT_WIDTH $WT_MENU_HEIGHT --cancel-button Back --ok-button Select \
        "1 <<<<< Back" "" \
        "2 Set font size and weight" "" \
        "3 Revert to default" "" \
         \
        3>&1 1>&2 2>&3)
      RET=$?
      if [ $RET -eq 1 ]; then
        open_main_menu
      elif [ $RET -eq 0 ]; then
        case "$FUN" in
          1\ *) open_css_ui_menu ;;
          2\ *)
          remove_font_size_and_weight
          set_font_size_and_weight ;;
          3\ *) remove_font_size_and_weight ;;
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
        "4 Remove header" "" \
        "5 Font weight and size" "" \
         \
        3>&1 1>&2 2>&3)
      RET=$?
      if [ $RET -eq 1 ]; then
        open_main_menu
      elif [ $RET -eq 0 ]; then
        case "$FUN" in
          1\ *) open_main_menu ;;
          2\ *) header_bg_color_menu ;;
          3\ *) header_bg_image_menu ;;
          4\ *) remove_header_menu ;;
          5\ *) font_menu ;;
          *) whiptail --msgbox "Programmer error: unrecognized option" 20 40 1 ;;
        esac || whiptail --msgbox "There was an error running option $FUN" 20 40 1
      else
        exit 1
      fi
    done
}