LOGPATH="/usr/schawk/logs/"
LOGNAME="opus_mirror_daily*"
RECIPIENTS="dberks@schawk.com"
SUBJECT="[Rsync - OPUS RAIDS MIRROR - WARNING]"
BODY="No daily logs exist for the past two days. Might want to look into that."

LOGS_FOUND=`find $LOGPATH -name $LOGNAME -mtime -2 | wc -l`

if [ "$LOGS_FOUND" -lt "1" ]; then
  echo "NO LOGS FOUND"
  #echo $BODY | mail -s "$SUBJECT" "$RECIPIENTS"
else
  echo "LOGS FOUND"
fi
