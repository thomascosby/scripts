LOG_FILE="/usr/schawk/logs/dial_rsync_move.log"
RSYNC="/usr/bin/rsync"
RECIPIENTS="dberks@schawk.com"

SOURCEVOL="/mn_san_arch2/dial_rsync/"
DESTVOL="/mn_raid2/dial_rsync/"

# prep log file
touch $LOG_FILE
# cat /dev/null > $LOG_FILE
echo "" >> $LOG_FILE
echo "###  START RSYNC: "$SOURCEVOL" TO "$DESTVOL >> $LOG_FILE
date >> $LOG_FILE

# perform rsync
# $RSYNC -rlpogtvh --dry-run --delete --max-delete=10000 --stats $SOURCEVOL $DESTVOL 2>&1 | tee $LOG_FILE

$RSYNC -avh --delete --max-delete=10000 --stats $SOURCEVOL $DESTVOL 2>&1 | tee $LOG_FILE

# finish up
echo "" >> $LOG_FILE
date >> $LOG_FILE
echo "###  END RSYNC: "$SOURCEVOL" TO "$DESTVOL >> $LOG_FILE
echo "" >> $LOG_FILE
echo "" >> $LOG_FILE
mail -s "[Rsync - DIAL]" $RECIPIENTS < $LOG_FILE

