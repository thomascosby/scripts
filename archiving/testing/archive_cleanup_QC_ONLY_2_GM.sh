#!
# v 1.0  -  01.31.13  -  Dan B / Jim S
# v 1.01 - 03.26.13  - Dan B  - redirect output to /usr/schawk/logs
# v 1.02 - 08.29.13  - Dan B - logging changes
# 
# deletes unwanted folders from jobs in Archive Staging folders for all clients on MN_RAID1 and MN_RAID2
#
logPath="/usr/schawk/logs/archiving/archive.log"
touch $logPath
QCLogPath="TEST_GM"
echo "" > /usr/schawk/logs/archiving/cleanup/080_QC_$QCLogPath.txt

echo  "  Deleting '080_QC' folders (except '3D Render', 'Code Ver', 'Compare', 'PDF for Blue'):  " >> $logPath
echo "     Start 084xxx:  " `date` >> $logPath

find /mn_raid1/genmillsjobs/General\ Mills\ Jobs\ WIP/Archive\ Staging/084*/*/080_QC/* -depth ! -path '*/080_QC/3D Renderings*' ! -path '*/080_QC/Code Verification*' ! -path '*/080_QC/Compare*' ! -path '*/080_QC/PDF for Blue*' -exec rm -Rfv {} \; >> /usr/schawk/logs/archiving/cleanup/080_QC_$QCLogPath.txt

echo "     Start 085xxx:  " `date` >> $logPath
find /mn_raid1/genmillsjobs/General\ Mills\ Jobs\ WIP/Archive\ Staging/085*/*/080_QC/* -depth ! -path '*/080_QC/3D Renderings*' ! -path '*/080_QC/Code Verification*' ! -path '*/080_QC/Compare*' ! -path '*/080_QC/PDF for Blue*' -exec rm -Rfv {} \; >> /usr/schawk/logs/archiving/cleanup/080_QC_$QCLogPath.txt

echo "     Start 086xxx:  " `date` >> $logPath
find /mn_raid1/genmillsjobs/General\ Mills\ Jobs\ WIP/Archive\ Staging/086*/*/080_QC/* -depth ! -path '*/080_QC/3D Renderings*' ! -path '*/080_QC/Code Verification*' ! -path '*/080_QC/Compare*' ! -path '*/080_QC/PDF for Blue*' -exec rm -Rfv {} \; >> /usr/schawk/logs/archiving/cleanup/080_QC_$QCLogPath.txt

echo "     Start 087xxx:  " `date` >> $logPath
find /mn_raid1/genmillsjobs/General\ Mills\ Jobs\ WIP/Archive\ Staging/087*/*/080_QC/* -depth ! -path '*/080_QC/3D Renderings*' ! -path '*/080_QC/Code Verification*' ! -path '*/080_QC/Compare*' ! -path '*/080_QC/PDF for Blue*' -exec rm -Rfv {} \; >> /usr/schawk/logs/archiving/cleanup/080_QC_$QCLogPath.txt

echo "     Start 088xxx:  " `date` >> $logPath
find /mn_raid1/genmillsjobs/General\ Mills\ Jobs\ WIP/Archive\ Staging/088*/*/080_QC/* -depth ! -path '*/080_QC/3D Renderings*' ! -path '*/080_QC/Code Verification*' ! -path '*/080_QC/Compare*' ! -path '*/080_QC/PDF for Blue*' -exec rm -Rfv {} \; >> /usr/schawk/logs/archiving/cleanup/080_QC_$QCLogPath.txt

echo "     Start 089xxx:  " `date` >> $logPath
find /mn_raid1/genmillsjobs/General\ Mills\ Jobs\ WIP/Archive\ Staging/089*/*/080_QC/* -depth ! -path '*/080_QC/3D Renderings*' ! -path '*/080_QC/Code Verification*' ! -path '*/080_QC/Compare*' ! -path '*/080_QC/PDF for Blue*' -exec rm -Rfv {} \; >> /usr/schawk/logs/archiving/cleanup/080_QC_$QCLogPath.txt

echo "     Start 090xxx:  " `date` >> $logPath
find /mn_raid1/genmillsjobs/General\ Mills\ Jobs\ WIP/Archive\ Staging/090*/*/080_QC/* -depth ! -path '*/080_QC/3D Renderings*' ! -path '*/080_QC/Code Verification*' ! -path '*/080_QC/Compare*' ! -path '*/080_QC/PDF for Blue*' -exec rm -Rfv {} \; >> /usr/schawk/logs/archiving/cleanup/080_QC_$QCLogPath.txt

echo "     Start 091xxx:  " `date` >> $logPath
find /mn_raid1/genmillsjobs/General\ Mills\ Jobs\ WIP/Archive\ Staging/091*/*/080_QC/* -depth ! -path '*/080_QC/3D Renderings*' ! -path '*/080_QC/Code Verification*' ! -path '*/080_QC/Compare*' ! -path '*/080_QC/PDF for Blue*' -exec rm -Rfv {} \; >> /usr/schawk/logs/archiving/cleanup/080_QC_$QCLogPath.txt

echo "     End:  " `date` >> $logPath;echo >> $logPath
#
echo "Cleanup Ends: " `date` >> $logPath;echo >> $logPath

