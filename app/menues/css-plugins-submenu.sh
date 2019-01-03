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
          remove_header_bg_img
          remove_hide_header
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
          remove_header_background_color
          remove_header_bg_img
          remove_hide_header
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
          remove_header_background_color
          remove_header_bg_img
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
        "2 Revert all css changes" "" \
        "3 Header background color" "" \
        "4 Header background image" "" \
        "5 Remove header" "" \
        "6 Font weight and size" "" \
         \
        3>&1 1>&2 2>&3)
      RET=$?
      if [ $RET -eq 1 ]; then
        open_main_menu
      elif [ $RET -eq 0 ]; then
        case "$FUN" in
          1\ *) open_main_menu ;;
          2\ *) fix_default_css ;;
          3\ *) header_bg_color_menu ;;
          4\ *) header_bg_image_menu ;;
          5\ *) remove_header_menu ;;
          6\ *) font_menu ;;
          *) whiptail --msgbox "Programmer error: unrecognized option" 20 40 1 ;;
        esac || whiptail --msgbox "There was an error running option $FUN" 20 40 1
      else
        exit 1
      fi
    done
}