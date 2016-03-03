#!/bin/bash

shopt -s nullglob

. /home/debrepo/config.sh

INDIR=/home/mk_repo/archive

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

