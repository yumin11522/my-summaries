#!/bin/bash

set -e

# Set your own NDK here
NDK=/home/xiong/dev-tools/android-ndk-r11c

ARM_PLATFORM=$NDK/platforms/android-9/arch-arm/
ARM_PREBUILT=$NDK/toolchains/arm-linux-androideabi-4.9/prebuilt/linux-x86_64

ARM64_PLATFORM=$NDK/platforms/android-21/arch-arm64/
ARM64_PREBUILT=$NDK/toolchains/aarch64-linux-android-4.9/prebuilt/linux-x86_64

X86_PLATFORM=$NDK/platforms/android-9/arch-x86/
X86_PREBUILT=$NDK/toolchains/x86-4.9/prebuilt/linux-x86_64

X86_64_PLATFORM=$NDK/platforms/android-21/arch-x86_64/
X86_64_PREBUILT=$NDK/toolchains/x86_64-4.9/prebuilt/linux-x86_64

MIPS_PLATFORM=$NDK/platforms/android-9/arch-mips/
MIPS_PREBUILT=$NDK/toolchains/mipsel-linux-android-4.9/prebuilt/linux-x86_64

BUILD_DIR=`pwd`/../android


function build_one
{
if [ $ARCH == "arm" ]
then
    PLATFORM=$ARM_PLATFORM
    PREBUILT=$ARM_PREBUILT
    HOST=arm-linux-androideabi
#added by alexvas
elif [ $ARCH == "arm64" ]
then
    PLATFORM=$ARM64_PLATFORM
    PREBUILT=$ARM64_PREBUILT
    HOST=aarch64-linux-android
elif [ $ARCH == "mips" ]
then
    PLATFORM=$MIPS_PLATFORM
    PREBUILT=$MIPS_PREBUILT
    HOST=mipsel-linux-android
#alexvas
elif [ $ARCH == "x86_64" ]
then
    PLATFORM=$X86_64_PLATFORM
    PREBUILT=$X86_64_PREBUILT
    HOST=x86_64-linux-android
else
    PLATFORM=$X86_PLATFORM
    PREBUILT=$X86_PREBUILT
    HOST=i686-linux-android
fi
echo $X264_BUILD_DIR/$CPU
#    --prefix=$PREFIX \
#    --incdir=$BUILD_DIR/include \
#    --libdir=$BUILD_DIR/lib/$CPU_ALIAS \
# TODO Adding aac decoder brings "libnative.so has text relocations. This is wasting memory and prevents security hardening. Please fix." message in Android.
pushd src
./configure --target-os=linux \
    --enable-cross-compile \
    --extra-libs="-lgcc" \
    --arch=$ARCH \
    --cc=$PREBUILT/bin/$HOST-gcc \
    --cross-prefix=$PREBUILT/bin/$HOST- \
    --nm=$PREBUILT/bin/$HOST-nm \
    --sysroot=$PLATFORM \
    --extra-cflags="-fvisibility=hidden -fdata-sections -ffunction-sections -Os -fPIC -DANDROID -DHAVE_SYS_UIO_H=1 -Dipv6mr_interface=ipv6mr_ifindex -fasm -Wno-psabi -fno-short-enums -fno-strict-aliasing -finline-limit=300 $OPTIMIZE_CFLAGS -I$BUILD_DIR/$CPU_ALIAS/include" \
    --disable-shared \
    --enable-small \
    --extra-ldflags="-Wl,-rpath-link=$PLATFORM/usr/lib -L$PLATFORM/usr/lib -nostdlib -lc -lm -ldl -llog -L$BUILD_DIR/$CPU_ALIAS/lib" \
    --disable-everything \
    --disable-ffplay \
    --disable-ffmpeg \
    --disable-ffprobe \
    --disable-ffserver \
    --enable-libx264 \
	--enable-encoder=libx264 \
	--enable-gpl \
	--enable-nonfree \
	--enable-postproc \
	--enable-decoder=h264 \
	--prefix=$PREFIX \
    $ADDITIONAL_CONFIGURE_FLAG

make clean
make -j8 install V=1
$PREBUILT/bin/$HOST-ar d libavcodec/libavcodec.a inverse.o
#$PREBUILT/bin/$HOST-ld -rpath-link=$PLATFORM/usr/lib -L$PLATFORM/usr/lib  -soname libffmpeg.so -shared -nostdlib  -z,noexecstack -Bsymbolic --whole-archive --no-undefined -o $PREFIX/libffmpeg.so libavcodec/libavcodec.a libavformat/libavformat.a libavutil/libavutil.a libswscale/libswscale.a -lc -lm -lz -ldl -llog  --warn-once  --dynamic-linker=/system/bin/linker $PREBUILT/lib/gcc/$HOST/4.6/libgcc.a
popd
}

#arm v5te
CPU=armv5te
CPU_ALIAS=$CPU
ARCH=arm
OPTIMIZE_CFLAGS="-marm -march=$CPU"
PREFIX=$BUILD_DIR/$CPU_ALIAS
ADDITIONAL_CONFIGURE_FLAG=
build_one

#arm v6
#CPU=armv6
#CPU_ALIAS=$CPU
#ARCH=arm
#OPTIMIZE_CFLAGS="-marm -march=$CPU"
#PREFIX=`pwd`/ffmpeg-android/$CPU_ALIAS 
#ADDITIONAL_CONFIGURE_FLAG=
#build_one

#arm v7vfpv3
CPU=armv7-a
CPU_ALIAS=$CPU
ARCH=arm
OPTIMIZE_CFLAGS="-mfloat-abi=softfp -mfpu=vfpv3-d16 -marm -march=$CPU "
PREFIX=$BUILD_DIR/$CPU_ALIAS
ADDITIONAL_CONFIGURE_FLAG=
build_one

#arm v7vfp
#CPU=armv7-a
#CPU_ALIAS=$CPU-vfp
#ARCH=arm
#OPTIMIZE_CFLAGS="-mfloat-abi=softfp -mfpu=vfp -marm -march=$CPU "
#PREFIX=`pwd`/ffmpeg-android/CPU_ALIAS
#ADDITIONAL_CONFIGURE_FLAG=
#build_one

#arm v7n
CPU=armv7-a
CPU_ALIAS=$CPU-neon
ARCH=arm
OPTIMIZE_CFLAGS="-mfloat-abi=softfp -mfpu=neon -marm -march=$CPU -mtune=cortex-a8"
PREFIX=$BUILD_DIR/$CPU_ALIAS
ADDITIONAL_CONFIGURE_FLAG=--enable-neon
build_one

#arm v6+vfp
#CPU=armv6
#CPU_ALIAS=$CPU_vfp
#ARCH=arm
#OPTIMIZE_CFLAGS="-DCMP_HAVE_VFP -mfloat-abi=softfp -mfpu=vfp -marm -march=$CPU"
#PREFIX=`pwd`/ffmpeg-android/$CPU_ALIAS
#ADDITIONAL_CONFIGURE_FLAG=
#build_one

#arm64-v8a
CPU=arm64-v8a
CPU_ALIAS=arm64
ARCH=arm64
OPTIMIZE_CFLAGS=
PREFIX=$BUILD_DIR/$CPU_ALIAS
ADDITIONAL_CONFIGURE_FLAG=
build_one

#x86_64
CPU=x86_64
CPU_ALIAS=x64
ARCH=x86_64
OPTIMIZE_CFLAGS="-fomit-frame-pointer"
PREFIX=$BUILD_DIR/$CPU_ALIAS
ADDITIONAL_CONFIGURE_FLAG=
build_one

#x86
CPU=i686
CPU_ALIAS=x86
ARCH=i686
OPTIMIZE_CFLAGS="-fomit-frame-pointer"
PREFIX=$BUILD_DIR/$CPU_ALIAS
ADDITIONAL_CONFIGURE_FLAG=
build_one

