#!/bin/bash
# v 1.00 - 01.31.13 - Dan B
# v 1.01 - 03.26.13 - Dan B  - redirect output to /usr/schawk/logs
# v 1.02 - 12.12.13 - Dan B  - fixed 080_QC "find" error
#
# deletes unneeded data from jobs in Archive Staging folders for all clients on MN_RAID1 and MN_RAID2
#
# REVISED FOR GFS - Dan B - 06.26.14

logPath="/usr/schawk/logs/archiving/TESTarchive.log"
touch $logPath
dateStamp=`date +%m%d%y.%H%M%S`
cleanupLogPath="/usr/schawk/logs/archiving/cleanup"

#echo;echo "THIS SCRIPT IS UNDER CONSTRUCTION AND CANNOT BE RUN AT THIS TIME.";echo "SEE DAN BERKS FOR MORE INFORMATION.";echo;exit 1

echo
echo "This script removes unwanted files from job folders in all client Archive Staging folders"
echo
read -p "Are you sure you want to proceed? (y/n) " -n 1
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    exit 1
fi

echo "########################################" >> $logPath
echo "ARCHIVING BEGINS: "`date` >> $logPath
echo "########################################" >> $logPath
echo "Beginning Volume Sizes" >> $logPath
echo >> $logPath
echo "`df -h | grep "%" | grep -v "shm"`" >> $logPath
echo >> $logPath;echo >> $logPath;echo "Cleanup Run Begins "$dateStamp >> $logPath;echo >> $logPath
echo "*** Size of Archive Staging Folders Before Cleanup ***" >> $logPath;echo >> $logPath;du -scm /mn_raid*/*jobs/Archive\ Staging/ >> $logPath;echo >> $logPath

######################################################
echo  "  Deleting 'Z_Delete' & '999_Delete' folders:  " >> $logPath
echo "     Start:  " `date` >> $logPath

# legacy
find /mn_raid*/*jobs/Archive\ Staging/*/*/Z_Delete\ At\ Archive -depth  >> $cleanupLogPath/Z_Delete_$dateStamp.log

# GFS
find /mn_raid*/*jobs/Archive\ Staging/*/*/999_Delete_at_Archive -depth  >> $cleanupLogPath/Z_Delete_$dateStamp.log

# legacy Other Clients
find /mn_raid2/otherclientsjobs/Archive\ Staging/*/*/*/Z_Delete\ At\ Archive -depth  >> $cleanupLogPath/Z_Delete_$dateStamp.log

# GFS Other Clients
find /mn_raid2/otherclientsjobs/Archive\ Staging/*/*/*/999_Delete_at_Archive -depth  >> $cleanupLogPath/Z_Delete_$dateStamp.log

echo "     End:  " `date` >> $logPath;echo >> $logPath
#####################################################
echo  "  Deleting 'Config' folders:  " >> $logPath
echo "     Start:  " `date` >> $logPath

# all clients
find /mn_raid*/*jobs/Archive\ Staging/*/*/config -depth  >> /usr/schawk/logs/archiving/cleanup/config_$dateStamp.log

# GFS Other Clients
find /mn_raid2/otherclientsjobs/Archive\ Staging/*/*/*/config -depth  >> /usr/schawk/logs/archiving/cleanup/config_$dateStamp.log

echo "     End:  " `date` >> $logPath;echo >> $logPath
#####################################################
echo  "  Deleting 'Temp' folders:  " >> $logPath
echo "     Start:  " `date` >> $logPath

# all clients
find /mn_raid*/*jobs/Archive\ Staging/*/*/temp -depth  >> $cleanupLogPath/temp_$dateStamp.log

# GFS Other Clients
find /mn_raid2/otherclientsjobs/Archive\ Staging/*/*/*/temp -depth  >> $cleanupLogPath/temp_$dateStamp.log

echo "     End:  " `date` >> $logPath;echo >> $logPath
#####################################################
echo  "  Deleting 'incoming_data' folders:  " >> $logPath
echo "     Start:  " `date` >> $logPath

# all clients
find /mn_raid*/*jobs/Archive\ Staging/*/*/incoming_data -depth  >> /usr/schawk/logs/archiving/cleanup/incoming_data_$dateStamp.log

# GFS Other Clients
find /mn_raid2/otherclientsjobs/Archive\ Staging/*/*/*/incoming_data -depth  >> /usr/schawk/logs/archiving/cleanup/incoming_data_$dateStamp.log

echo "     End:  " `date` >> $logPath;echo >> $logPath
#####################################################
echo  "  Deleting Legacy '080_QC' folders (except '3D Render', 'Code Ver', 'Compare', 'PDF for Blue'):  " >> $logPath
echo "     Start:  " `date` >> $logPath

# all clients
echo "          -- legacy jobs --" >> $logPath
find /mn_raid*/*jobs/Archive\ Staging/*/*/080_QC/ -depth | grep -vE '/080_QC/3D Renderings|/080_QC/Code Verification|/080_QC/Compare|/080_QC/PDF for Blue|080_QC/$' | while read foundItem
do
	echo "$foundItem" >> $cleanupLogPath/080_QC_$dateStamp.log
	#rm -rf "$foundItem"
done

# GFS Other Clients
echo "          -- GFS Other Clients jobs --" >> $logPath
find /mn_raid2/otherclientsjobs/Archive\ Staging/*/*/*/080_QC/ -depth | grep -vE '/080_QC/3D Renderings|/080_QC/Code Verification|/080_QC/Compare|/080_QC/PDF for Blue|080_QC/$' | while read foundItem
do
	echo "$foundItem" >> $cleanupLogPath/080_QC_$dateStamp.log
	#rm -rf "$foundItem"
done

echo "     End:  " `date` >> $logPath;echo >> $logPath
#
echo "Cleanup Ends: " `date` >> $logPath;echo >> $logPath
echo "*** Size of Archive Staging Folders After Cleanup ***" >> $logPath;echo >> $logPath;du -scm /mn_raid*/*jobs/Archive\ Staging/ >> $logPath;echo >> $logPath;echo >> $logPath
