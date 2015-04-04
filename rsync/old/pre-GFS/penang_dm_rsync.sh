#!/bin/sh
# syncs _Z Del Monte Assets
#
# Dan B - 02.18.10
# Dan B - 01.20.14 - standardized logging across Penang rsyncs

LOCK_FILE="/tmp/rsync_penang_dm.lock"
LOG_FILE="/usr/schawk/logs/rsync/rsync_penang_dm.log"
DAILY_LOG="/usr/schawk/logs/rsync/rsync_penang_dm_daily.log"
RSYNC="/usr/bin/rsync"
#RECIPIENTS="dberks@schawk.com,tholm@schawk.com"
RECIPIENTS="dberks@schawk.com,thomas.cosby@schawk.com"

# source is opus in Minneapolis
SOURCEVOL="/mn_raid2/otherclients/Assets/Del Monte/"

# dest is PengRsync01 at Schawk Penang
DESTVOL="172.17.1.132::rsyncdmmpls"

START_TIME=`date`
touch $DAILY_LOG
touch $LOG_FILE
# reset daily log
cat /dev/null > $DAILY_LOG

# prevent the script from continuing if it was already running
# if script abends, need to manually delete this lock file
if [ -e $LOCK_FILE ]; then
	TIMESTAMP=$(date)
        echo "" >> $DAILY_LOG
	echo "$TIMESTAMP: lock file detected, exiting" >> $DAILY_LOG
        cat $DAILY_LOG >> $LOG_FILE
        mail -s "[Rsync - Mpls Del Monte to Penang]" $RECIPIENTS < $DAILY_LOG
	exit
fi
touch $LOCK_FILE

echo "" >> $DAILY_LOG
echo "###  RSYNC START: $START_TIME  ###" >> $DAILY_LOG

# perform rsync
$RSYNC -rtvzh --timeout=600 --delete --max-delete=100 --stats --exclude '*_P.psd' --exclude '*_p.psd' --exclude '*_P.PSD' --exclude '*_p.PSD' --exclude '*_P?.psd' --exclude '*_p?.psd' --exclude '*_P?.PSD' --exclude '*_p?.PSD' --exclude '*_P??.psd' --exclude '*_p??.psd' --exclude '*_P??.PSD' --exclude '*_p??.PSD' --exclude '*_P???.psd' --exclude '*_p???.psd' --exclude '*_P???.PSD' --exclude '*_p???.PSD' --exclude '.*' "$SOURCEVOL" "$DESTVOL" 2>&1 | tee >> $DAILY_LOG

END_TIME=`date`

echo "" >> $DAILY_LOG
echo "###  $END_TIME" >> $DAILY_LOG;echo "" >> $DAILY_LOG
echo "###  RSYNC COMPLETE" >> $DAILY_LOG
echo "" >> $DAILY_LOG
cat $DAILY_LOG >> $LOG_FILE
echo "----------------------------------------------------" >> $LOG_FILE; echo "" >> $LOG_FILE
tail -n 20000 $LOG_FILE > tempfile
cat tempfile > $LOG_FILE
rm -f tempfile

rm $LOCK_FILE

# test the daily log to see if it contains a summary section; if so, append the summary to the run log and mail it to the admins
LOG_TEST=`cat $DAILY_LOG`
if [[ $LOG_TEST = *Number\ of\ files* ]]
then
	LOG_SUMMARY=`grep --after-context=999999 "Number of files:" "$DAILY_LOG"`
else
	LOG_SUMMARY="*** INVALID DAILY LOG - SUMMARY DATA NOT FOUND ***"
fi

echo "###  $START_TIME" > /tmp/rsync_email.txt;echo "" >> /tmp/rsync_email.txt
echo "###  RSYNC FROM ""$SOURCEVOL"" TO ""$DESTVOL" >> /tmp/rsync_email.txt
echo "" >> /tmp/rsync_email.txt
echo "$LOG_SUMMARY"  >> /tmp/rsync_email.txt
MAILTEXT=`cat /tmp/rsync_email.txt`
echo "$MAILTEXT" | mail -s "[Rsync - Mpls Del Monte to Penang]" "$RECIPIENTS"
