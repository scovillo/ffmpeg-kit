#!/bin/bash
set -e

wget -q https://dl.google.com/android/repository/android-ndk-r25c-linux.zip
unzip -qq android-ndk-r25c-linux.zip
mv android-ndk-r25c "$HOME"/android-ndk

export ANDROID_SDK_ROOT=$ANDROID_HOME
export ANDROID_NDK_ROOT=$HOME/android-ndk
export ANDROID_NDK_HOME=$HOME/android-ndk
export ANDROID_NDK=$HOME/android-ndk

printenv

chmod +x android.sh
./android.sh --enable-gnutls --disable-x86 --disable-x86-64 --disable-arm-v7a --api-level=21 || export BUILD_FAILED=true
echo "======= BEGIN build.log (arm-v7a-neon) ======="
tail -n 200 build.log || echo "build.log not found"
echo "======= END build.log ======="
if [ "$BUILD_FAILED" = "true" ]; then exit 1; fi
