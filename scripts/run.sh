#!/bin/bash -e
#set -x

cd $HOME
logger $0: `bash -c id ` pwd=`pwd`

. config.sh

# create directories
mkdir -p ${FAIL_DIR}
mkdir -p ${PASS_DIR}
mkdir -p ${QUEUE_DIR}
mkdir -p ${TEMP_DIR}
mkdir -p ${GNUPGHOME}
chmod 0700 ${GNUPGHOME}


# cleanup
rm -rf ${TEMP_DIR}/*

# import gpg key
if [ -f ${KEYS_DIR}/${GPG_KEY} ]; then
    rm -rf ${GNUPGHOME}
    mkdir -p ${GNUPGHOME}
    chmod 0700 ${GNUPGHOME}
    export GNUPGHOME 
    gpg  --import ${KEYS_DIR}/${GPG_KEY} || true
    # extract public key
    tmp=$(gpg --fingerprint | grep ^pub)
    tmp=${tmp##*/}
    tmp=${tmp% *}

    echo "Using GPG key id: "${tmp}

    export GPG_SIG=${tmp}
    sed -e "s/GPG_SIG/${GPG_SIG}/g" ${CONF_DIR}/distributions.in > ${CONF_DIR}/distributions
else
    sed -e '/GPG_SIG/d' ${CONF_DIR}/distributions.in > ${CONF_DIR}/distributions
fi


exec inoticoming --initialsearch --foreground ${INFO_DIR} \
   --regexp "(passed|failed)" /bin/bash  ${TOP}/scripts/process.sh {} \;

