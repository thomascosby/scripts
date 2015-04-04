# This script checks for the presence of at least one opus mirror daily log created in the past
# two days. If none exists, if warns the admins that the Opus daily raid mirror may be broken.

LOGSUMMARY="/usr/schawk/logs/opus_mirror/opus_mirror.log"
#RECIPIENTS="dberks@schawk.com"
RECIPIENTS="thomas.cosby@schawk.com,tholm@schawk.com"

# if no daily logs exist from the past two days, send an email to the admins
LOGS_FOUND=`find /usr/schawk/logs/opus_mirror/ -name 'opus_mirror_daily*' -mtime -2 | wc -l`

if [ "$LOGS_FOUND" -lt "1" ]; then
  # NO LOGS FOUND
  SUBJECT="[Rsync - OPUS RAIDS MIRROR - WARNING]"
  BODY="There are no daily logs for the Opus Mirror process for the past two days. Might want to look into that."
  echo $BODY | mail -s "$SUBJECT" "$RECIPIENTS"
fi
