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

#    --prefix=$PREFIX \
# --cross-prefix=$PREBUILT/bin/$HOST- \

CC=$PREBUILT/bin/$HOST-gcc
CXX=$PREBUILT/bin/$HOST-c++

pushd src
echo $CC
./configure \
	--host=$HOST \
	--disable-asm \
    --sysroot=$PLATFORM \
	--cross-prefix=$PREBUILT/bin/$HOST- \
    --extra-cflags="-fPIE -pie -fPIC" \
    --enable-static \
	--disable-shared \
	--enable-pic \
    --extra-ldflags="-fPIE -pie -fPIC" \
    --prefix=$PREFIX \
    $ADDITIONAL_CONFIGURE_FLAG

make clean
make -j8 install V=1
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


