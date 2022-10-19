#!/bin/bash



# A Function to Send Posts to Telegram
telegram_message() {
	curl -s -X POST "https://api.telegram.org/bot${TG_TOKEN}/sendMessage" \
	-d chat_id="${TG_CHAT_ID}" \
	-d parse_mode="HTML" \
	-d text="$1"
}

cd ~
git clone https://github.com/Arafattex/shas-dream-oc-mt6768-a11.git --depth 1 -b shas-noc kernel
cd kernel
git clone https://github.com/rama982/clang --depth=1 clang
mkdir outL
export ARCH=arm64
export SUBARCH=arm64
export DTC_EXT=dtc
make O=outL ARCH=arm64 lancelot_defconfig
export PATH="~/kernel/clang/bin:${PATH}"
make -j"$PROCS" O=outL \
                ARCH=arm64 \
                CC=clang \
                CROSS_COMPILE=aarch64-linux-gnu- \
                CROSS_COMPILE_ARM32=arm-linux-gnueabi- \
                LD=ld.lld \
                NM=llvm-nm \
                OBJCOPY=llvm-objcopy
# Exit
exit 0
