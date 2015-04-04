DATESTRING=`date '+%m.%d.%y-%H.%M'`
LOG_FILE="/usr/schawk/logs/raidsync."$DATESTRING".log"
RSYNC="/usr/bin/rsync"
RECIPIENTS="dberks@schawk.com"
RSYNC_ARGS="-avrlth --stats --delete --max-delete=10000"

# prep log file
touch $LOG_FILE
# uncomment next line to reset log
# cat /dev/null > $LOG_FILE
# echo "" >> $LOG_FILE

#######################
# RSYNC MN_RAID1

SOURCEVOL="/mn_raid1/"
DESTVOL="/mn_newraid1/"
echo "###  START RSYNC "$SOURCEVOL" TO "$DESTVOL >> $LOG_FILE
date >> $LOG_FILE

$RSYNC $RSYNC_ARGS $SOURCEVOL $DESTVOL 2>&1 >> $LOG_FILE

echo "" >> $LOG_FILE
date >> $LOG_FILE
echo "###  END RSYNC: "$SOURCEVOL" TO "$DESTVOL >> $LOG_FILE
echo "" >> $LOG_FILE
echo "" >> $LOG_FILE

# END RSYNC MN_RAID1

#######################
# RSYNC MN_RAID2

SOURCEVOL="/mn_raid2/"
DESTVOL="/mn_newraid2/"
echo "###  START RSYNC "$SOURCEVOL" TO "$DESTVOL >> $LOG_FILE
date >> $LOG_FILE

$RSYNC $RSYNC_ARGS $SOURCEVOL $DESTVOL 2>&1 >> $LOG_FILE

echo "" >> $LOG_FILE
date >> $LOG_FILE
echo "###  END RSYNC: "$SOURCEVOL" TO "$DESTVOL >> $LOG_FILE
echo "" >> $LOG_FILE
echo "" >> $LOG_FILE

# END RSYNC MN_RAID2

#######################
#
# uncomment next line to receive log via email
# mail -s "[Rsync - RAIDS]" $RECIPIENTS < $LOG_FILE

