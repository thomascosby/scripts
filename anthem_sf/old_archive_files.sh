#!/bin/bash
#  this script looks for and deletes files in People older than 30 days

#  varibles
LOG_DIR=/Users/localadmin/Desktop/old_archive_files.log
PEOPLE=/Volumes/10TB_RAID/Archive/

# find and delete any directories in People older than 30 days
#  dividing lines for log file 
echo "+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+" >> $LOG_DIR
#  separated by date
date +"%D - %T" >> $LOG_DIR
echo "+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+" >> $LOG_DIR
echo "files that are 3 years old" >>$LOG_DIR
echo "" >>$LOG_DIR

#find /Volumes/3TB_R02B/People/* -type d -mtime +31 -exec rm -Rf {} \;
find $PEOPLE*/* -type d -mtime +1095 >> $LOG_DIR
echo "+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+" >> $LOG_DIR
#  added empty line at end of text
echo "+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+" >> $LOG_DIR ; echo "" >> $LOG_DIR

#find $PEOPLE*/* -type d -mtime +31 -exec rm -rf {} \;

exit 0
#  A zero return value from the script upon exit indicates success
#+ to the shell.