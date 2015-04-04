LOG_FILE="/usr/schawk/logs/data_copy2.log"
RSYNC="/usr/bin/rsync"
RECIPIENTS="dberks@schawk.com"

# this script copies data on the Opus Server from one location to another
# as part of the Storage Expansion Project
# Dan B - 11.21.12

SOURCEVOL="/mn_raid2/*"
DESTVOL="/mn_san_raid2/"

# prep log file
touch $LOG_FILE
# cat /dev/null > $LOG_FILE
echo "" >> $LOG_FILE
echo "###  START COPY2: "$SOURCEVOL" TO "$DESTVOL >> $LOG_FILE
date >> $LOG_FILE

# perform rsync
$RSYNC -rltvh --stats $SOURCEVOL $DESTVOL 2>&1 >> $LOG_FILE

# finish up
echo "" >> $LOG_FILE
date >> $LOG_FILE
echo "###  END DATA COPY2: "$SOURCEVOL" TO "$DESTVOL >> $LOG_FILE
echo "" >> $LOG_FILE
echo "" >> $LOG_FILE
mail -s "[Rsync - DATA COPY2]" $RECIPIENTS < $LOG_FILE

