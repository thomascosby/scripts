DATESTRING=`date '+%m.%d.%y'`
LOG_FILE="/usr/schawk/logs/raidsync."$DATESTRING".log"
RSYNC="/usr/bin/rsync"
RECIPIENTS="dberks@schawk.com"
RSYNC_ARGS="-avrlth --stats --delete --max-delete=0"

SOURCEVOL1="/mn_raid2/"
DESTVOL1="/mn_newraid2/"

# prep log file
touch $LOG_FILE
# uncomment next line to reset log
# cat /dev/null > $LOG_FILE
echo "" >> $LOG_FILE

# BEGIN RSYNC
echo "###  START RSYNC "$SOURCEVOL1" TO "$DESTVOL1 >> $LOG_FILE
date >> $LOG_FILE

$RSYNC $RSYNC_ARGS $SOURCEVOL1 $DESTVOL1 2>&1 >> $LOG_FILE

# finish logging
echo "" >> $LOG_FILE
date >> $LOG_FILE
echo "###  END RSYNC: "$SOURCEVOL1" TO "$DESTVOL1 >> $LOG_FILE
echo "" >> $LOG_FILE
echo "" >> $LOG_FILE
# END RSYNC

mail -s "[Rsync - RAID 2]" $RECIPIENTS < $LOG_FILE

