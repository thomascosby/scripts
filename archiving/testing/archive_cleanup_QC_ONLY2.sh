#!
# v 1.0  -  01.31.13  -  Dan B / Jim S
# v 1.01 - 03.26.13  - Dan B  - redirect output to /usr/schawk/logs
# v 1.02 - 08.29.13  - Dan B - logging changes
# 
# deletes unwanted folders from jobs in Archive Staging folders for all clients on MN_RAID1 and MN_RAID2
#
logPath="/usr/schawk/logs/archiving/archive.log"
touch $logPath
QCLogPath="TEST"
echo "" > /usr/schawk/logs/archiving/cleanup/080_QC_$QCLogPath.txt

echo  "  Deleting '080_QC' folders (except '3D Render', 'Code Ver', 'Compare', 'PDF for Blue'):  " >> $logPath
echo "     Start:  " `date` >> $logPath

#find /mn_raid1/*/*/Archive\ Staging/*/*/080_QC/* -depth ! -path '*/080_QC/3D Renderings*' ! -path '*/080_QC/Code Verification*' ! -path '*/080_QC/Compare*' ! -path '*/080_QC/PDF for Blue*' -exec rm -Rfv {} \; >> /usr/schawk/logs/archiving/080_QC/080_QC_$QCLogPath.txt
find /mn_raid2/3mjobs/*/Archive\ Staging/*/*/080_QC/* -depth ! -path '*/080_QC/3D Renderings*' ! -path '*/080_QC/Code Verification*' ! -path '*/080_QC/Compare*' ! -path '*/080_QC/PDF for Blue*' -exec rm -Rfv {} \; >> /usr/schawk/logs/archiving/cleanup/080_QC_$QCLogPath.txt
find /mn_raid2/a*jobs/*/Archive\ Staging/*/*/080_QC/* -depth ! -path '*/080_QC/3D Renderings*' ! -path '*/080_QC/Code Verification*' ! -path '*/080_QC/Compare*' ! -path '*/080_QC/PDF for Blue*' -exec rm -Rfv {} \; >> /usr/schawk/logs/archiving/cleanup/080_QC_$QCLogPath.txt
find /mn_raid2/c*jobs/*/Archive\ Staging/*/*/080_QC/* -depth ! -path '*/080_QC/3D Renderings*' ! -path '*/080_QC/Code Verification*' ! -path '*/080_QC/Compare*' ! -path '*/080_QC/PDF for Blue*' -exec rm -Rfv {} \; >> /usr/schawk/logs/archiving/cleanup/080_QC_$QCLogPath.txt
find /mn_raid2/d*jobs/*/Archive\ Staging/*/*/080_QC/* -depth ! -path '*/080_QC/3D Renderings*' ! -path '*/080_QC/Code Verification*' ! -path '*/080_QC/Compare*' ! -path '*/080_QC/PDF for Blue*' -exec rm -Rfv {} \; >> /usr/schawk/logs/archiving/cleanup/080_QC_$QCLogPath.txt
find /mn_raid2/f*jobs/*/Archive\ Staging/*/*/080_QC/* -depth ! -path '*/080_QC/3D Renderings*' ! -path '*/080_QC/Code Verification*' ! -path '*/080_QC/Compare*' ! -path '*/080_QC/PDF for Blue*' -exec rm -Rfv {} \; >> /usr/schawk/logs/archiving/cleanup/080_QC_$QCLogPath.txt
find /mn_raid2/g*jobs/*/Archive\ Staging/*/*/080_QC/* -depth ! -path '*/080_QC/3D Renderings*' ! -path '*/080_QC/Code Verification*' ! -path '*/080_QC/Compare*' ! -path '*/080_QC/PDF for Blue*' -exec rm -Rfv {} \; >> /usr/schawk/logs/archiving/cleanup/080_QC_$QCLogPath.txt
find /mn_raid2/h*jobs/*/Archive\ Staging/*/*/080_QC/* -depth ! -path '*/080_QC/3D Renderings*' ! -path '*/080_QC/Code Verification*' ! -path '*/080_QC/Compare*' ! -path '*/080_QC/PDF for Blue*' -exec rm -Rfv {} \; >> /usr/schawk/logs/archiving/cleanup/080_QC_$QCLogPath.txt
find /mn_raid2/m*jobs/*/Archive\ Staging/*/*/080_QC/* -depth ! -path '*/080_QC/3D Renderings*' ! -path '*/080_QC/Code Verification*' ! -path '*/080_QC/Compare*' ! -path '*/080_QC/PDF for Blue*' -exec rm -Rfv {} \; >> /usr/schawk/logs/archiving/cleanup/080_QC_$QCLogPath.txt
find /mn_raid2/n*jobs/*/Archive\ Staging/*/*/080_QC/* -depth ! -path '*/080_QC/3D Renderings*' ! -path '*/080_QC/Code Verification*' ! -path '*/080_QC/Compare*' ! -path '*/080_QC/PDF for Blue*' -exec rm -Rfv {} \; >> /usr/schawk/logs/archiving/cleanup/080_QC_$QCLogPath.txt
find /mn_raid2/o*jobs/*/Archive\ Staging/*/*/080_QC/* -depth ! -path '*/080_QC/3D Renderings*' ! -path '*/080_QC/Code Verification*' ! -path '*/080_QC/Compare*' ! -path '*/080_QC/PDF for Blue*' -exec rm -Rfv {} \; >> /usr/schawk/logs/archiving/cleanup/080_QC_$QCLogPath.txt
find /mn_raid2/p*jobs/*/Archive\ Staging/*/*/080_QC/* -depth ! -path '*/080_QC/3D Renderings*' ! -path '*/080_QC/Code Verification*' ! -path '*/080_QC/Compare*' ! -path '*/080_QC/PDF for Blue*' -exec rm -Rfv {} \; >> /usr/schawk/logs/archiving/cleanup/080_QC_$QCLogPath.txt
find /mn_raid2/s*jobs/*/Archive\ Staging/*/*/080_QC/* -depth ! -path '*/080_QC/3D Renderings*' ! -path '*/080_QC/Code Verification*' ! -path '*/080_QC/Compare*' ! -path '*/080_QC/PDF for Blue*' -exec rm -Rfv {} \; >> /usr/schawk/logs/archiving/cleanup/080_QC_$QCLogPath.txt
echo "     End:  " `date` >> $logPath;echo >> $logPath
#
echo "Cleanup Ends: " `date` >> $logPath;echo >> $logPath
echo "*** Size of Archive Staging Folders After Cleanup ***" >> $logPath;echo >> $logPath;du -scm /r*/*jobs/*WIP/Archive\ Staging/ >> $logPath;echo >> $logPath;echo >> $logPath
