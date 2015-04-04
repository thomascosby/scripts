#!
# v 1.0  -  01.31.13  -  Dan B / Jim S
# v 1.01 - 03.26.13  - Dan B  - redirect output to /usr/schawk/logs
# 
# deletes unwanted folders from jobs in Archive Staging folders for all clients on MN_RAID1 and MN_RAID2
#
logPath="/usr/schawk/logs/archiving/archive_TEST_Dec_12.log"
touch $logPath
echo "" > $logPath

echo  "  Deleting '080_QC' folders (except '3D Render', 'Code Ver', 'Compare', 'PDF for Blue'):  " >> $logPath
echo "     Start:  " `date` >> $logPath

# find /mn_raid*/*/*/Archive\ Staging/*/*/080_QC/* -depth ! -path '*/080_QC/3D Renderings*' ! -path '*/080_QC/Code Verification*' ! -path '*/080_QC/Compare*' ! -path '*/080_QC/PDF for Blue*' | while read foundItem

find /mn_raid*/*/*/Archive\ Staging/*/*/080_QC/ -depth | grep -vE '/080_QC/3D Renderings|/080_QC/Code Verification|/080_QC/Compare|/080_QC/PDF for Blue|080_QC/$' | while read foundItem
do
	echo "$foundItem" >> $logPath
#	rm -rf "$foundItem"
done

echo "     End:  " `date` >> $logPath;echo >> $logPath

