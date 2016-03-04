#!/bin/bash

# given a directory with debs and source packagers, and a (quoted!) pattern,
# create a list of commands to remove them from the apt repo


. /home/debrepo/config.sh

if [ "$#" -ne 2 ]; then
    echo "run with a distro, and a patterm"
    echo "example: removepkgs jessie 'jessie~raspbian'"
    exit 1
fi


DISTRO=$1
PATTERN=$2
RROPT="-s  --confdir ${CONF_DIR}"


reprepro ${RROPT} list $DISTRO | grep -e "${PATTERN}"| \
while IFS='' read -r line; do

    fields=(`echo ${line}`)
    basename=${fields[1]}
    echo reprepro ${RROPT} --nokeepunreferencedfiles remove $DISTRO $basename

done

exit 0

