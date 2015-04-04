LOCK_FILE="/tmp/rsync_penang_gm.lock"
LOG_FILE="/usr/schawk/logs/rsync/TEST_rsync_penang_gm.log"
DAILY_LOG="/usr/schawk/logs/rsync/TEST_rsync_penang_gm_daily.log"
RSYNC="/usr/bin/rsync"
# RECIPIENTS="dberks@schawk.com,tholm@schawk.com"
RECIPIENTS="dberks@schawk.com"

# source is Opus server in Minneapolis
SOURCEVOL="/mn_raid1/generalmills/Assets/"

# dest is PengRsync01 at Schawk Penang
DESTVOL="172.17.1.132::rsyncgmmpls"

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
# touch $LOCK_FILE

# perform rsync
$RSYNC --dry-run -rtvzh --timeout=600 --stats --delete --max-delete=50 --exclude '/Staging/' --exclude '/Assets/Staging/' --exclude '/Assets/TESTING/' --exclude '/TESTING/' --exclude '*_P.psd' --exclude '*_p.psd' --exclude '*_P.PSD' --exclude '*_p.PSD' --exclude '*_P?.psd' --exclude '*_p?.psd' --exclude '*_P?.PSD' --exclude '*_p?.PSD' --exclude '*_P??.psd' --exclude '*_p??.psd' --exclude '*_P??.PSD' --exclude '*_p??.PSD' --exclude '*_P???.psd' --exclude '*_p???.psd' --exclude '*_P???.PSD' --exclude '*_p???.PSD' --exclude '.*' $SOURCEVOL "$DESTVOL" 2>&1 | tee >> $DAILY_LOG

NUM_FILES=`grep "Number of files transferred:" $DAILY_LOG`
TOT_SIZE=`grep "Total transferred file size:" $DAILY_LOG`
read LOG_TEMP < $DAILY_LOG
echo "" > $DAILY_LOG
echo "###  RSYNC START  ###" >> $DAILY_LOG
echo "###  `date`  ###" >> $DAILY_LOG
echo "" >> $DAILY_LOG
echo $NUM_FILES >> $DAILY_LOG;echo "" >> $DAILY_LOG
echo $TOT_SIZE >> $DAILY_LOG;echo "" >> $DAILY_LOG
echo "$LOG_TEMP"  >> $DAILY_LOG;echo "" >> $DAILY_LOG
echo "" >> $DAILY_LOG
echo "###  RSYNC END  ###" >> $DAILY_LOG
echo "###  `date`  ###" >> $DAILY_LOG
echo "" >> $DAILY_LOG

# cat $DAILY_LOG >> $LOG_FILE
mail -s "[TESTING: Rsync - Mpls GM to Penang]" $RECIPIENTS < $DAILY_LOG

# rm $LOCK_FILE
