#!/system/bin/busybox ash

# Remount the rootfs as read-write
mount -o rw,remount rootfs /

# Create debian root if not present
export LINUXROOT=/linux
export DEBIAN_IMG_PATH="/sdcard/downloads/jessie-armhf.img"
export DEVICE_PATH="/dev/block/loop100"
if [ ! -d $LINUXROOT ]; then
        mkdir $LINUXROOT
fi

# Mount debian image
if [ ! -e $DEVICE_PATH ]; then                     
        busybox mknod $DEVICE_PATH b 7 100           
        busybox losetup $DEVICE_PATH $DEBIAN_IMG_PATH
        mount -t ext4 $DEVICE_PATH $LINUXROOT
fi
                          
# Mount special filesystem
if [ ! -d /proc ]; then                  
	echo Mount /proc on Host...
        mount -t proc none /proc && echo Done.
fi                              
if [ ! -d /sys ]; then                    
	echo Mount /sys on Host...
        mount -t sysfs none /sys && echo Done.
fi                             
if [ ! -d /dev ]; then                       
	echo Mount /dev on Host...
        mount -o bind /dev /dev && echo Done.     
fi                                   
if [ ! -d /dev/pts ]; then                            
	echo Mount /dev/pts on Host...
        mount -t devpts none /dev/pts && echo Done.                                  
fi                                                                      
                                                                        
# Go into debian chroot environment                                     
export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
export LINUXROOT=/linux
export TMPDIR=/tmp    
export USER=root      
export HOME=/root     
export SHELL=/bin/bash                                                  
export TERM=linux                                                       
export LC_ALL=C                                                         
export LANGUAGE=C 
export POST_CONFIG_SCRIPT=/start_debian_postconfig.sh                                                      
                                                                        
/system/bin/busybox chroot $LINUXROOT $SHELL $POST_CONFIG_SCRIPT       
/system/bin/busybox chroot $LINUXROOT $SHELL