#!/bin/bash

# define root filesystem
export target_device=/dev/sdb3
declare -a bind_targets=(/dev/pts /dev /proc /sys)

# mount target system partitions
mount $target_device /mnt
for  i in ${bind_targets[@]}; do mount --bind $i /mnt$i && wait $!

chroot /mnt

grub-update
grub-install

# exit the chroot jail and unmount devices
exit
for  i in ${bind_targets[@]}; do umount /mnt$i
