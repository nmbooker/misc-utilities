#!/bin/bash

# most perl scripts use this
sudo apt-get -y install libgetopt-long-perl libpod-usage-perl

# for mboxnotify
sudo apt-get -y install liblinux-inotify2-perl libmail-box-perl libset-scalar-perl libnotify-bin

# for apt-manually-installed
sudo apt-get -y install aptitude

# For os-backup-btrfs
sudo apt-get -y install dar par2 liblockfile-simple-perl libdatetime-perl libtry-tiny-perl libfile-slurp-perl btrfs-tools libset-scalar-perl libcwd-guard-perl

# For dar-pack-isos
sudo apt-get -y install liblist-moreutils-perl libscalar-list-utils-perl libfailures-perl libtry-tiny-perl libsafe-isa-perl libio-captureoutput-perl libcwd-guard-perl
