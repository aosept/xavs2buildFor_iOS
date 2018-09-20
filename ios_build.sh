#!/bin/sh
# Instruction:
#   A simple build script of xavs2/davs2 for iOS platform.
# Author:
#   Shen Wei <aosept@gmail.com>
#
# reference: http://blog.csdn.net/u010963658/article/details/51404710
#            https://github.com/yixia/x264.git
# PIE:       http://stackoverflow.com/questions/30612067/only-position-independent-executables-pie-are-supported
#            https://github.com/danielkop/android-ffmpeg/commit/616a099151fb6be05b559adc4c9ed95afacd92c2

# ------------------------------------------------------
# ARCH configurations: (arm/arm64), sdk-verision (19， 21)
#     only 21 and later version supports arm64
ARCH=arm
SDK_VERSION=19
iOSPATH="./ios/"

# ------------------------------------------------------
if [ "$ARCH" = "arm64" ]
then
PLATFORM_PREFIX="ios12"
HOST="aarch64"
EXTRA_CFLAGS="-march=armv8-a -D__ARM_ARCH_7__ -D__ARM_ARCH_7A__ -fPIE -pie"
else
PLATFORM_PREFIX="arm-ios12"
HOST="arm"
EXTRA_CFLAGS="-march=armv7-a -mfloat-abi=softfp -mfpu=neon -D__ARM_ARCH_7__ -D__ARM_ARCH_7A__ -fPIE -pie"
fi

PREFIX=$(pwd)/ios/${ARCH}

iOSROOT=$iOSPATH/platforms/iOS-${SDK_VERSION}/arch-${ARCH}
TOOLCHAIN=$iOSPATH/toolchains/${PLATFORM_PREFIX}/prebuilt/linux-x86_64
CROSS_PREFIX=$TOOLCHAIN/bin/${PLATFORM_PREFIX}
EXTRA_LDFLAGS="-fPIE -pie"

# configure
rm -rf config.mak
./configure --prefix=$PREFIX \
--cross-prefix=$CROSS_PREFIX \
--extra-cflags="$EXTRA_CFLAGS" \
--extra-ldflags="$EXTRA_LDFLAGS" \
--arch=$ARCH \
--enable-pic \
--enable-static \
--enable-strip \
--disable-asm \
--host=arm-linux \
--cc="xcrun -sdk iphoneos clang" \
--sysroot=$iOSROOT

make clean
make STRIP= -j4 # install || exit 1
# scripts ends here

