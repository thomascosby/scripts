LOG_FILE="/usr/schawk/logs/compare_folders.log"
RSYNC="/usr/bin/rsync"
RECIPIENTS="dberks@schawk.com"

# this script compares two folders using rsync and logs the differences between them
#
# Dan B - 11.13.12

VOLNAME="familydollar"
SOURCEVOL="/mn_san1/jobsarchive/"$VOLNAME"archive/"
DESTVOL="/mn_san_raid2/jobsarchive/"$VOLNAME"archive/"

# prep log file
touch $LOG_FILE
# cat /dev/null > $LOG_FILE
echo "" >> $LOG_FILE
echo "###  START COMPARE: "$VOLNAME" Archive" >> $LOG_FILE
date >> $LOG_FILE

# perform rsync
$RSYNC -rltvh --dry-run --delete --max-delete=100 --stats $SOURCEVOL $DESTVOL 2>&1 >> $LOG_FILE

# finish up
echo "" >> $LOG_FILE
date >> $LOG_FILE
echo "###  END COMPARE: "$VOLNAME" Archive" >> $LOG_FILE
echo "" >> $LOG_FILE
echo "" >> $LOG_FILE
# mail -s "[Rsync - Compare Folders]" $RECIPIENTS < $LOG_FILE

