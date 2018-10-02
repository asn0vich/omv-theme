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

### Check the theme
- always remember to clear the UI cache you can do that in the browser or from `omv-firstaid`
- clearing browser cache F12 and then right click on the refresh button and select clear cache

### To start a new theme:

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
- add the theme to the menu 
```bash
...
    "1 About" "" \
    "2 Update" "" \
    "3 Uninstall" ""\
    "4 Theme Default" "" \
    "5 Theme Blackish" "" \
    "6 Theme Sour Cherry" "" \
    "7 Theme Green Peace" "" \
    "8 My theme" "" \
...
      1\ *) do_about ;;
      2\ *) do_update_omv_theme ;;
      3\ *) do_uninstall ;;
      4\ *) do_omv_triton ;;
      5\ *) do_omv_black ;;
      6\ *) do_omv_cherry ;;
      7\ *) do_omv_green ;;
      8\ *) do_omv_custom_theme ;;
...      
```

### Submit a theme
- Pull Request on github would be really nice and clean
- If not familiar with previous just open a issue and paste the scss files and I will do the rest



This is a fork from `github/Wolf2000Pi/omv-theme`, I am a total noob at bash, thank you for creating this.                                       


