# OMV Theme Changer

With this tool, you can easily switch between the GUI theme

### To install:         
`git clone https://github.com/virgil-av/omv-theme.git && cd omv-theme && chmod +x install-omv-theme.sh && ./install-omv-theme.sh && cd`

### To uninstall:       
Use the the uninstall option 

or

`  rm -r /var/www/openmediavault/css/theme-custom.*.css
   sed -i '126s/.*/$fileName = "css\/theme-custom.css";/' /usr/share/php/openmediavault/controlpanel/controlpanelabstract.inc
   rm -rf /root/omv-theme
   rm -r /usr/bin/omv-theme
   rm -r /usr/bin/omv-theme-update`

### To Start:                                       
`omv-theme`

### To Update:                                       
`omv-theme`
Select the Update option

### Screenshots: 

![alt text](https://preview.ibb.co/ivZXKK/Selection_001.png "")
![alt text](https://preview.ibb.co/mQkTte/Selection_002.png "")
![alt text](https://preview.ibb.co/fqYvTp/Selection_012.png "")
![alt text](https://preview.ibb.co/bxfHmz/Selection_010.png "")
![alt text](https://preview.ibb.co/kbygDe/Selection_008.png "")
![alt text](https://preview.ibb.co/eqaHmz/Selection_011.png "")
![alt text](https://preview.ibb.co/c4xYEU/Selection_013.png "")
![alt text](https://preview.ibb.co/fR7B19/Selection_014.png "")


## How to

### Create a new CSS theme

- create a new `theme-your-theme-name.scss`
- you can copy one of the previous themes or start from base `theme-triton.scss`
- all the custom themes are based on triton with almost all colors as variables
- all variables should be at the top, change them to your liking, if you add more even better
- did not ope around in the javascript as time was short, will poke around soon enough
- poke around and change things, I got some really ugly things until I got some decent ones
- compile the sass file to css you can use `https://www.sassmeister.com/` or google sass to css

### To live test the new theme with no consequences

- better to have a custom theme enabled already as this overwrites triton
- open your browser and navigate to your OMV server and login to your dashboard
- In chrome press `F12` and click on `sources` now on the left menu you should have a tree of folders and one of them is `css` expand this folder and click on `theme-custom.css` (should hav this if you have installed a custom theme and switched to it)
- Paste your css in `theme-custom.css` and you will see your changes in the browser, they get updated without refresh

### To add the new theme in the selection menu
- open `omv-theme.sh`
- create new function:

```bash
do_omv_custom_theme() {
    echo 'OMV_WEBUI_THEME=triton' >> /etc/default/openmediavault
    rm -r /var/www/openmediavault/css/theme-custom.*.css
    cp /root/omv-theme/theme-your-theme-name.css /var/www/openmediavault/css/theme-custom.theme-your-theme-name.css
    sed -i '126s/.*/$fileName = "css\/theme-custom.theme-your-theme-name.css";/' /usr/share/php/openmediavault/controlpanel/controlpanelabstract.inc
    exec omv-theme
}
```
- /var/www/openmediavault/css/theme-custom.`theme-your-theme-name`.css keep the naming convention
- sed -i '126s/.*/$fileName = "css\/`theme-custom.theme-your-theme-name.css`" the highlighted part needs to mach the file name you did in the previous line
- add the theme to the theme menu, edit below code 
```bash
open_theme_menu() {
    calc_wt_size
    while true; do
      FUN=$(whiptail --title "OMV CSS THEMES" --menu "Setup Options" $WT_HEIGHT $WT_WIDTH $WT_MENU_HEIGHT --cancel-button Back --ok-button Select \
        "1 <<<<< Back" "" \
        "2 Theme Default" "" \
        "3 Theme Blackish" "" \
        "4 Theme Sour Cherry" "" \
        "5 Theme Green Peace" "" \
        "6 Theme Old Gold" "" \
         \
        3>&1 1>&2 2>&3)
      RET=$?
      if [ $RET -eq 1 ]; then
        open_main_menu
      elif [ $RET -eq 0 ]; then
        case "$FUN" in
          1\ *) open_main_menu ;;
          2\ *) do_omv_triton ;;
          3\ *) do_omv_black ;;
          4\ *) do_omv_cherry ;;
          5\ *) do_omv_green ;;
          6\ *) do_omv_old_gold ;;
          *) whiptail --msgbox "Programmer error: unrecognized option" 20 40 1 ;;
        esac || whiptail --msgbox "There was an error running option $FUN" 20 40 1
      else
        exit 1
      fi
    done
}
```
- to this
```bash
open_theme_menu() {
    calc_wt_size
    while true; do
      FUN=$(whiptail --title "OMV CSS THEMES" --menu "Setup Options" $WT_HEIGHT $WT_WIDTH $WT_MENU_HEIGHT --cancel-button Back --ok-button Select \
        "1 <<<<< Back" "" \
        "2 Theme Default" "" \
        "3 Theme Blackish" "" \
        "4 Theme Sour Cherry" "" \
        "5 Theme Green Peace" "" \
        "6 Theme Old Gold" "" \
        "7 Theme Your Custom Theme Name" "" \
         \
        3>&1 1>&2 2>&3)
      RET=$?
      if [ $RET -eq 1 ]; then
        open_main_menu
      elif [ $RET -eq 0 ]; then
        case "$FUN" in
          1\ *) open_main_menu ;;
          2\ *) do_omv_triton ;;
          3\ *) do_omv_black ;;
          4\ *) do_omv_cherry ;;
          5\ *) do_omv_green ;;
          6\ *) do_omv_old_gold ;;
          7\ *) do_omv_custom_theme ;;
          *) whiptail --msgbox "Programmer error: unrecognized option" 20 40 1 ;;
        esac || whiptail --msgbox "There was an error running option $FUN" 20 40 1
      else
        exit 1
      fi
    done
}
```


### Or Submit the theme
- Please send the sass file, I ok with the CSS too but I prefer SASS
- On the forum http://forum.openmediavault.org/index.php/Thread/24286-New-omv-theme-changer-based-on-Wolf2000Pi-omv-theme/
- On github
                                    


