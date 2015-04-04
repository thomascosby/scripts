#!/bin/sh -f
#
# a script to rotate the Penang rsync logs  -  Dan B - 01.13.13

# maximum log size in KB
MAX_SIZE=5000

find /usr/schawk/logs/rsync/ -iname 'rsync_*.log' |
while read filename
do
	THIS_LOG="$filename"
	touch $THIS_LOG
	LOG_SIZE=`du -sk $THIS_LOG | cut -d '	' -f 1`
	if [ $LOG_SIZE -gt $MAX_SIZE ]; then
	    #echo "$filename"
        TIMESTAMP=$(date)
        echo "$TIMESTAMP: rotating log" >> $THIS_LOG
        touch ${THIS_LOG}.OLD
        rm -f ${THIS_LOG}.OLD
        cp $THIS_LOG ${THIS_LOG}.OLD
        cat /dev/null > $THIS_LOG
	fi
done
exit
