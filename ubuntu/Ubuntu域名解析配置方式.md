#Ubuntu 域名解析配置方式


## /etc/resolv.conf里面设置的nameserver就被清空

\# cat /etc/resolv.conf  
\# Dynamic resolv.conf(5) file for glibc resolver(3) generated by resolvconf(8)
\#     DO NOT EDIT THIS FILE BY HAND -- YOUR CHANGES WILL BE OVERWRITTEN       注意看：

1. /etc/resolv.conf 其实是一个Link它其实指向的是 /run/resolvconf/resolv.conf
 
A. 如果想自己定义 nameserver，那么有以下2个办法：

	1. 在网卡的配置文件/etc/network/interfaces 里面加：

		`dns-nameservers 192.168.3.45 192.168.8.10`

		`dns-search foo.org bar.com` 

	2. 重启网络
	
		`sudo service networking restart`

		或者  

		`sudo /etc/init.d/networking restart`

	    也可以重启网卡  

		`sudo ifconfig eth0 down`
 
		`sudo ifconfig eth0 up`

B. 修改 resolvconf服务的配置文件: /etc/resolvconf/resolv.conf.d/base 

	`echo "search test.com" >> /etc/resolvconf/resolv.conf.d/base`
 
    `echo "nameserver 202.106.0.20 " >> /etc/resolvconf/resolv.conf.d/base`
 
    这样，在机器重启或 resolvconf 服务重启 都可以保证配置会写到/etc/resolv.conf 里面 

    重启 resolvconf 服务

	`service resolvconf restart`


**A比B的优先级更高,,不过可能会断网.**