#配置ip

### 首先查看一下网络情况，输入

	ip address

### 配置文件路径：
	vi /etc/sysconfig/network-scripts/ifcfg-enp0s3
然后将`BOOTPROTO=`后面的`dhcp`改为`static`，再将`ONBOOT=`后面的`no`改为`yes`。第一个是把linux获得ip由动态自动分配改为静态手动设置，第二个是让linux启动自启网卡。然后再加入如下一段，这段的ip需要根据自己电脑情况来填，DNS可以填10.8.1.2。

### 配置IP
	IPADDR=10.8.9.199
	NETMASK=255.255.255.0
	GATEWAY=10.8.9.254
	DNS1=10.8.1.2

### 重启网卡
更改完网卡配置文件保存退出，然后重启网络服务：

	systemctl restart network.service

# Centos7 修改以太网卡名称
### 修改ifcfg-enp3s0配置文件文件
	vim /etc/sysconfig/network-scripts/ifcfg-enp3s0
修改 NAME 和 DEVICE 为 eth0

### 重命名配置文件为eth0
	mv /etc/sysconfig/network-scripts/ifcfg-enp3s0 /etc/sysconfig/network-scripts/ifcfg-eth0

### 修改grub开机配置
编辑`/etc/default/grub`，修改为

	GRUB_CMDLINE_LINUX 最后添加 "net.ifnames=0 biosdevname=0" 
	GRUB_CMDLINE_LINUX="rd.lvm.lv=centos/root rd.lvm.lv=centos/swap crashkernel=auto rhgb quiet net.ifnames=0 biosdevname=0"

### 重新生成GRUB配置
运行命令`grub2-mkconfig -o /boot/grub2/grub.cfg` 来重新生成GRUB配置并更新内核参数

### 多网卡管理(多张网卡需要配置时)
创建`/etc/udev/rules.d/70-persistent-net.rules`规则，如果有该文件就不用创建了，直接编辑该文件即可
	
	ACTION=="add" , SUBSYSTEM=="net", DRIVERS=="?", ATTR{address}=="00:e0:4c:90:06:83", ATTR{type}=="1", KERNEL=="eth", NAME="eth0"

### 万能的重启大法
	reboot

	


## 常用命令

### 查看CentOS版本
	cat /proc/version 
	cat /etc/redhat-release

### 更换国内源
	mv /etc/yum.repos.d/CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo.backup
	curl -o /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-7.repo
	yum makecache

### 挂载Windows共享文件夹
	//192.168.66.198/share /home/windows cifs defaults,username=share,password=share 0 2