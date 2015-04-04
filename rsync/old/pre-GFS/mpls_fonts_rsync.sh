LOG_FILE="/usr/schawk/logs/rsync_mpls_fonts.log"
DAILY_LOG="/usr/schawk/logs/rsync_mpls_fonts_daily.log"
RSYNC="/usr/bin/rsync"
RECIPIENTS="dberks@schawk.com,thomas.cosby@schawk.com"

# this script replaces the contents of folder 'Fonts Schawk" in Producion Files with contents
# of "/r2/fonts_master/". It will run once daily.
#
# Dan B - 07.18.12

SOURCEVOL="/mn_raid2/fonts_master/"
DESTVOL="/mn_raid2/productionfiles/Weston Production/Fonts Schawk/"

# ensure log files exist
touch $DAILY_LOG
touch $LOG_FILE

# reset daily log file
cat /dev/null > $DAILY_LOG
echo "" >> $DAILY_LOG
echo "###  RSYNC START  ###" >> $DAILY_LOG
date >> $DAILY_LOG

# perform rsync
$RSYNC -rltvh --delete --max-delete=100 --timeout=100 --stats $SOURCEVOL "$DESTVOL" 2>&1 >> $DAILY_LOG
chown -R root:schawk_users "$DESTVOL"
chmod -R 777 "$DESTVOL"

echo "" >> $DAILY_LOG
date >> $DAILY_LOG
echo "###  RSYNC END  ###" >> $DAILY_LOG
echo "" >> $DAILY_LOG
cat $DAILY_LOG >> $LOG_FILE
# mail -s "[Rsync - Mpls Fonts]" $RECIPIENTS < $DAILY_LOG

