#!
# v 1.0  -  01.31.13  -  Dan B / Jim S
# v 1.01 - 03.26.13  - Dan B  - redirect output to /usr/schawk/logs
# v 1.02 - 08.29.13  - Dan B - logging changes
# 
# deletes unwanted folders from jobs in Archive Staging folders for all clients on MN_RAID1 and MN_RAID2
#
logPath="/usr/schawk/logs/archiving/archiveTEST.log"
touch $logPath
echo "" > $logPath

echo "########################################" >> $logPath
echo "ARCHIVING BEGINS: "`date` >> $logPath
echo "########################################" >> $logPath
echo "Beginning Volume Sizes" >> $logPath
echo >> $logPath
echo "`df -h | grep "%" | grep -v "shm"`" >> $logPath
echo >> $logPath;echo >> $logPath;echo "Cleanup Run Begins "$( date +%m%d%y.%H%M%S ) >> $logPath;echo >> $logPath


echo  "  Deleting '080_QC' folders (except '3D Render', 'Code Ver', 'Compare', 'PDF for Blue'):  " >> $logPath
echo "     Start:  " `date` >> $logPath

find /mn_raid*/*/*/Archive\ Staging/*/*/080_QC/* -depth ! -path '*/080_QC/3D Renderings*' ! -path '*/080_QC/Code Verification*' ! -path '*/080_QC/Compare*' ! -path '*/080_QC/PDF for Blue*' | while read foundItem
do
	echo "$foundItem" >> $logPath
	rm -rf "$foundItem"
done

echo "     End:  " `date` >> $logPath;echo >> $logPath
#
echo "Cleanup Ends: " `date` >> $logPath;echo >> $logPath
