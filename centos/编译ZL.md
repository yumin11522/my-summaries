### 编译X264

- 从官网的git地址下载x264最新代码：

	git clone http://git.videolan.org/git/x264.git

- 进入x264目录下，执行命令：

	./configure --enable-shared --enable-static --enable-debug

make & make install

	编译时可能会提示 Minimum version is nasm-2.13，那么需要检查nasm版本，重新安装2.13及以上版本。
	
	执行命令：
	
	wget https://www.nasm.us/pub/nasm/releasebuilds/2.14/nasm-2.14.tar.bz2
	
	tar -jxvf nasm-2.14.tar.bz2
	
	cd nasm-2.14
	
	./configure
	
	make & make install
	
- pkg-config 找不到已安装的包解决方案
	
	PKG_CONFIG_PATH=$PKG_CONFIG_PATH:/usr/lib64/lib/pkgconfig/ && export PKG_CONFIG_PATH

重新编译安装x264即可。成功后x264目录下会出现可执行文件x264。
