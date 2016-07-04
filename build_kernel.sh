#!/bin/bash
green=`tput setaf 2`
red=`tput setaf 1`
blue=`tput setaf 4`
default=`tput sgr0`
PS3='Please enter your choice: '
function boot
{
HEIGHT=15
WIDTH=40
CHOICE_HEIGHT=4
BACKTITLE="Boot.img"
TITLE="COMPILE BOOT.IMG FOR ? :-"
MENU="Choose one of the following options:"

OPTIONS=(1 "KYLEVE"
         2 "KYLEVESS"
         3 "QUIT")

CHOICE=$(dialog --clear \
                --backtitle "$BACKTITLE" \
                --title "$TITLE" \
                --menu "$MENU" \
                $HEIGHT $WIDTH $CHOICE_HEIGHT \
                "${OPTIONS[@]}" \
                2>&1 >/dev/tty)

clear
case $CHOICE in
        1)
            echo "You chose Option 1"
            ;;
        2)
            echo "You chose Option 2"
            ;;
        3)
            echo "You chose Option 3"
            ;;

esac
}

function make_zip
{
HEIGHT=15
WIDTH=40
CHOICE_HEIGHT=4
BACKTITLE="ZIP"
TITLE="MAKE FLASHABLE ZIP FOR ? :-"
MENU="Choose one of the following options:"

OPTIONS=(1 "KYLEVE"
         2 "KYLEVESS"
         3 "QUIT")

CHOICE=$(dialog --clear \
                --backtitle "$BACKTITLE" \
                --title "$TITLE" \
                --menu "$MENU" \
                $HEIGHT $WIDTH $CHOICE_HEIGHT \
                "${OPTIONS[@]}" \
                2>&1 >/dev/tty)

clear
case $CHOICE in
        1)
            echo "You chose Option 1"
            ;;
        2)
            echo "You chose Option 2"
            ;;
        3)
            echo "You chose Option 3"
            ;;

esac
}

options=("$blue KYLEVE $default" "$green KYLEVESS $default" "$red CLEAN $default" "MAKE BOOT" "MAKE FLASHABLE ZIP" )
select opt in "${options[@]}"
do
    case $opt in
        "$blue KYLEVE $default")
tput setaf 4
make -j4 bcm21664_hawaii_ss_kyleve_rev00_defconfig
tput sgr0
make -j4
exit
            ;;
        "$green KYLEVESS $default" )
tput setaf 2
make -j4 bcm21664_hawaii_ss_kylevess_rev00_defconfig
tput sgr0
make -j4
exit
            ;;
        "$red CLEAN $default")
tput setaf 1
make -j4 mrproper
echo -e "$blue Made clean $default"
tput sgr0
clear
clear
exit
;;
        "MAKE BOOT")
boot
exit
;;
        "MAKE FLASHABLE ZIP")
make_zip
exit
            break
            ;;
        *) echo invalid option;;
    esac
done



