#!/bin/sh -f
#
# a script to rotate backup copies of Filemaker databases  -  Dan B - 05.30.14

# the FM Pro Server backs up its databases to a local folder on the server;
# those databases are then copied to a directory in the Office volume on Opus
# so they get backed up to tape. This script limits the number of backup copies
# retained in this location by deleting copies older than a specified date.
# The script also counts the number of backup dirs in the backup location (NUM_DIRS);
# if that  number falls below a certain threshold (MIN_DIRS), it assumes FM database
# backups are not occurring and fires off a email warning.

# path to the Filemaker database backups on Opus
BU_PATH="/mn_raid2/office_volumes/office/Dept-Office/IT Backups/FileMaker Pro 11 OPUS/"

# DELETE DAILY BACKUPS OLDER THAN 8 DAYS
find "$BU_PATH" -maxdepth 1 -type d -iname 'Daily*' -mtime +8 -exec rm -rf {} \;

# DELETE WEEKLY BACKUPS OLDER THAN 60 DAYS
find "$BU_PATH" -maxdepth 1 -type d -iname 'Weekly*' -mtime +60 -exec rm -rf {} \;

# COUNT HOW MANY BACKUP DIR REMAIN IN THE BU DESTINATION; SEND EMAIL ERROR IF LESS THAN MINIMUM
NUM_DIRS=`find "$BU_PATH" -maxdepth 1 -type d | wc -l`
MIN_DIRS=10
RECIPIENTS="tholm@schawk.com,chause@schawk.com"

if (( $NUM_DIRS < $MIN_DIRS ))
  then
    MAILTEXT="This is an automated message sent from the 'rotate_fm_db_backups' script on Opus Server. The number of backups in 'Office/Dept-Office/IT Backups/Filemaker Pro 11 OPUS' is less than the expected minimum. This could indicate that FM database backups are no longer occurring. Someone should investigate."
    echo "$MAILTEXT" | mail -s "THIS IS A TEST - DISREGARD [ERROR - Filemaker Pro Database Backups]" "$RECIPIENTS"
fi

exit
