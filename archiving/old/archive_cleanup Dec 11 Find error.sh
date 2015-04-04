#!
# v 1.0  -  01.31.13  -  Dan B / Jim S
# v 1.01 - 03.26.13  - Dan B  - redirect output to /usr/schawk/logs
# 
# deletes unwanted folders from jobs in Archive Staging folders for all clients on MN_RAID1 and MN_RAID2
#
logPath="/usr/schawk/logs/archiving/archive.log"
touch $logPath

echo "########################################" >> $logPath
echo "ARCHIVING BEGINS: "`date` >> $logPath
echo "########################################" >> $logPath
echo "Beginning Volume Sizes" >> $logPath
echo >> $logPath
echo "`df -h | grep "%" | grep -v "shm"`" >> $logPath
echo >> $logPath;echo >> $logPath;echo "Cleanup Run Begins "$( date +%m%d%y.%H%M%S ) >> $logPath;echo >> $logPath
echo "*** Size of Archive Staging Folders Before Cleanup ***" >> $logPath;echo >> $logPath;du -scm /r*/*jobs/*WIP/Archive\ Staging/ >> $logPath;echo >> $logPath

echo  "  Deleting 'Z_Delete at Archive' folders:  " >> $logPath
echo "     Start:  " `date` >> $logPath
find /mn_raid*/*/*/Archive\ Staging/*/*/Z_Delete\ At\ Archive -depth -exec rm -Rfv {} \; >> /usr/schawk/logs/archiving/cleanup/Z_Delete_$( date +%m%d%y.%H%M%S ).log
echo "     End:  " `date` >> $logPath;echo >> $logPath

echo  "  Deleting 'Config' folders:  " >> $logPath
echo "     Start:  " `date` >> $logPath
find /mn_raid*/*/*/Archive\ Staging/*/*/config -depth -exec rm -Rfv {} \; >> /usr/schawk/logs/archiving/cleanup/config_$( date +%m%d%y.%H%M%S ).log
echo "     End:  " `date` >> $logPath;echo >> $logPath

echo  "  Deleting 'Temp' folders:  " >> $logPath
echo "     Start:  " `date` >> $logPath
find /mn_raid*/*/*/Archive\ Staging/*/*/temp -depth -exec rm -Rfv {} \; >> /usr/schawk/logs/archiving/cleanup/temp_$( date +%m%d%y.%H%M%S ).log
echo "     End:  " `date` >> $logPath;echo >> $logPath

echo  "  Deleting 'incoming_data' folders:  " >> $logPath
echo "     Start:  " `date` >> $logPath
find /mn_raid*/*/*/Archive\ Staging/*/*/incoming_data -depth -exec rm -Rfv {} \; >> /usr/schawk/logs/archiving/cleanup/incoming_data_$( date +%m%d%y.%H%M%S ).log
echo "     End:  " `date` >> $logPath;echo >> $logPath

echo  "  Deleting '080_QC' folders (except '3D Render', 'Code Ver', 'Compare', 'PDF for Blue'):  " >> $logPath
echo "     Start:  " `date` >> $logPath

find /mn_raid*/*/*/Archive\ Staging/*/*/080_QC/* -depth ! -path '*/080_QC/3D Renderings*' ! -path '*/080_QC/Code Verification*' ! -path '*/080_QC/Compare*' ! -path '*/080_QC/PDF for Blue*' | while read foundItem
do
	echo "$foundItem" >> /usr/schawk/logs/archiving/cleanup/080_QC_$( date +%m%d%y.%H%M%S ).log
	rm -rf "$foundItem"
done

echo "     End:  " `date` >> $logPath;echo >> $logPath
#
echo "Cleanup Ends: " `date` >> $logPath;echo >> $logPath
echo "*** Size of Archive Staging Folders After Cleanup ***" >> $logPath;echo >> $logPath;du -scm /r*/*jobs/*WIP/Archive\ Staging/ >> $logPath;echo >> $logPath;echo >> $logPath
