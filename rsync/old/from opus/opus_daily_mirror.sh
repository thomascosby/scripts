TIMESTAMP=`date '+%m.%d.%y-%H.%M'`
DAILY_LOG_FILE="/usr/schawk/logs/opus_mirror/opus_mirror_daily_"$TIMESTAMP".log"
LOG_FILE="/usr/schawk/logs/opus_mirror/opus_mirror.log"
RSYNC="/usr/bin/rsync"
RECIPIENTS="dberks@schawk.com,tholm@schawk.com"
# RECIPIENTS="dberks@schawk.com"
ERRFLAG=0

touch $LOG_FILE
touch $DAILY_LOG_FILE
# uncomment next line to reset log
# cat /dev/null > $LOG_FILE

#######################
# RSYNC MN_RAID1

SOURCEVOL="/mn_raid1/"
DESTVOL="/mirror_raid1/"
echo "###  `date`" >> $DAILY_LOG_FILE
echo "###  `date`" >> $LOG_FILE
echo "###  START RSYNC "$SOURCEVOL" TO "$DESTVOL >> $DAILY_LOG_FILE
echo "###  START RSYNC "$SOURCEVOL" TO "$DESTVOL >> $LOG_FILE

$RSYNC -ahv --stats --delete --max-delete=10000 $SOURCEVOL $DESTVOL 2>&1 >> $DAILY_LOG_FILE || ERRFLAG=1

echo "" >> $DAILY_LOG_FILE
echo "" >> $LOG_FILE
echo "###  END RSYNC: "$SOURCEVOL" TO "$DESTVOL >> $DAILY_LOG_FILE
echo "###  `date`" >> $DAILY_LOG_FILE
echo "" >> $DAILY_LOG_FILE
echo "" >> $LOG_FILE
tail -12 $DAILY_LOG_FILE >> $LOG_FILE
echo "----------------------------------------------------" >> $LOG_FILE; echo "" >> $LOG_FILE
# END RSYNC MN_RAID1

#######################
# RSYNC MN_RAID2

SOURCEVOL="/mn_raid2/"
DESTVOL="/mirror_raid2/"
echo "###  `date`" >> $DAILY_LOG_FILE
echo "###  `date`" >> $LOG_FILE
echo "###  START RSYNC "$SOURCEVOL" TO "$DESTVOL >> $DAILY_LOG_FILE
echo "###  START RSYNC "$SOURCEVOL" TO "$DESTVOL >> $LOG_FILE

$RSYNC -ahv --protect-args --stats --delete --max-delete=10000 --exclude-from='/usr/schawk/scripts/rsync/opus_mirror_exclude' $SOURCEVOL $DESTVOL 2>&1 >> $DAILY_LOG_FILE || ERRFLAG=1

echo "" >> $DAILY_LOG_FILE
echo "" >> $LOG_FILE
echo "###  END RSYNC: "$SOURCEVOL" TO "$DESTVOL >> $DAILY_LOG_FILE
echo "###  `date`" >> $DAILY_LOG_FILE
tail -13 $DAILY_LOG_FILE >> $LOG_FILE;echo "" >> $LOG_FILE
echo "###################################################" >> $LOG_FILE; echo "" >> $LOG_FILE

# END RSYNC MN_RAID2

#######################

# send summary log excerpt to admins
LOG_TAIL=`tail -n 39 $LOG_FILE`
echo "$LOG_TAIL" | mail -s "[OPUS MIRROR RSYNC]" "$RECIPIENTS"

# flag subject line if errors occurred
#if [ $ERRFLAG -ne 0 ]; then
#	echo "$LOG_TAIL" | mail -s "[(ERROR) OPUS MIRROR RSYNC]" "$RECIPIENTS"
#else
#	echo "$LOG_TAIL" | mail -s "[OPUS MIRROR RSYNC]" "$RECIPIENTS"
#fi

# delete daily logs older than two weeks
find /usr/schawk/logs/opus_mirror/opus_mirror_daily* -mtime +14 -exec rm {} \;
#

###  END SCRIPT #######
