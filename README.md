# Raspberry Pi Emulation

## Installation

### Required Packages

Arch Linux:

```sh
sudo pacman -S qemu qemu-arch-extra bridge-utils
```

### Check supported ARM machines and CPUs for each machine

```sh
qemu-system-arm -machine '?'
qemu-system-arm -M versatilepb -cpu '?'
```

### Emulate a Raspbian Lite image

You can run the included bash script:

```sh
bash create-lite-setup.sh
```

The script fetches an open source qemu kernel for the Raspberry Pi, as well as a board-specific device tree (DTB). Afterwards it downloads an image of Raspbian Buster Lite, and finally executes the QEMU emulator.

The emulation parameters are as follows:

```sh
qemu-system-arm
    -kernel ${RPI_KERNEL_FILE} \    # specify kernel file
    -cpu arm1176                    # use ARM 1176 as CPU
    -m 256                          # 256MB memory
    -M versatilepb \                # versatilepb machine
    -dtb ${PTB_FILE}                # device tree file
    -no-reboot \
    -serial stdio
    -append "root=/dev/sda2 panic=1 rootfstype=ext4 rw" \
    -drive "file=${RPI_FS},index=0,media=disk,format=raw" \ # boot from downloaded image
    -net user,hostfwd=tcp::5022-:22 -net nic                # enable networking and set port to 5022 for SSH
```

Once you boot into the system, you are asked to log in. Default credentials for a Raspberry Pi are:

-   username: pi
-   password: raspberry

After you log in, you need to enable and start the SSH service:

```sh
sudo systemctl enable ssh
sudo systemctl start ssh
```

Don't forget to update your Raspbian install:

```sh
sudo apt update && sudo apt upgrade
```

## Usage

### SSH to the emulated machine from host machine

```sh
ssh pi@localhost -p 5022
```

That's it! You can now access the emulated machine's bash.

![pi.png]
