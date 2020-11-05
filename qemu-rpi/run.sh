#!/bin/sh

QEMU=$(command -v qemu-system-arm)
DIR=./
RPI_KERNEL=kernel-qemu-4.19.50-buster
RPI_KERNEL_FILE=$DIR/$RPI_KERNEL
PTB=versatile-pb.dtb
PTB_FILE=$DIR/$PTB
IMAGE_BASE=2019-09-26-raspbian-buster-lite
IMAGE=$IMAGE_BASE.zip
IMAGE_FILE=$DIR/$IMAGE
RPI_FS=$DIR/$IMAGE_BASE.img


$QEMU -kernel ${RPI_KERNEL_FILE} \
    -cpu arm1176 -m 256 -M versatilepb \
    -dtb ${PTB_FILE} -no-reboot \
    -serial stdio -append "root=/dev/sda2 panic=1 rootfstype=ext4 rw" \
    -drive "file=${RPI_FS},index=0,media=disk,format=raw" \
    -net user,hostfwd=tcp::5022-:22 -net nic