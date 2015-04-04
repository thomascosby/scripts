#!/bin/bash

# this script puts a copy of the Schawk Legends folder into '/office/smartsource" (an smb share) in order
# to make it available to SmartSource sites, such as Penang. It will run once daily.
#
# Dan B - 06.26.14

LOG_FILE="/usr/schawk/logs/copy_mpls_legends.log"

#RECIPIENTS="dberks@schawk.com"
RECIPIENTS="thomas.cosby@schawk.com,tholm@schawk.com,jim.skibbie@schawk.com"

SOURCE="/mn_raid2/office_volumes/office/Schawk Legends"
DESTINATION="/mn_raid2/office_volumes/smartsource/"

# reset log file
touch $LOG_FILE
cat /dev/null > $LOG_FILE
echo "" >> $LOG_FILE
echo "###  LEGEND COPY START  ###" >> $LOG_FILE
date >> $LOG_FILE

# copy folder
/bin/cp -fvrp "$SOURCE" "$DESTINATION" 2>&1 >> $LOG_FILE

# set ownership and permissions
chown -R root:schawk_users "$DESTINATION"
chmod -R 777 "$DESTINATION"

echo "" >> $LOG_FILE
date >> $LOG_FILE
echo "###  LEGEND COPY END  ###" >> $LOG_FILE
echo "" >> $LOG_FILE

mail -s "[Copy - Mpls Legend]" $RECIPIENTS < $LOG_FILE

