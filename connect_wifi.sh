#!/bin/bash
sudo ip link set wlp3s0 up
sleep 1
flag=true
function check_wifi {
  wifi_name=$(cat $1 | grep ssid | awk -F \" '{print $2}')
  if [[ $(sudo iwlist wlp3s0 scan | grep ESSID | grep -m 1 $wifi_name | awk -F \" '{print $2}') == $wifi_name ]];then
    if [[ $(ps -elf | grep wpa_supplicant | wc -l) > 1 ]];then
      sudo killall wpa_supplicant
      if [[ $(ps -elf | grep dhcpcd | wc -l) > 1 ]];then
        sudo killall dhcpcd
      fi
      sleep 2
    fi
   sudo wpa_supplicant -c $1 -i wlp3s0 &
  else
    echo "no found $wifi_name, please check wifi_name!"
    iwlist wlp3s0 scan | grep ESSID
    flag=false
  fi
}

if [ ! $1 ];then
  check_wifi ~/internet.conf
elif [ ! $2 ];then
  check_wifi $1
else
  if [[ $(sudo iwlist wlp3s0 scan | grep ESSID | grep -m 1 $1 | awk -F \" '{print $2}') == $1 ]];then
    if [[ $(ps -elf | grep wpa_supplicant | wc -l) > 1 ]];then
      sudo killall wpa_supplicant
      if [[ $(ps -elf | grep dhcpcd | wc -l) > 1 ]];then
        sudo killall dhcpcd
      fi
      sleep 2
    fi
	  wpa_passphrase $1 $2 > res_internet.conf
	  sleep 1
	  sudo wpa_supplicant -c res_internet.conf -i wlp3s0 &
	  sleep 1
	  rm res_internet.conf
  else
    echo "no found $1, please check wifi_name!"
    iwlist wlp3s0 scan | grep ESSID
    flag=false
  fi
fi
if [[ $flag == 'false' ]];then
  exit 0
fi
sleep 2
sudo dhcpcd &
sleep 3
while :
do
	ping www.baidu.com -c 2
	if [[ $? != 0 ]];then
		sleep 3
		continue
	else
		break
	fi
done
