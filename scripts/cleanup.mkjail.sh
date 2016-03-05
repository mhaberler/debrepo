#!/bin/bash
# see conf/crontab
/usr/bin/find /home/mkjail/shared/{incoming,info} -type f -mmin +1440 -exec rm -f {} \;

