#!/bin/bash
#Script creates a compressed archive(tar) of the specified directory.
tdir=$1
if [ $# -lt 1 ]; then
        echo There are no argument.
        exit
fi
if [ $# -gt 1 ]; then
       echo There are more aguments than 1.
       exit
fi
if [ $PWD -ef $tdir ]; then
        echo Directory is current directory.
        exit
fi
if [ ! -d $tdir ]; then
        echo Directory does not exist.
        exit
fi
sizeblock=$(sudo blockdev --getbsz /dev/sda2)
sizedir=$(du -s --bytes $tdir | awk '\{print $1\}')
deljenje=$(($sizedir%$sizeblock))
if [ $deljenje -eq 0 ]; then
        sizedirblock=$(($sizedir/$sizeblock))
else
         sizedirblock=$(($sizedir/$sizeblock+1))
fi
if [ "$sizedirblock" -gt 10 ]; then
  echo "Directory size is bigger than 10.You want to continue?y/n"
fi
read odobrenje
if [ "$odobrenje" = n ]; then
        exit
fi
perm=$(ls -ld $PWD | awk '\{print $1\}' | cut -b 3)
if [ $perm != w ]; then
        echo "You do not have permission to modify current directory."
        exit
fi
sizetar=$(tar -zcvf $tdir.tar $tdir | du -s --bytes  | awk '\{print $1\}')
availsize=$(free -b | grep -i mem | awk '\{print $4\}')
if [ $sizetar -gt $availsize ];then
        echo "You do not have enough space on current directory."
        exit
else
        tar -zcvf $tdir.tar $tdir
fi
