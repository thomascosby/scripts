LOCK_FILE="/tmp/rsync_backup.lock"
LOG_FILE="/usr/adm/rsync_penang.log"
RSYNC="/usr/sbin/rsync"

# this version of the Penang rsync will DELETE ALL FILES AT THE PENANG END
# WHICH DO NOT EXIST AT THE MPLS END. It will be run  a couple of times a year
#
# Dan B - 3.10.09


# source is galaxy raid on aardvark in Minneapolis
SOURCEVOL="/galaxy/generalmills"

# dest is Gen Mills volume on server at Schawk Penang
DESTVOL="172.17.1.25::rsyncmpls"

# this block prevents the script from being launched if it's already running
# Note that if script abends for any reason, you may need to manually delete
# the Lock File before the script can be run again
if [ -e $LOCK_FILE ]; then
	TIMESTAMP=$(date)
	echo "$TIMESTAMP: lock file exists, exit now" >> $LOG_FILE
	exit
fi

# the next line would reset the log file to nothing; not wanted in this version of the script
# cat /dev/null > $LOG_FILE

touch $LOCK_FILE

echo "" >> $LOG_FILE
echo "###  RSYNC START  ###" >> $LOG_FILE
date >> $LOG_FILE

# perform rsync

$RSYNC -avz --timeout=600 --delete --max-delete=1000 --exclude '/Assets/Staging/' --exclude '/Assets/TESTING/' --exclude '*_P.psd' --exclude '*_p.psd' --exclude '*_P.PSD' --exclude '*_p.PSD' --exclude '*_P?.psd' --exclude '*_p?.psd' --exclude '*_P?.PSD' --exclude '*_p?.PSD' --exclude '*_P??.psd' --exclude '*_p??.psd' --exclude '*_P??.PSD' --exclude '*_p??.PSD' --exclude '*_P???.psd' --exclude '*_p???.psd' --exclude '*_P???.PSD' --exclude '*_p???.PSD' --exclude '.*' $SOURCEVOL/Assets "$DESTVOL" 2>&1 | tee >> $LOG_FILE

echo "" >> $LOG_FILE
date >> $LOG_FILE
echo "###  RSYNC END  ###" >> $LOG_FILE
echo "" >> $LOG_FILE

rm $LOCK_FILE
