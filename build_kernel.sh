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
        "KYLEVE")
$blue
make -j4 bcm21664_hawaii_ss_kyleve_rev00_defconfig
$default
make -j4
exit
            ;;
        "KYLEVESS " )
$green
make -j4 bcm21664_hawaii_ss_kylevess_rev00_defconfig
$default
make -j4
exit
            ;;
        "CLEAN")
$red
make -j4 clean
$default
exit
            break
            ;;
        *) echo invalid option;;
    esac
done

