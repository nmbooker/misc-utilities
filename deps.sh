#!/bin/bash

# most perl scripts use this
sudo apt-get -y install libgetopt-long-perl libpod-usage-perl

# for mboxnotify
sudo apt-get -y install liblinux-inotify2-perl libmail-box-perl libset-scalar-perl libnotify-bin

# for apt-manually-installed
sudo apt-get -y install aptitude

# For os-backup-btrfs
sudo apt-get -y install dar par2 liblockfile-simple-perl libdatetime-perl libtry-tiny-perl liblist-moreutils-perl liblist-utilsby-perl libfile-slurp-perl btrfs-tools libset-scalar-perl libcwd-guard-perl
