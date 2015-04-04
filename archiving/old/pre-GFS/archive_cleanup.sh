#!/bin/bash
# v 1.00 - 01.31.13 - Dan B
# v 1.01 - 03.26.13 - Dan B  - redirect output to /usr/schawk/logs
# v 1.02 - 12.12.13 - Dan B  - fixed 080_QC "find" error
#
# deletes unneeded data from jobs in Archive Staging folders for all clients on MN_RAID1 and MN_RAID2

logPath="/usr/schawk/logs/archiving/archive.log"
touch $logPath
dateStamp=`date +%m%d%y.%H%M%S`
cleanupLogPath="/usr/schawk/logs/archiving/cleanup"

echo "########################################" >> $logPath
echo "ARCHIVING BEGINS: "`date` >> $logPath
echo "########################################" >> $logPath
echo "Beginning Volume Sizes" >> $logPath
echo >> $logPath
echo "`df -h | grep "%" | grep -v "shm"`" >> $logPath
echo >> $logPath;echo >> $logPath;echo "Cleanup Run Begins "$dateStamp >> $logPath;echo >> $logPath
echo "*** Size of Archive Staging Folders Before Cleanup ***" >> $logPath;echo >> $logPath;du -scm /r*/*jobs/*WIP/Archive\ Staging/ >> $logPath;echo >> $logPath

echo  "  Deleting 'Z_Delete at Archive' folders:  " >> $logPath
echo "     Start:  " `date` >> $logPath
find /mn_raid*/*/*/Archive\ Staging/*/*/Z_Delete\ At\ Archive -depth -exec rm -Rfv {} \; >> $cleanupLogPath/Z_Delete_$dateStamp.log
echo "     End:  " `date` >> $logPath;echo >> $logPath

echo  "  Deleting 'Config' folders:  " >> $logPath
echo "     Start:  " `date` >> $logPath
find /mn_raid*/*/*/Archive\ Staging/*/*/config -depth -exec rm -Rfv {} \; >> /usr/schawk/logs/archiving/cleanup/config_$dateStamp.log
echo "     End:  " `date` >> $logPath;echo >> $logPath

echo  "  Deleting 'Temp' folders:  " >> $logPath
echo "     Start:  " `date` >> $logPath
find /mn_raid*/*/*/Archive\ Staging/*/*/temp -depth -exec rm -Rfv {} \; >> $cleanupLogPath/temp_$dateStamp.log
echo "     End:  " `date` >> $logPath;echo >> $logPath

echo  "  Deleting 'incoming_data' folders:  " >> $logPath
echo "     Start:  " `date` >> $logPath
find /mn_raid*/*/*/Archive\ Staging/*/*/incoming_data -depth -exec rm -Rfv {} \; >> /usr/schawk/logs/archiving/cleanup/incoming_data_$dateStamp.log
echo "     End:  " `date` >> $logPath;echo >> $logPath

echo  "  Deleting '080_QC' folders (except '3D Render', 'Code Ver', 'Compare', 'PDF for Blue'):  " >> $logPath
echo "     Start:  " `date` >> $logPath

find /mn_raid*/*/*/Archive\ Staging/*/*/080_QC/ -depth | grep -vE '/080_QC/3D Renderings|/080_QC/Code Verification|/080_QC/Compare|/080_QC/PDF for Blue|080_QC/$' | while read foundItem
do
	echo "$foundItem" >> $cleanupLogPath/080_QC_$dateStamp.log
	rm -rf "$foundItem"
done

echo "     End:  " `date` >> $logPath;echo >> $logPath
#
echo "Cleanup Ends: " `date` >> $logPath;echo >> $logPath
echo "*** Size of Archive Staging Folders After Cleanup ***" >> $logPath;echo >> $logPath;du -scm /r*/*jobs/*WIP/Archive\ Staging/ >> $logPath;echo >> $logPath;echo >> $logPath
