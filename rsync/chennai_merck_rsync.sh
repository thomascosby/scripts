#!/bin/sh
#  20140828 - tcosby
#  sync _z assets from Merck_Masters to chennai
#
#  using chennai_rsync_exclude_list.txt for exclude list in the rsync command
#+ file located in /usr/schawk/scripts/rsync/
#
#Variables
LOCK_FILE="/tmp/rsync_chennai_merck.lock"
LOG_FILE="/usr/schawk/logs/rsync/rsync_chennai_merck.log"
DAILY_LOG="/usr/schawk/logs/rsync/rsync_chennai_merck_daily.log"
RSYNC="/usr/bin/rsync"
RECIPIENTS="thomas.cosby@schawk.com"
#RECIPIENTS="thomas.cosby@schawk.com,thold@schawk.com,chause@schawk.com"

#  source is opus server in Minneapolis
SOURCEVOL="/mn_raid2/merck/PCBU93007/Images/"

#  dest is PengRsync01 at Schawk Penang
DESTVOL="172.17.1.132::rsyncmerckmpls"

START_TIME=`date`
touch $DAILY_LOG
touch $LOG_FILE
# reset daily log
cat /dev/null > $DAILY_LOG

#  prevent the script from continuing if it was already running
#+ if script abends, need to manually delete this lock file
if [ -e $LOCK_FILE ]; then
	TIMESTAMP=$(date)
        echo "" >> $DAILY_LOG
	echo "$TIMESTAMP: lock file detected, exiting" >> $DAILY_LOG
        cat $DAILY_LOG >> $LOG_FILE
        mail -s "[Rsync - Mpls Merck to chennai]" $RECIPIENTS < $DAILY_LOG
	exit
fi
touch $LOCK_FILE

echo "" >> $DAILY_LOG
echo "###  rsync Start: $START_TIME  ###" >> $DAILY_LOG

#  uncomment to perform dry run rsync
$RSYNC -rtvzhn --timeout=600 --delete --max-delete=100 --stats --exclude-from '/usr/schawk/scripts/rsync/chennai_rsync_exclude_list.txt' $SOURCEVOL "$DESTVOL" 2>&1 | tee >> $DAILY_LOG
#  perform for reals rsync
#$RSYNC -rtvzh --timeout=600 --delete --max-delete=100 --stats --exclude-from '/usr/schawk/scripts/rsync/chennai_rsync_exclude_list.txt' $SOURCEVOL "$DESTVOL" 2>&1 | tee >> $DAILY_LOG
END_TIME=`date`

echo "" >> $DAILY_LOG
echo "###  $END_TIME" >> $DAILY_LOG;echo "" >> $DAILY_LOG
echo "###  rsync Complete" >> $DAILY_LOG
echo "" >> $DAILY_LOG
cat $DAILY_LOG >> $LOG_FILE
echo "----------------------------------------------------" >> $LOG_FILE; echo "" >> $LOG_FILE
tail -n 20000 $LOG_FILE > tempfile
cat tempfile > $LOG_FILE
rm -f tempfile

rm $LOCK_FILE

#  test the daily log to see if it contains a summary section; if so, append the summary to the run log and mail it to the admins
LOG_TEST=`cat $DAILY_LOG`
if [[ $LOG_TEST = *Number\ of\ files* ]]
then
	LOG_SUMMARY=`grep --after-context=999999 "Number of files:" "$DAILY_LOG"`
else
	LOG_SUMMARY="*** Invalid Daily Log - Summary Data Not Found ***"
fi

echo "###  $START_TIME" > /tmp/rsync_email.txt;echo "" >> /tmp/rsync_email.txt
echo "###  rsync From ""$SOURCEVOL"" TO ""$DESTVOL" >> /tmp/rsync_email.txt
echo "" >> /tmp/rsync_email.txt
echo "$LOG_SUMMARY"  >> /tmp/rsync_email.txt
MAILTEXT=`cat /tmp/rsync_email.txt`
echo "$MAILTEXT" | mail -s "[rsync - MPLS Merck to chennai]" "$RECIPIENTS"

exit 0
#  A zero return value from the script upon exit indicates success
#+ to the shell.
