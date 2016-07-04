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
if [ "$?" -ne "0" ]; then
  echo "$red ERROR : $default $blue You should compile kernel first $default"
rm -rf tmp
  exit 1
fi
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
if [ "$?" -ne "0" ]; then
  echo "$red ERROR : $default $blue You should compile kernel first $default"
rm -rf tmp
  exit 1
fi
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
options=("KYLEVE" "KYLEVESS" "GO BACK" "Quit")
select opt in "${options[@]}"
do
    case $opt in
        "KYLEVE")
mkdir tmp
cd tmp
cp ../boot.img boot.img
if [ "$?" -ne "0" ]; then
  echo "$red ERROR : $default $blue You should compile kernel and make boot.img $default"
rm -rf tmp
  exit 1
fi
cp ../arch/arm/tools/META-INF_kyleve ./META-INF.zip
unzip META-INF.zip
rm META-INF.zip
mkdir system
mkdir system/lib
mkdir system/lib/modules
cd ../
rsync -r `find -type f -name "*.ko" ` tmp/system/lib/modules/
cd tmp
cp ../boot.img boot.img
zip -r tmp META-INF boot.img system
cd .. 
mv -f tmp/tmp.zip kernel-$(date +%Y%m%d)-3.5.7-UNOFFICIAL-kyleve.zip
if [ "$?" -ne "0" ]; then
  echo "$red ERROR : $default $blue Failed copy zip  $default"
rm -rf tmp
  exit 1
fi
echo "$red Flashable zip is ready   :$default $blue $(pwd)/kernel-$(date +%Y%m%d)-3.5.7-UNOFFICIAL-kyleve.zip $default "

rm -rf tmp
exit
            ;;
        "KYLEVESS")
mkdir tmp
cd tmp
cp ../boot.img boot.img
if [ "$?" -ne "0" ]; then
  echo "$red ERROR : $default $blue You should compile kernel and make boot.img $default"
rm -rf tmp
  exit 1
fi
cp ../arch/arm/tools/META-INF_kylevess ./META-INF.zip
unzip META-INF.zip
rm META-INF.zip
mkdir system
mkdir system/lib
mkdir system/lib/modules
cd ../
rsync -r `find -type f -name "*.ko" ` tmp/system/lib/modules/
cd tmp
cp ../boot.img boot.img
zip -r tmp META-INF boot.img system
cd .. 
mv -f tmp/tmp.zip kernel-$(date +%Y%m%d)-3.5.7-UNOFFICIAL-kylevess.zip
if [ "$?" -ne "0" ]; then
  echo "$red ERROR : $default $blue Failed copy zip  $default"
rm -rf tmp
  exit 1
fi
echo "$red Flashable zip is ready   :$default $blue $(pwd)/kernel-$(date +%Y%m%d)-3.5.7-UNOFFICIAL-kylevess.zip $default "

rm -rf tmp
exit
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
options=("KYLEVE" "KYLEVESS" "CLEAN" "MAKE BOOT" "MAKE FLASHABLE ZIP" "QUIT")
select opt in "${options[@]}"
do
    case $opt in
        "KYLEVE")
tput setaf 4
make -j4 bcm21664_hawaii_ss_kyleve_rev00_defconfig
tput sgr0
make -j4
exit
            ;;
        "KYLEVESS" )
tput setaf 2
make -j4 bcm21664_hawaii_ss_kylevess_rev00_defconfig
tput sgr0
make -j4
exit
            ;;
        "CLEAN")
tput setaf 1
make -j4 mrproper
echo -e "Made clean"
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


