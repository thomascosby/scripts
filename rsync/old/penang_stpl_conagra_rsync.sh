LOCK_FILE="/tmp/rsync_conagra.lock"
LOG_FILE="/usr/schawk/logs/rsync_conagra_penang.log"
DAILY_LOG="/usr/schawk/logs/rsync_conagra_penang_daily.log"
RSYNC="/usr/bin/rsync"
# RECIPIENTS="dberks@schawk.com,tholm@schawk.com"
RECIPIENTS="dberks@schawk.com"

# this version DELETES files at Penang which don't exist at the St. Paul end.
# This script must run on St. Paul server!
#
# Dan B - 10.7.09

# source is StplElsoXServe in St. Paul
SOURCEVOL="/ElsoXRAID1/ConAga Assets"

# dest is volume Rsync_1 on server at Schawk Penang
DESTVOL="172.17.1.25::rsyncstpl"

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
        mail -s "[Penang Rsync Log]" $RECIPIENTS < $DAILY_LOG
	exit
fi
touch $LOCK_FILE

echo "" >> $DAILY_LOG
echo "###  RSYNC START  ###" >> $DAILY_LOG
date >> $DAILY_LOG

# perform rsync

$RSYNC -avzh --timeout=600 --stats --exclude '.*' $SOURCEVOL "$DESTVOL" 2>&1 | tee >> $DAILY_LOG

# $RSYNC -avzh --timeout=600 --stats --delete --max-delete=1000 --exclude '.*' $SOURCEVOL "$DESTVOL" 2>&1 | tee >> $DAILY_LOG

echo "" >> $DAILY_LOG
date >> $DAILY_LOG
echo "###  RSYNC END  ###" >> $DAILY_LOG
echo "" >> $DAILY_LOG
cat $DAILY_LOG >> $LOG_FILE
mail -s "[Penang ConAgra Rsync Log]" $RECIPIENTS < $DAILY_LOG

rm $LOCK_FILE
