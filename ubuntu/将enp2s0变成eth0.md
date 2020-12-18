## 将网卡的名称改为eth0方法
- 以root权限打开 `/etc/default/grub`，将 `GRUB_CMDLINE_LINUX=""` 修改成 `GRUB_CMDLINE_LINUX="net.ifnames=0 biosdevname=0"`
- 更新修改 `sudo update-grub`
- 重启系统 `sudo reboot` 

## 配置静态IP地址
	sudo vi /etc/network/interface

	auto eth0
	iface eth0 inet static
	address 10.8.9.143  IP地址
	gateway 10.8.9.254    网关
	netmask 255.255.255.0  网络掩码	
	
	dns-nameservers 10.8.1.2 10.8.1.3   （服务器和虚拟机都是这样配置的）固定DNS域名服务

## ubuntu中vi编辑器键盘错乱的问题
	Ubuntu安装完成后vi编辑器键盘不能正常使用，使用下面方法解决：

	编辑文件/etc/vim/vimrc.tiny，将“compatible”改成“nocompatible”非兼容模式；
	
	并添加一句：
	
	set backspace=2

## Desktop 版禁用NetworkManager
	如果用户希望在Desktop版本中，直接使用interfaces 进行网络配置，那最好删除network-manager 。

	如果在出现上述问题之后，希望能继续使用nm 来进行网络配置，则需要进行如下操作：

	1、sudo servicenetwork-manager stop # 停止 nm服务

	2、sudo rm/var/lib/NetworkManager/NetworkManager.state # 移除nm 的状态文件

	3、sudo gedit/etc/NetworkManager/NetworkManager.conf # 打开nm 的配置文件里面有一行：managed=true
	如果你手工改过/etc/network/interfaces，nm会自己把这行改成：managed=false 将false 修改成true, 
	sudo servicenetwork-manager start
	
	4、取消开机启动：update-rc.d -f network-manager remove

## 在Ubuntu中是没有chkconfig命令的，可以用update-rc.d 来代替。
	update-rc.d sshd defaults          # Activate sshd with the default runlevels
	update-rc.d sshd start 20 2 3 4 5 . stop 20 0 1 6 .  # With explicit arguments
	update-rc.d -f sshd remove         # Disable sshd for all runlevels
	shutdown -h now (or # poweroff)    # Shutdown and halt the system


## ubuntu 18之后修改IP
https://blog.csdn.net/lengye7/article/details/88889807