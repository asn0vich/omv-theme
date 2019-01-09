#!/bin/bash

#
# Theme menu
#
open_theme_menu() {
    calc_wt_size
    while true; do
      FUN=$(whiptail --title "OMV CSS THEMES" --menu "Setup Options" $WT_HEIGHT $WT_WIDTH $WT_MENU_HEIGHT --cancel-button Back --ok-button Select \
        "1 <<<<< Back" "" \
        "2 Restore Default" "" \
        "3 Theme Blackish" "" \
        "4 Theme Sour Cherry" "" \
        "5 Theme Green Peace" "" \
        "6 Theme Old Gold" "" \
        "7 Theme Condensed Black" "" \
        "8 Theme Black and White" "" \
        "9 Theme Santa's Elf" "" \
        "10 Theme Dracula v1.1" "" \
         \
        3>&1 1>&2 2>&3)
      RET=$?
      if [ $RET -eq 1 ]; then
        open_main_menu
      elif [ $RET -eq 0 ]; then
        case "$FUN" in
          1\ *) open_main_menu ;;
          2\ *) remove_custom_theme ;;
          3\ *) apply_theme "theme-blackish" ;;
          4\ *) apply_theme "theme-sour-cherry" ;;
          5\ *) apply_theme "theme-green-peace" ;;
          6\ *) apply_theme "theme-old-gold" ;;
          7\ *) apply_theme "theme-condensed-black" ;;
          8\ *) apply_theme "theme-black-and-white" ;;
          9\ *) apply_theme "theme-santas-elf" ;;
          10\ *) apply_theme "theme-dracula" ;;
          *) whiptail --msgbox "Programmer error: unrecognized option" 20 40 1 ;;
        esac || whiptail --msgbox "There was an error running option $FUN" 20 40 1
      else
        exit 1
      fi
    done
}