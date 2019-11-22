#!/bin/sh
##
## Clean up NMON output files
##
## Written by Stephen Ulmer <ulmer@mainline.com>
## Copyright (c) 2009-2012, All Rights Reserved
##
## Compresses NMON output files older than 1 day.
## Removes compressed files older than $OLDERTHAN days.
## 
## By using this script, you agree that it has no warranty of any kind.
##

OLDERTHAN=90
ACTION="rm -f"
NMONDIR=/var/log/nmon
COMPRESS="gzip -9"
EXT=".gz"
FIND="/usr/bin/find"

$FIND $NMONDIR -name "*.nmon" -mtime +1 -exec $COMPRESS {} \;

if [ ! -z "$OLDERTHAN" ] ; then
  $FIND $NMONDIR -name "*.nmon$EXT" -mtime +$OLDERTHAN -exec $ACTION {} \;
fi

