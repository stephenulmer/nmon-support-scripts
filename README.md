# NMON Support Scripts

This project publishes some NMON support scripts that I've been using
in my own environments and giving to customers for *years*.

Many enterprises run NMON using cron. This allows for consistent collection
of data for capacity planning, but can leave holes in the collected data.

For example, if cron is supposed to run your script at midnight but the system
is offline for maintenance from 2359 to 0001, then the script never runs.

This accounts for and overcomes the fact that cron doesn't have a memory.

### nmon_rest_of_day.sh

Calculate the number of samples required to collect data
until midnight, and just collect that. So if this script is started from
/etc/inittab on boot and is re-run from crontab at midnight the system should
have a fairly complete NMON history.


### nmon_clean_files.sh 

Help to manage all of those NMON file written by the above. Compress yesterday's
(and older) files; remove really old compressed files.

