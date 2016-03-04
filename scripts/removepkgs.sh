#!/bin/bash

# given a directory with debs and source packagers, and a (quoted!) pattern,
# create a list of commands to remove them from the apt repo


. /home/debrepo/config.sh

if [ "$#" -ne 3 ]; then
    echo "run with directory name containing debs/dsc's to remove, a distro, and a patterm"
    echo "example: removepkgs /foo/bar jessie 'jessie~raspbian'"
    exit 1
fi


INDIR=$1
DISTRO=$2
PATTERN=$3
RROPT="-s  --confdir ${CONF_DIR}"


for deb in $(find ${INDIR} -type f -name "*${PATTERN}*.deb")
do
    echo reprepro ${RROPT} remove $DISTRO $deb
done


for dsc in $(find ${INDIR} -type f -name "*${PATTERN}*.dsc")
do
    echo reprepro ${RROPT} removesrc $DISTRO $dsc
done

exit 0

