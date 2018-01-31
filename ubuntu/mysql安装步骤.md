LINUX系统下安装MySQL5.5 zip版本步骤：

1.  安装mysql依赖库 libaio： `sudo apt-get install libaio-dev`

2.  以<font color=red>**root权限**</font> 执行以下<a href="https://dev.mysql.com/doc/refman/5.5/en/default-privileges.html">命令</a>：

	`shell> groupadd mysql` 
	
	`shell> useradd -r -g mysql -s /bin/false mysql`
	
	`shell> cd /usr/local`
	
	`shell> tar zxvf /path/to/mysql-VERSION-OS.tar.gz`
	
	`shell> ln -s full-path-to-mysql-VERSION-OS mysql`
	
	`shell> cd mysql`
	
	`shell> chown -R mysql .`
	
	`shell> chgrp -R mysql .`
	
	`shell> scripts/mysql_install_db --user=mysql`
	
	`shell> chown -R root .`
	
	`shell> chown -R mysql data`
	
	`shell> cp support-files/my-medium.cnf /etc/my.cnf`
	
	`shell> bin/mysqld_safe --user=mysql &`
	
	`shell> bin/mysql -uroot -p`
	
	`mysql> UPDATE mysql.user SET Password = PASSWORD('new_password') WHERE User = 'root';`
	
	`mysql> FLUSH PRIVILEGES;`
	
	`mysql> exit`
	
	`shell> cp support-files/mysql.server /etc/init.d/mysql.server`

3.  赋予远程访问权限  

	`mysql> grant all privileges on *.* to '用户名'@'%' identified by '密码' with grant option;`

	`mysql> flush privileges;`