#!/bin/bash
#  this script looks for and deletes files in Scans older than 5 days
#  v1.0 - 20140813 - tcosby
#  v2.0 - 20141013 - tcosby - removed the 'find -type d' as it was not removing files as desired.
#+ now script looks for anything older than 5 days and deletes it.
#
#  varibles
LOG_DIR=/var/log/scan_log/weekly.log
SCANS=/Volumes/Scans/*/*

# find and delete any directories/files in Scans older than 5 days
#  dividing lines for log file 
echo "+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+" >> $LOG_DIR
#  separated by date
date +"%D - %T" >> $LOG_DIR
echo "+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+" >> $LOG_DIR

find $SCANS -mtime +4 >> $LOG_DIR
echo "+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+" >> $LOG_DIR
#  added empty line at end of text
echo "+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+" >> $LOG_DIR ; echo "" >> $LOG_DIR

find $SCANS -mtime +4 -exec rm -rf {} \;

exit 0
#  A zero return value from the script upon exit indicates success
#+ to the shell.
