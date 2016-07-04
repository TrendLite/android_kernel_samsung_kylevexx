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
        "KYLEVE")
mkdir tmp
cd tmp
cp -f ../arch/arm/boot/zImage ./zImage
cp ../arch/arm/tools/boot.img-ramdisk-kyleve ./boot.img-ramdisk.cpio.gz
cp ../arch/arm/tools/mkbootimg ./mkbootimg
chmod 775 mkbootimg
echo "Creating boot.img"
./mkbootimg --kernel zImage --ramdisk boot.img-ramdisk.cpio.gz --board kyleve --pagesize 4096 --base 0x82000000 -o boot.img
cd ..
mv -f tmp/boot.img boot.img
if [ "$?" -ne "0" ]; then
  echo "$red ERROR : $default $blue Failed to make boot.img $default"
rm -rf tmp
  exit 1
fi

echo "$red boot.img is ready at :$default $blue $(pwd)/boot.img $default "
rm -rf tmp

            ;;
        "KYLEVESS")
mkdir tmp
cd tmp
cp -f ../arch/arm/boot/zImage ./zImage
cp ../arch/arm/tools/boot.img-ramdisk-kylevess ./boot.img-ramdisk.cpio.gz
cp ../arch/arm/tools/mkbootimg ./mkbootimg
chmod 775 mkbootimg
echo "Creating boot.img"
./mkbootimg --kernel zImage --ramdisk boot.img-ramdisk.cpio.gz --board kyleve --pagesize 4096 --base 0x82000000 -o boot.img
cd ..
mv -f tmp/boot.img boot.img
if [ "$?" -ne "0" ]; then
  echo "$red ERROR : $default $blue Failed to make boot.img $default"
rm -rf tmp
  exit 1
fi

echo "$red boot.img is ready at :$default $blue $(pwd)/boot.img $default "
rm -rf tmp



            ;;
        "GO BACK")
default_menu
clear
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
clear
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


