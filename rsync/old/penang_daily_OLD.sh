LOCK_FILE="/tmp/rsync_backup.lock"
LOG_FILE="/usr/schawk/logs/rsync_penang.log"
DAILY_LOG="/usr/schawk/logs/rsync_penang_daily.log"
RSYNC="/usr/bin/rsync"
RECIPIENTS="dberks@schawk.com,tholm@schawk.com"

# this version DOES NOT delete files at Penang which
# don't exist at the Mpls end. It runs twice a day.
#
# Dan B - 8.25.09

# source is opus in Minneapolis
SOURCEVOL="/mn_raid1/generalmills"

# dest is Gen Mills volume on server at Schawk Penang
DESTVOL="172.17.1.25::rsyncmpls"

# ensure log files exist
touch $DAILY_LOG
touch $LOG_FILE

# reset daily log file
cat /dev/null > $DAILY_LOG

# prevent the script from continuing if was already running
# if script abends, need to manually delete the Lock file
# before the script can be run again
if [ -e $LOCK_FILE ]; then
	TIMESTAMP=$(date)
        echo "" >> $DAILY_LOG
	echo "$TIMESTAMP: lock file exists, exiting" >> $DAILY_LOG
        cat $DAILY_LOG >> $LOG_FILE
        mail -s "[Rsync - Mpls GM to Penang]" $RECIPIENTS < $DAILY_LOG
	exit
fi
touch $LOCK_FILE

echo "" >> $DAILY_LOG
echo "###  RSYNC START  ###" >> $DAILY_LOG
date >> $DAILY_LOG

# perform rsync

$RSYNC -avzh --timeout=600 --stats --update --exclude '/Assets/Staging/' --exclude '/Assets/TESTING/' --exclude '*_P.psd' --exclude '*_p.psd' --exclude '*_P.PSD' --exclude '*_p.PSD' --exclude '*_P?.psd' --exclude '*_p?.psd' --exclude '*_P?.PSD' --exclude '*_p?.PSD' --exclude '*_P??.psd' --exclude '*_p??.psd' --exclude '*_P??.PSD' --exclude '*_p??.PSD' --exclude '*_P???.psd' --exclude '*_p???.psd' --exclude '*_P???.PSD' --exclude '*_p???.PSD' --exclude '.*' $SOURCEVOL/Assets "$DESTVOL" 2>&1 | tee >> $DAILY_LOG

echo "" >> $DAILY_LOG
date >> $DAILY_LOG
echo "###  RSYNC END  ###" >> $DAILY_LOG
echo "" >> $DAILY_LOG
cat $DAILY_LOG >> $LOG_FILE
mail -s "[Rsync - Mpls GM to Penang]" $RECIPIENTS < $DAILY_LOG

rm $LOCK_FILE
