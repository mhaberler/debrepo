#!/bin/bash

# import debs/dsc's from a directory - will search recursively

shopt -s nullglob

. /home/debrepo/config.sh

if [ "$#" -ne 1 ]; then
    echo "run with directory name containing debs/dsc's"
    exit 1
fi


INDIR=$1

DISTROS='wheezy jessie raspbian'
RROPT="-s  --confdir ${CONF_DIR}"


for distro in $DISTROS
do
    for deb in $(find ${INDIR} -type f -name "*${distro}*.deb")
    do
	# pname=`dpkg-deb -f  $deb Package`  # retrieve package name from .deb
	# echo inlcudedeb $pname $deb

	reprepro ${RROPT} includedeb $distro $deb
    done
done


for distro in $DISTROS
do
    for dsc in $(find ${INDIR} -type f -name "*${distro}*.dsc")
    do
	#echo $dsc
	reprepro ${RROPT} includedsc $distro $dsc
    done
done

exit 0

