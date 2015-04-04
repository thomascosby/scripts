#!/bin/bash

#  runs daily rsync backup scripts
#  v2.0 2014-05-05 tcosby
#  v2.1 2014-07-24 added biz dev - tcosby
#  v2.1 2014-07-25 added Anthem - tcosby

TIMESTAMP=`date '+%m.%d.%y-%H.%M'`
LOG_FILE="/Library/Logs/rsync/rsync_fileserver.log"

RECIPIENTS="tholm@schawk.com,chause@schawk.com,thomas.cosby@anthemww.com"
#RECIPIENTS="thomas.cosby@anthemww.com"

# RUN LOCAL RSYNCS

echo "" >> $LOG_FILE
echo "===========================================================" >> $LOG_FILE
echo "===   `date`" >> $LOG_FILE
echo "===   START LOCAL RSYNCS" >> $LOG_FILE
echo "" >> $LOG_FILE

# ADMINISTRATION
echo "   START ADMINISTRATION LOCAL : `date`" >> $LOG_FILE
/Library/Scripts/Schawk/rsync_local_administration.sh
echo "   COMPLETE ADMINISTRATION : `date`" >> $LOG_FILE
echo "   ---------------------------------------------------" >> $LOG_FILE

# OPERATIONS
echo "   START OPERATIONS LOCAL : `date`" >> $LOG_FILE
/Library/Scripts/Schawk/rsync_local_operations.sh
echo "   COMPLETE OPERATIONS : `date`" >> $LOG_FILE
echo "   ---------------------------------------------------" >> $LOG_FILE

# Biz Dev
echo "   START BIZ DEV LOCAL : `date`" >> $LOG_FILE
/Library/Scripts/Schawk/rsync_local_bizdev.sh
echo "   COMPLETE BIZ DEV : `date`" >> $LOG_FILE
echo "   ---------------------------------------------------" >> $LOG_FILE

# ANTHEM
echo "   START ANTHEM LOCAL : `date`" >> $LOG_FILE
/Library/Scripts/Schawk/rsync_local_anthem.sh
echo "   COMPLETE ANTHEM : `date`" >> $LOG_FILE
echo "   ---------------------------------------------------" >> $LOG_FILE

# Clients
echo "   START CLIENTS LOCAL : `date`" >> $LOG_FILE
/Library/Scripts/Schawk/rsync_local_clients.sh
echo "   COMPLETE CLIENTS : `date`" >> $LOG_FILE
echo "   ---------------------------------------------------" >> $LOG_FILE

echo "" >> $LOG_FILE
echo "===   `date`" >> $LOG_FILE
echo "===   LOCAL RSYNCS COMPLETE" >> $LOG_FILE
echo "===========================================================" >> $LOG_FILE

# RUN REMOTE RSYNCS

echo "===   `date`" >> $LOG_FILE
echo "===   START REMOTE RSYNCS" >> $LOG_FILE
echo "" >> $LOG_FILE

# ADMINISTRATION
echo "   START ADMINISTRATION_BU REMOTE : `date`" >> $LOG_FILE
/Library/Scripts/Schawk/rsync_remote_administration.sh
echo "   COMPLETE ADMINISTRATION_BU : `date`" >> $LOG_FILE
echo "   ---------------------------------------------------" >> $LOG_FILE

# OPERATIONS
echo "   START OPERATIONS_BU REMOTE : `date`" >> $LOG_FILE
/Library/Scripts/Schawk/rsync_remote_operations.sh
echo "   COMPLETE OPERATIONS_BU : `date`" >> $LOG_FILE
echo "   ---------------------------------------------------" >> $LOG_FILE

# Biz Dev
echo "   START BIZDEV_BU REMOTE : `date`" >> $LOG_FILE
/Library/Scripts/Schawk/rsync_remote_bizdev.sh
echo "   COMPLETE BIZDEV_BU : `date`" >> $LOG_FILE
echo "   ---------------------------------------------------" >> $LOG_FILE

# ANTHEM
echo "   START ANTHEM_BU REMOTE : `date`" >> $LOG_FILE
/Library/Scripts/Schawk/rsync_remote_anthem.sh
echo "   COMPLETE ANTHEM_BU : `date`" >> $LOG_FILE
echo "   ---------------------------------------------------" >> $LOG_FILE

# Clients
echo "   START CLIENTS_BU REMOTE : `date`" >> $LOG_FILE
/Library/Scripts/Schawk/rsync_remote_clients.sh
echo "   COMPLETE CLIENTS : `date`" >> $LOG_FILE
echo "   ---------------------------------------------------" >> $LOG_FILE

echo "" >> $LOG_FILE
echo "===   `date`" >> $LOG_FILE
echo "===   REMOTE RSYNCS COMPLETE" >> $LOG_FILE
echo "===========================================================" >> $LOG_FILE

exit 0
#  A zero return value from the script upon exit indicates success
#+ to the shell.
