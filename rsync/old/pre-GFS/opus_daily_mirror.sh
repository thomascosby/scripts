#!/bin/bash
TIMESTAMP=`date '+%m.%d.%y-%H.%M'`
DAILY_LOG_FILE="/usr/schawk/logs/opus_mirror/opus_mirror_daily_"$TIMESTAMP".log"
LOG_FILE="/usr/schawk/logs/opus_mirror/opus_mirror.log"
RSYNC="/usr/bin/rsync"
RECIPIENTS="dberks@schawk.com,tholm@schawk.com,thomas.cosby@schawk.com"
#RECIPIENTS="dberks@schawk.com"
ERRFLAG=0

touch $LOG_FILE
touch $DAILY_LOG_FILE
# uncomment next line to reset log
# cat /dev/null > $LOG_FILE

#######################
# check to see if all source & destination file systems are mounted
FAILFLAG=0
DF_TEXT=`df -h`
if ! [[ $DF_TEXT =~ .*mn_raid1.* ]]
then
   FAILFLAG=1
fi

if ! [[ $DF_TEXT =~ .*mn_raid2.* ]]
then
   FAILFLAG=1
fi

if ! [[ $DF_TEXT =~ .*mirror_raid1.* ]]
then
   FAILFLAG=1
fi

if ! [[ $DF_TEXT =~ .*mirror_raid2.* ]]
then
   FAILFLAG=1
fi

if [ $FAILFLAG -eq 1 ]
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
  echo "$MSG_TEXT" | mail -s "[ERROR: OPUS MIRROR RSYNC]" "$RECIPIENTS"
  exit
fi

#######################
# RSYNC MN_RAID1

SOURCEVOL="/mn_raid1/"
DESTVOL="/mirror_raid1/"
echo "###  `date`" >> $DAILY_LOG_FILE
echo "###  `date`" >> $LOG_FILE
echo "###  START RSYNC "$SOURCEVOL" TO "$DESTVOL >> $DAILY_LOG_FILE
echo "###  START RSYNC "$SOURCEVOL" TO "$DESTVOL >> $LOG_FILE

$RSYNC -ahv --stats --delete-excluded --delete --force $SOURCEVOL $DESTVOL 2>&1 >> $DAILY_LOG_FILE || ERRFLAG=1

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

$RSYNC -ahv --protect-args --delete-excluded --stats --delete --force --exclude-from='/usr/schawk/scripts/rsync/opus_mirror_exclude' $SOURCEVOL $DESTVOL 2>&1 >> $DAILY_LOG_FILE || ERRFLAG=1

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
