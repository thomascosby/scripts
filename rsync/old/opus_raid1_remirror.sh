#!/bin/bash
TIMESTAMP=`date '+%m.%d.%y-%H.%M'`
DAILY_LOG_FILE="/usr/schawk/logs/opus_mirror/opus_raid1_remirror_daily_"$TIMESTAMP".log"
LOG_FILE="/usr/schawk/logs/opus_mirror/opus_remirror.log"
RSYNC="/usr/bin/rsync"
#RECIPIENTS="dberks@schawk.com,tholm@schawk.com"
RECIPIENTS="dberks@schawk.com"
ERRFLAG=0

touch $LOG_FILE
touch $DAILY_LOG_FILE

# cat /dev/null > $LOG_FILE

#######################
# check to see if source & destination file systems are mounted

DF_TEXT=`df -h`
if ! [[ $DF_TEXT =~ .*mn_raid1.* ]]
then
   ERRFLAG=1
fi

if ! [[ $DF_TEXT =~ .*mirror_raid1.* ]]
then
   ERRFLAG=1
fi

if [ $ERRFLAG -eq 1 ]
	# one or more needed filesystems are missing. Bail.
then
  echo "" >> $LOG_FILE
  echo "" >> $DAILY_LOG_FILE
  echo "###  `date`   ###'" >> $LOG_FILE
  echo "###  `date`   ###'" >> $DAILY_LOG_FILE
  echo "###  ONE OR MORE FILE SYSTEMS MISSING. RSYNC CANCELLED.  ###" >> $LOG_FILE
  echo "###  ONE OR MORE FILE SYSTEMS MISSING. RSYNC CANCELLED.  ###" >> $DAILY_LOG_FILE
  echo "" >> $LOG_FILE
  echo "" >> $DAILY_LOG_FILE
  MSG_TEXT="ERROR! One or more file systems required for this rsync were not found. Opus Mirror Rsync cancelled."
  echo "$MSG_TEXT" | mail -s "[ERROR: OPUS RAID1 RE-MIRROR RSYNC]" "$RECIPIENTS"
  exit
fi

#######################
# Get pre-rsync size stats
RAID1_DATA=`df -m | grep '/mn_raid1' | sed -n 1p | awk '{print $2}'`
MIRROR1_DATA_BEFORE=`df -m | grep '/mirror_raid1' | sed -n 1p | awk '{print $2}'`

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
# Get post-rsync size  & log
MIRROR1_DATA_AFTER=`df -m | grep '/mirror_raid1' | sed -n 1p | awk '{print $2}'`
echo "" >> $LOG_FILE
echo "MN_RAID1 DATA SIZE:  " $RAID1_DATA " MB" >> $LOG_FILE
echo "MIRROR1 BEFORE SIZE:  " $MIRROR1_DATA_BEFORE " MB" >> $LOG_FILE
echo "MIRROR1 AFTER SIZE:  " $MIRROR1_DATA_AFTER " MB" >> $LOG_FILE
echo "" >> $LOG_FILE
echo "----------------------------------------------------" >> $LOG_FILE; echo "" >> $LOG_FILE
#######################

# send summary log excerpt to admins
LOG_TAIL=`tail -n 60 $LOG_FILE`
echo "$LOG_TAIL" | mail -s "TEST [OPUS MIRROR RSYNC] TEST" "$RECIPIENTS"

###  END SCRIPT #######
