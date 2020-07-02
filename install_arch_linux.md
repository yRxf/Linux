https://www.bilibili.com/video/BV11J411a7Tp  
https://wiki.archlinux.org/index.php/Installation_guide  
setfont /usr/share/kbd/consolefonts/LatGrkCyr-12x22.psfu.gz    #设置字体  
#可以创建一个文件去更改键位  vim keys.conf  
keycode 1 = Caps_Lock		#keycode 1 是esc键，即将Caps_Lock键映射为esc  
keycode 58 = Escape  
(https://blog.csdn.net/whsbk/article/details/79827680)  
keycode 58 = Control  
keycode 100 = Caps_Lock  
#保存退出  
loadkeys keys.conf		#更改键位  
alias c=clear		#用c清屏  
  
ip link 		#查看当前网络  wlan0  为wifi开关  
ip link set wlan0 up	#可以打开开关  
iwlist wlan0 scan	#查看当前搜索到的wifi  
iwlist wlan0 scan | grep ESSID  #搜索wifi名称  
wpa_passphrase wifi名称 密码 > internet.conf （文件名）  
wpa_supplicant -c internet.conf -i wlan0 &	#-c 之前生成的配置文件 -i 连接的设备名称 &后台运行  
ping baidu.com		#ping一下，如果没有网，可以使用  dhcpcd & 动态分派IP地址  
timedatectl set-ntp true  #更新系统时间  

#分区  
###windows 用户要装在与windows 同一磁盘下的话不需要用g创建一个新的空分区列表，否则之前的分区（windows）会被删除  
fdisk -l		#查看硬盘情况  
fdisk 创建的分区位置  
Command (m for help):	#m可以查看帮助  p 可以查看当前分区信息  如果存在其他分区 可以按g创建新的分区列表
n可以创建分区  
Partition number #分区编号，默认是1  
First sector #起始位置  
Last sector  #结束位置  即这个分区多大 +512M 创建一个512M的分区  
#Partition #1 contains a vfat signature.  #编号为1的分区已经存在，是否需要去除 Y/N  
创建swap分区 同理 大小视情况而定。一般大小为1G、2G就够了  
创建主分区 同上 还可以创建home和数据文件两个分区也是可以的  
以上分区基本就可以了  
p查看分区情况  
w写入，即保存  
  
#设置分区格式  
系统分区  
mkfs.fat -F32 /dev/引导分区  
mkfs.ext4 /dev/主分区  
mkswap /dev/swap分区  
#打开swap  
swapon /dev/swap分区  
  
#下载服务器选择  
vim /etc/pacman.conf  
进入/etc/pacman.conf，打开Color  
[community]  
include = /etc/pacman.d/mirrorlist	#存放archlinux服务器的地址 使用gf进入 可能会因为上面打开了Color而无法进入，需要先:w保存再gf进入  
可以s搜索China 找到中国服务器  如果没有注释中文，可以找cn  
剪切到顶部，搜索时是按顺序搜索的  
  
#安装linux  pacstrap  
mount /dev/主分区 /mnt   #将主分区挂载到/mnt下  
mkdir /mnt/boot		#创建boot目录  
mount /dev/引导分区 /mnt/boot  #将引导分区挂载到/boot  
pacstrap /mnt base linux linux-firmware	vim vi	#安装linux  
#base包里面有arch基础的东西  
#linux linux内核  linux-firmware linux框架  
  
#安装完成后生成fstab文件  
genfstab -U /mnt >> /mnt/etc/fstab  
  
arch-chroot /mnt  #进入linux  
  
#更改时区、语言  
ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime		#创建一个link是上海时区  
hwclock --systohc		#同步时间  
  
vim /etc/locale.gen		#帮助生成本地化  
搜索en_US  在非Examples：找到en_US.UTF-8 UTF-8 打开，保存  
  
locale-gen		#生成本地化  
vim /etc/locale.conf  
LANG=en_US.UTF-8        #语言  
vim /etc/hostname  	#编辑网络上的名字  
vim /etc/hosts		#编辑hosts  
#---hosts---  
127.0.0.1		localhost  
::1			localhost  
127.0.1.1		你的hostname.localdomain	你的hostname  
  
###更改root密码  
passwd		#更改密码  
  
#安装引导grub  
pacman -S grub efibootmgr intel-ucode os-prober  
intel/amd-ucode（厂家更新驱动用的）  
  
mkdir /boot/grub  
grub-mkconfig > /boot/grub/grub.cfg  
  
uname -m    #查看架构  
grub-install --target=你的架构-efi --efi-directory=/boot  
  
#完！  
#可以通过pacman -S去安装软件  
  
pacman -S neovim zsh wpa_supplicant dhcpcd  
wpa_supplicant dhcpcd		#上网用的，能上网，其他的都能上网安装，上面也有用到这两个  
  
#完！！  
#重启  
exit	#退出root  
killall wpa_supplicant  
reboot  #重启  
  

