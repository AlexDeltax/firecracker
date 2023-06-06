#!/usr/bin/env bash

DISK_SIZE=128G
DISK_FILE=../output/arch-storage.ext4

cd $(dirname "${BASH_SOURCE[0]}")

# Allocate rootfs disk
fallocate -l 128G $DISK_FILE
mkfs.ext4 $DISK_FILE

