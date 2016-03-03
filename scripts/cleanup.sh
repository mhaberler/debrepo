#!/bin/bash

# to be called from cron periodically as user debrepo

/usr/bin/find /home/debrepo/data/{failed,passed,queue,tmp} -type f -mmin +1440 -exec rm -f {} \;

