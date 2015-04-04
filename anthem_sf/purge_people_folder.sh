#!/bin/bash
#  this script looks for and deletes files in People older than 30 days
#  v1.0 - 20140808 - tcosby
#  has ability to delete everything and retain structure.
#+ just uncomment lines 17 & 23. then comment out lines 16 & 22 
#
#
#  varibles
LOG_DIR=/Library/Logs/people_monthly/monthly.log
PEOPLE=/Volumes/3TB_R02B/People/
RECIPIENTS="thomas.cosby@schawk.com"
#
#
# find and delete any directories in People older than 30 days
#  dividing lines for log file 
echo "+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+" >> $LOG_DIR
#  separated by date
date +"%D - %T" >> $LOG_DIR
echo "+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+" >> $LOG_DIR
#
#
find $PEOPLE*/* -mtime +30 >> $LOG_DIR
#ls -lhRF $PEOPLE >> $LOG_DIR
echo "+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+" >> $LOG_DIR
#  added empty line at end of text
echo "+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+" >> $LOG_DIR ; echo "" >> $LOG_DIR
#
#
find $PEOPLE*/* -mtime +30 -exec rm -rf {} \;
#rm -Rf $PEOPLE*/*
#
echo "###  $START_TIME" > /tmp/people_purge_email.txt
echo "" >> /tmp/people_purge_email.txt
MAILTEXT=`cat /tmp/people_purge_email.txt`
echo "$MAILTEXT" | mail -s "People Purge Sucess" "RECIPIENTS"

#
exit 0
#  A zero return value from the script upon exit indicates success
#+ to the shell.
