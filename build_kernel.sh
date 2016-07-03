#!/bin/bash
green=`tput setaf 2`
red=`tput setaf 1`
blue=`tput setaf 4`
default=`tput sgr0`
PS3='Please enter your choice: '
options=("$blue KYLEVE $default" "$green KYLEVESS $default" "$red CLEAN $default" )
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
exit
            break
            ;;
        *) echo invalid option;;
    esac
done

