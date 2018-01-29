## 将网卡的名称改为eth0方法
- 以root权限打开 `/etc/default/grub`，将 `GRUB_CMDLINE_LINUX=""` 修改成 `GRUB_CMDLINE_LINUX="net.ifnames=0 biosdevname=0"`
- 更新修改 `sudo update-grub`
- 重启系统 `sudo reboot` 

## 配置静态IP地址
	
	auto eth0
	iface eth0 inet static
	address 10.8.9.143  IP地址
	gateway 10.8.9.254    网关
	netmask 255.255.255.0  网络掩码	
	
	dns-nameservers 10.8.1.2 10.8.1.3   （服务器和虚拟机都是这样配置的）固定DNS域名服务