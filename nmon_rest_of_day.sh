#!/bin/sh
##
## Run NMON for "the rest of the day".
##
## Written by Stephen Ulmer <ulmer@mainline.com>
## Copyright (c) 2009-2012, All Rights Reserved
##
## When NMON runs from cron, there will be gaps in the collection when the
## system is rebooted. This collects enough NMON samples to run until
## midnight tonight.
##
## On AIX, add to /etc/inittab with a command like:
##   mkitab "nmon:23456789:once:/path/to/nmon_rest_of_day.sh"
##
## Also run this same script from root's crontab to ensure that the collection
## is restarted daily:
##   0 0 * * * /path/to/nmon_rest_of_day.sh
##
## By using this script, you agree that it has no warranty of any kind.
##

NMON=/usr/bin/nmon
SNAPSHOT=300

if [ $(uname) = "Linux" ] ; then
  FLAGS="-ft"
else
  FLAGS="-ftdMAV^"
fi

H=$(date +%H); M=$(date +%M); S=$(date +%S)

# Number of seconds in a day, minus what we've already spent
SAMPLES=$(echo "86400 60 60 $H * * - 60 $M * - $S - $SNAPSHOT / p" | dc)

$NMON $FLAGS -s $SNAPSHOT -c $SAMPLES -m /var/log/nmon

