#!/bin/bash
#  This script rsyncs the nfs mount from vq2pa605.corio.com:/sgk_integ/Client_Integ/GM_Coupon/Final_Dest_Folder to 
#+ /r2/auto/mpx/General_Mills_Coupon_XML by way of /r2/xml_kludge.
#  After the rsync, this script adjusts permissions so 'Switch' can process.
#+ Then it deletes rsyncd files from the source.

#  varibles
LOG_FILE="/usr/schawk/logs/xml_kludge.log"
DAILY_LOG="/usr/schawk/logs/xml_kludge_daily.log"
SOURCEVOL="/mn_raid2/xml_kludge/"
DESTVOL="/mn_raid2/auto/mpx/General_Mills_Coupon_XML/"


# ensure log files exist
touch $DAILY_LOG
touch $LOG_FILE

# reset daily log file
cat /dev/null > $DAILY_LOG
echo "" >> $DAILY_LOG
echo "###  RSYNC START  ###" >> $DAILY_LOG
date >> $DAILY_LOG

# perform rsync
sudo -u applmgr rsync -q -rtuvv --stats --delete-excluded --exclude '.HS*' $SOURCEVOL "$DESTVOL" 2>&1 >> $DAILY_LOG
#chown -R mpx:mpxusers "$DESTVOL"
chmod -R 777 "$DESTVOL"
#
sudo -u applmgr rm -f /mn_raid2/xml_kludge/*.xml
#
echo "" >> $DAILY_LOG
date >> $DAILY_LOG
echo "###  RSYNC END  ###" >> $DAILY_LOG
echo "" >> $DAILY_LOG
cat $DAILY_LOG >> $LOG_FILE
#
#
exit 0
#  A zero return value from the script upon exit indicates success
#+ to the shell.
