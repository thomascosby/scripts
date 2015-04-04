# This script checks for the presence of at least one opus mirror daily log created in the past
# two days. If none exists, if warns the admins that the Opus daily raid mirror may be broken.

LOGPATH="/usr/schawk/logs/"
LOGNAME="opus_mirror_daily*"
RECIPIENTS="dberks@schawk.com"
SUBJECT="[Rsync - OPUS RAIDS MIRROR - ERROR]"
BODY="OPUS DAILY MIRROR: No log files exist for the past two days"

# if no daily logs exist from the past two days, send an email to the admins
LOGS_FOUND=`find $LOGPATH -name $LOGNAME -mtime -2 | wc -l`
if [ "$LOGS_FOUND" -lt "1" ]; then
  echo $BODY | mail -s "$SUBJECT" "$RECIPIENTS"
  echo "NO LOGS FOUND"
else
  echo "LOGS FOUND"
fi

#if [ "$FOUND" -gt "0" ] ; then
#  echo "FOUND FILES"
#else
#   echo "NOT FOUND"
#fi
