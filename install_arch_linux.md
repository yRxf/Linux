https://www.bilibili.com/video/BV11J411a7Tp  
https://wiki.archlinux.org/index.php/Installation_guide  
setfont /usr/share/kbd/consolefonts/LatGrkCyr-12x22.psfu.gz    #��������  
#���Դ���һ���ļ�ȥ���ļ�λ  vim keys.conf  
keycode 1 = Caps_Lock		#keycode 1 ��esc��������Caps_Lock��ӳ��Ϊesc  
keycode 58 = Escape  
(https://blog.csdn.net/whsbk/article/details/79827680)  
keycode 58 = Control  
keycode 100 = Caps_Lock  
#�����˳�  
loadkeys keys.conf		#���ļ�λ  
alias c=clear		#��c����  
  
ip link 		#�鿴��ǰ����  wlan0  Ϊwifi����  
ip link set wlan0 up	#���Դ򿪿���  
iwlist wlan0 scan	#�鿴��ǰ��������wifi  
iwlist wlan0 scan | grep ESSID  #����wifi����  
wpa_passphrase wifi���� ���� > internet.conf ���ļ�����  
wpa_supplicant -c internet.conf -i wlan0 &	#-c ֮ǰ���ɵ������ļ� -i ���ӵ��豸���� &��̨����  
ping baidu.com		#pingһ�£����û����������ʹ��  dhcpcd & ��̬����IP��ַ  
timedatectl set-ntp true  #����ϵͳʱ��  

#����  
###windows �û�Ҫװ����windows ͬһ�����µĻ�����Ҫ��g����һ���µĿշ����б�����֮ǰ�ķ�����windows���ᱻɾ��  
fdisk -l		#�鿴Ӳ�����  
fdisk �����ķ���λ��  
Command (m for help):	#m���Բ鿴����  p ���Բ鿴��ǰ������Ϣ  ��������������� ���԰�g�����µķ����б�
n���Դ�������  
Partition number #������ţ�Ĭ����1  
First sector #��ʼλ��  
Last sector  #����λ��  ������������ +512M ����һ��512M�ķ���  
#Partition #1 contains a vfat signature.  #���Ϊ1�ķ����Ѿ����ڣ��Ƿ���Ҫȥ�� Y/N  
����swap���� ͬ�� ��С�����������һ���СΪ1G��2G�͹���  
���������� ͬ�� �����Դ���home�������ļ���������Ҳ�ǿ��Ե�  
���Ϸ��������Ϳ�����  
p�鿴�������  
wд�룬������  
  
#���÷�����ʽ  
ϵͳ����  
mkfs.fat -F32 /dev/��������  
mkfs.ext4 /dev/������  
mkswap /dev/swap����  
#��swap  
swapon /dev/swap����  
  
#���ط�����ѡ��  
vim /etc/pacman.conf  
����/etc/pacman.conf����Color  
[community]  
include = /etc/pacman.d/mirrorlist	#���archlinux�������ĵ�ַ ʹ��gf���� ���ܻ���Ϊ�������Color���޷����룬��Ҫ��:w������gf����  
����s����China �ҵ��й�������  ���û��ע�����ģ�������cn  
���е�����������ʱ�ǰ�˳��������  
  
#��װlinux  pacstrap  
mount /dev/������ /mnt   #�����������ص�/mnt��  
mkdir /mnt/boot		#����bootĿ¼  
mount /dev/�������� /mnt/boot  #�������������ص�/boot  
pacstrap /mnt base linux linux-firmware	vim vi	#��װlinux  
#base��������arch�����Ķ���  
#linux linux�ں�  linux-firmware linux���  
  
#��װ��ɺ�����fstab�ļ�  
genfstab -U /mnt >> /mnt/etc/fstab  
  
arch-chroot /mnt  #����linux  
  
#����ʱ��������  
ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime		#����һ��link���Ϻ�ʱ��  
hwclock --systohc		#ͬ��ʱ��  
  
vim /etc/locale.gen		#�������ɱ��ػ�  
����en_US  �ڷ�Examples���ҵ�en_US.UTF-8 UTF-8 �򿪣�����  
  
locale-gen		#���ɱ��ػ�  
vim /etc/locale.conf  
LANG=en_US.UTF-8        #����  
vim /etc/hostname  	#�༭�����ϵ�����  
vim /etc/hosts		#�༭hosts  
#---hosts---  
127.0.0.1		localhost  
::1			localhost  
127.0.1.1		���hostname.localdomain	���hostname  
  
###����root����  
passwd		#��������  
  
#��װ����grub  
pacman -S grub efibootmgr intel-ucode os-prober  
intel/amd-ucode�����Ҹ��������õģ�  
  
mkdir /boot/grub  
grub-mkconfig > /boot/grub/grub.cfg  
  
uname -m    #�鿴�ܹ�  
grub-install --target=��ļܹ�-efi --efi-directory=/boot  
  
#�꣡  
#����ͨ��pacman -Sȥ��װ���  
  
pacman -S neovim zsh wpa_supplicant dhcpcd  
wpa_supplicant dhcpcd		#�����õģ��������������Ķ���������װ������Ҳ���õ�������  
  
#�꣡��  
#����  
exit	#�˳�root  
killall wpa_supplicant  
reboot  #����  
  

