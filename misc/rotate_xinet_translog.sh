#!/bin/sh -f
# rotate the xinet translog
# runs once a week
dateString=`date '+%m.%d.%y'`
yearNum=`date '+%Y'`
theLog=/usr/schawk/logs/fullpress.trans.log
savedLogs=/usr/schawk/logs/fullpress.translog.archive/
thisYear=/usr/schawk/logs/fullpress.translog.archive/$yearNum
oldLog=$theLog"."$dateString

# rotate & zip old log
cp $theLog $oldLog
gzip $oldLog

# reset the current log
echo "" > $theLog

# create current year folder if it doesn't already exist
mkdir -p "$thisYear"

# move old log into current year archive folder
mv $oldLog".gz" $thisYear

# remove logs older than three years
find $savedLogs fullpress.trans.* -mtime +1095 -exec rm -f {} \;

exit $status
