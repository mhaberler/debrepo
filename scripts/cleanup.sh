#!/bin/bash
# see conf/crontab
/usr/bin/find /home/debrepo/data/{failed,passed,queue,tmp} -type f -mmin +1440 -exec rm -f {} \;

