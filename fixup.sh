#!/bin/sh
cd output
[ -f rootfs.tar ] || {
    echo "Hmm this should run in the directory of rootfs.tar"
    exit 1
}
rm -rf extra
mkdir extra extra/etc extra/sbin extra/lib extra/lib64
touch extra/etc/resolv.conf
touch extra/sbin/init
# Uncomment this if you want to include docker in the image, for testing purposes
#cp $(which docker) extra
# You might have to run "ldd $(which docker)" and adjust those paths
cp /lib64/libc.so.6 /lib64/libpthread.so.0 /lib64/libc.so.6 extra/lib
cp /lib64/ld-linux-x86-64.so.2 extra/lib64
cp rootfs.tar fixup.tar
tar rvf fixup.tar -C extra .
docker import - barebones/nodejs < fixup.tar
docker push barebones/nodejs