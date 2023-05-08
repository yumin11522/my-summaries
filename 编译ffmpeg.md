**Linux FFMPEG 编译**

    sudo apt install autoconf automake libtool pkg-config diffutils

***第一步, 编译NASM***

    wget https://www.nasm.us/pub/nasm/releasebuilds/2.14rc16/nasm-2.14rc16.tar.gz

    tar -xvf nasm-2.14rc16.tar.gz

    进入nasm的source目录，配置如下：

    ./configure --enable-shared

    make -j4

    make install


***第二步, 编译X264***

    git clone https://code.videolan.org/videolan/x264.git

    进入x264的source目录，配置如下：

    ./configure --enable-shared
    
    make -j4

    make install


***第三步, 编译FFMPEG***

    git clone https://git.ffmpeg.org/ffmpeg.git ffmpeg

    进入ffmpeg的source目录，配置如下：

    ./configure --enable-gpl --enable-libx264 --enable-shared
    msys2: ./configure --enable-gpl --enable-libx264 --enable-shared --extra-cflags=-I/usr/local/include --extra-ldflags=-L/usr/local/lib

    make -j4

    make install


***第三步, 编译 MP4V2***

    sudo autoreconf -vif

    git clone https://github.com/pcwalton/mp4v2.git

    进入mp4v2的source目录，配置如下：

    ./configure --enable-shared

    make -j4

    make install
