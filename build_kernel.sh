#!/bin/bash
green=`tput setaf 2`
red=`tput setaf 1`
blue=`tput setaf 4`
default=`tput sgr0`
PS3='Please enter your choice: '
function boot
{
clear
PS3='Please enter your choice: '
options=("KYLEVE" "KYLEVESS" "GO BACK" "Quit")
select opt in "${options[@]}"
do
    case $opt in
        "Option 1")
            echo "you chose choice 1"
            ;;
        "Option 2")
            echo "you chose choice 2"
            ;;
        "Option 3")
            echo "you chose choice 3"
            ;;
        "Quit")
            break
            ;;
        *) echo invalid option;;
    esac
done
}

function make_zip
{
clear
PS3='Please enter your choice: '
options=("KYLEVE" "KYLEVE" "GO BACK" "Quit")
select opt in "${options[@]}"
do
    case $opt in
        "KYLEVE")
            echo "you chose choice 1"
            ;;
        "KYLEVE")
            echo "you chose choice 2"
            ;;
        "GO BACK")
            default_menu
            ;;
        "Quit")
            break
            ;;
        *) echo invalid option;;
    esac
done
}
function default_menu
{
options=("$blue KYLEVE $default" "$green KYLEVESS $default" "$red CLEAN $default" "MAKE BOOT" "MAKE FLASHABLE ZIP" "QUIT")
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
;;
        "QUIT")
exit
            break
            ;;
        *) echo invalid option;;
    esac
done
}
default_menu


