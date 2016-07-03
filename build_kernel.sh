#!/bin/bash
PS3='Please enter your choice: '
options=("KYLEVE" "KYLEVESS" "CLEAN" )
select opt in "${options[@]}"
do
    case $opt in
        "KYLEVE")
tput setaf 1
make -j4 bcm21664_hawaii_ss_kyleve_rev00_defconfig
tput sgr0
make -j4
exit
            ;;
        "KYLEVESS")
tput setaf 2
make -j4 bcm21664_hawaii_ss_kylevess_rev00_defconfig
tput sgr0
make -j4
exit
            ;;
        "CLEAN")
tput setaf 4
make -j4 clean
tput sgr0
exit
            break
            ;;
        *) echo invalid option;;
    esac
done

