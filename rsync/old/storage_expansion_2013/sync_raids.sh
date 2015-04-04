DATESTRING=`date '+%m.%d.%y'`
LOG_FILE="/usr/schawk/logs/raidsync."$DATESTRING".log"
RSYNC="/usr/bin/rsync"
RECIPIENTS="dberks@schawk.com"
RSYNC_ARGS="-rltvh --stats --delete --max-delete=10000"

# this script syncs the WIP & Asset data on the Opus Server from it's present location
# (mn_raid1 and mn_raid2) to the new SAN space. Run daily until Cutover.
# Part of the Storage Expansion Project
# Dan B - 11.26.12

SOURCEVOL1="/mn_raid1/*"
DESTVOL1="/mn_san_raid1/"

SOURCEVOL2="/mn_raid2/*"
DESTVOL2="/mn_san_raid2/"

# prep log file
touch $LOG_FILE
# uncomment next line to reset log
cat /dev/null > $LOG_FILE
echo "" >> $LOG_FILE

# BEGIN RSYNC MN_RAID1
echo "###  START RSYNC MN_RAID1: "$SOURCEVOL1" TO "$DESTVOL1 >> $LOG_FILE
date >> $LOG_FILE

$RSYNC $RSYNC_ARGS $SOURCEVOL1 $DESTVOL1 2>&1 >> $LOG_FILE

# finish logging
echo "" >> $LOG_FILE
date >> $LOG_FILE
echo "###  END RSYNC MN_RAID1: "$SOURCEVOL1" TO "$DESTVOL1 >> $LOG_FILE
echo "" >> $LOG_FILE
echo "" >> $LOG_FILE
# END RSYNC MN_RAID1

# BEGIN RSYNC MN_RAID2
echo "###  START RSYNC MN_RAID2: "$SOURCEVOL2" TO "$DESTVOL2 >> $LOG_FILE
date >> $LOG_FILE

$RSYNC $RSYNC_ARGS --exclude '/jobsarchive' $SOURCEVOL2 $DESTVOL2 2>&1 >> $LOG_FILE

# finish logging
echo "" >> $LOG_FILE
date >> $LOG_FILE
echo "###  END RSYNC MN_RAID2: "$SOURCEVOL2" TO "$DESTVOL2 >> $LOG_FILE
echo "" >> $LOG_FILE
echo "" >> $LOG_FILE
# END RSYNC MN_RAID2

mail -s "[Rsync - RAIDS]" $RECIPIENTS < $LOG_FILE

