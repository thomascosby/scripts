TIMESTAMP=`date '+%m.%d.%y-%H.%M'`
LOG_FILE="/usr/schawk/logs/raid_mirror_"$TIMESTAMP".log"
RSYNC="/usr/bin/rsync"
RECIPIENTS="dberks@schawk.com"
RSYNC_ARGS="-ahv --stats --delete --max-delete=10000"
ERRFLAG=0

# prep log file
touch $LOG_FILE
# uncomment next line to reset log
# cat /dev/null > $LOG_FILE
# echo "" >> $LOG_FILE

#######################
# RSYNC MN_RAID1

SOURCEVOL="/mn_raid1/"
DESTVOL="/mirror_raid1/"
echo "###  START RSYNC "$SOURCEVOL" TO "$DESTVOL >> $LOG_FILE
date >> $LOG_FILE

$RSYNC $RSYNC_ARGS $SOURCEVOL $DESTVOL 2>&1 >> $LOG_FILE || ERRFLAG=1

echo "" >> $LOG_FILE
date >> $LOG_FILE
echo "###  END RSYNC: "$SOURCEVOL" TO "$DESTVOL >> $LOG_FILE
echo "" >> $LOG_FILE
echo "" >> $LOG_FILE

# END RSYNC MN_RAID1

#######################
# RSYNC MN_RAID2

SOURCEVOL="/mn_raid2/"
DESTVOL="/mirror_raid2/"
echo "###  START RSYNC "$SOURCEVOL" TO "$DESTVOL >> $LOG_FILE
date >> $LOG_FILE

$RSYNC $RSYNC_ARGS $SOURCEVOL $DESTVOL 2>&1 >> $LOG_FILE || ERRFLAG=1

echo "" >> $LOG_FILE
date >> $LOG_FILE
echo "###  END RSYNC: "$SOURCEVOL" TO "$DESTVOL >> $LOG_FILE
echo "" >> $LOG_FILE
echo "" >> $LOG_FILE

# END RSYNC MN_RAID2

#######################
#
# mail log to admins; flag subject line if errors occurred
if [ $ERRFLAG -ne 0 ]; then
	mail -s "[Rsync - OPUS RAIDS - ERROR]" $RECIPIENTS < $LOG_FILE
else
	mail -s "[Rsync - OPUS RAIDS]" $RECIPIENTS < $LOG_FILE
fi
#
# delete logs older than two weeks
find /usr/schawk/logs/raid_mirror* -mtime +14 -exec rm {} \;
#
###  END SCRIPT #######
