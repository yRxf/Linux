#!/bin/bash
# sudo ip link set wlp3s0 up
# sleep 1
# if [ ! $1 ];then
# 	sudo wpa_supplicant -c internet.conf -i wlp3s0 &
# elif [ ! $2 ];then
# 	sudo wpa_supplicant -c $1 -i wlp3s0 &
# else
# 	wpa_passphrase $1 $2 > res_internet.conf
# 	sleep 1
# 	sudo wpa_supplicant -c res_internet.conf -i wlp3s0 &
# 	sleep 1
# 	rm res_internet.conf
# fi
bash ~/connect_wifi.sh $1 $2
# systemctl restart openntpd 
#if [[ $(xrandr -q | grep "HDMI1 connected") ]];then
#  xrandr --output HDMI1 --auto
#fi
sleep 2
startx
# sh -c "st -ie bash buletooth_key.sh"
