#!/bin/bash
# v 1.00 - 06.23.14 - REVISED FOR GFS - Dan B
# v 2.00 - 07.02.14 - REVISED TO UNLOCK ARCHIVE AND LOG FOLDERS - Jim S

# unlocks all Archive Staging and Log folders, making them r/w to everyone
# this script must be run before Denny runs his Archiving script

echo ""
echo "###  UNLOCKING ARCHIVE STAGING FOLDERS   ###"
chown -R root:schawk_users /mn_raid*/*jobs/Archive\ Staging
chmod -R 777 /mn_raid*/*jobs/Archive\ Staging

echo "###  UNLOCKING LOG FOLDERS   ###"
chown -R root:schawk_users /mn_raid*/*jobs/Logs
chmod -R 777 /mn_raid*/*jobs/Logs

echo ""
echo "###  ARCHIVE STAGING/LOG UNLOCKING COMPLETE  ###"
echo ""
