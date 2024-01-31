### 安装libunwind
64位操作系统需要安装libunwind，gperftools推荐版本是libunwind-1.6.2，详见gperftools/INSTALL里的说明。

    wget http://download.savannah.gnu.org/releases/libunwind/libunwind-0.99-beta.tar.gz
    tar -zxvf libunwind-1.6.2.tar.gz
    cd libunwind-1.6.2/
    ./configure
    make
    make install

### 安装graphviz    
Graphviz是一个由AT&T实验室启动的开源工具包，用于绘制DOT语言脚本描述的图形，gperftools依靠此工具生成图形分析结果。

    安装命令：yum install graphviz

生成图像时依赖ps2pdf

    安装命令：yum -y install ghostscript


### 安装perftools    
    git clone https://github.com/gperftools/gperftools.git
    cd gperftools/
    ./autogen.sh
    ./configure
    make
    make install