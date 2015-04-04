#!
# v 1.0  -  01.31.13  -  Dan B / Jim S
# v 1.01 - 03.26.13  - Dan B  - redirect output to /usr/schawk/logs
# 
# deletes unwanted folders from jobs in Archive Staging folders for all clients on MN_RAID1 and MN_RAID2
#
logPath="/usr/schawk/logs/archiving/archive.log"
touch $logPath

echo  "  Deleting '080_QC' folders (except '3D Render', 'Code Ver', 'Compare', 'PDF for Blue'):  " >> $logPath
echo "     Start MN_RAID1:  " `date` >> $logPath

#QCLogpath=`date +%m%d%y.%H%M%S`
QCLogpath="TEST_1"
echo "" > /usr/schawk/logs/archiving/cleanup/080_QC_R1_$QCLogPAth.log

find /mn_raid1/genmillsjobs/General\ Mills\ Jobs\ WIP/Archive\ Staging/* -maxdepth 1 -type d | while read foundStaging
do
   find "$foundStaging"/080_QC/* -depth ! -path '*/080_QC/3D Renderings*' ! -path '*/080_QC/Code Verification*' ! -path '*/080_QC/Compare*' ! -path '*/080_QC/PDF for Blue*' | while read foundItem
   do
	echo "$foundItem" >> /usr/schawk/logs/archiving/cleanup/080_QC_R1_$QCLogPAth.log
	#rm -rf "$foundItem"
   done
done

#find /mn_raid1/genmillsjobs/General\ Mills\ Jobs\ WIP/Archive\ Staging/*/*/080_QC/* -depth ! -path '*/080_QC/3D Renderings*' ! -path '*/080_QC/Code Verification*' ! -path '*/080_QC/Compare*' ! -path '*/080_QC/PDF for Blue*' | while read foundItem
#do
#	echo "$foundItem" >> /usr/schawk/logs/archiving/cleanup/080_QC_R1_$QCLogPAth.log
#	rm -rf "$foundItem"
#done
#echo "     End MN_RAID1:  " `date` >> $logPath;echo >> $logPath

#echo "     Start MN_RAID2:  " `date` >> $logPath

#find /mn_raid2/*/*/Archive\ Staging/*/*/080_QC/* -depth ! -path '*/080_QC/3D Renderings*' ! -path '*/080_QC/Code Verification*' ! -path '*/080_QC/Compare*' ! -path '*/080_QC/PDF for Blue*' | while read foundItem
#do
#	echo "$foundItem" >> /usr/schawk/logs/archiving/cleanup/080_QC_R2$( date +%m%d%y.%H%M%S ).log
#	rm -rf "$foundItem"
#done

#echo "     End MN_RAID2:  " `date` >> $logPath;echo >> $logPath
#
#echo "Cleanup Ends: " `date` >> $logPath;echo >> $logPath
#echo "*** Size of Archive Staging Folders After Cleanup ***" >> $logPath;echo >> $logPath;du -scm /r*/*jobs/*WIP/Archive\ Staging/ >> $logPath;echo >> $logPath;echo >> $logPath
