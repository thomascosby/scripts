# This script checks for the presence of at least one opus mirror daily log created in the past
# two days. If none exists, if warns the admins that the Opus daily raid mirror may be broken.

LOGSUMMARY="/usr/schawk/logs/opus_mirror/opus_mirror.log"
RECIPIENTS="dberks@schawk.com,tholm@schawk.com"
#RECIPIENTS="dberks@schawk.com"

# if no daily logs exist from the past two days, send an email to the admins
LOGS_FOUND=`find /usr/schawk/logs/opus_mirror/ -name 'opus_mirror_daily*' -mtime -2 | wc -l`

if [ "$LOGS_FOUND" -lt "1" ]; then
  # NO LOGS FOUND
  SUBJECT="[Rsync - OPUS RAIDS MIRROR - WARNING]"
  BODY="There are no daily logs for the Opus Mirror process for the past two days. Might want to look into that."
  echo $BODY | mail -s "$SUBJECT" "$RECIPIENTS"
fi

# if today is Monday, send the last 200 lines of the summary log to the admins
#if [[ $(date +%u) -eq 1 ]]; then
#  SUBJECT="[Rsync - OPUS RAIDS MIRROR - Weekly Summary]"
#  SUMM_LOG_TAIL=`tail -200 $LOGSUMMARY`
#  echo "$SUMM_LOG_TAIL" | mail -s "$SUBJECT" "$RECIPIENTS"
#fi


