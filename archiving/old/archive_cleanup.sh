#!
# v 1.0  -  01.31.13  -  Dan B / Jim S
# 
# deletes unwanted folders from jobs in Archive Staging folders for all clients on MN_RAID1 and MN_RAID2
#
echo "Script Begins: " `date`;echo
#
echo  "  Deleting 'Z_Delete at Archive' folders:  "
echo "     Start:  " `date`
find /mn_raid*/*/*/Archive\ Staging/*/*/Z_Delete\ At\ Archive -depth -exec rm -Rfv {} \; >> /mn_raid2/productionfiles/Archive_Logs/Z_Delete\ At\ Archive/Z_Delete_$( date +%m%d%y.%H%M%S ).txt
echo "     End:  " `date`;echo
#
echo  "  Deleting 'Config' folders:  "
echo "     Start:  " `date`
find /mn_raid*/*/*/Archive\ Staging/*/*/config -depth -exec rm -Rfv {} \; >> /mn_raid2/productionfiles/Archive_Logs/config/config_$( date +%m%d%y.%H%M%S ).txt
echo "     End:  " `date`;echo
#
echo  "  Deleting 'Temp' folders:  "
echo "     Start:  " `date`
find /mn_raid*/*/*/Archive\ Staging/*/*/temp -depth -exec rm -Rfv {} \; >> /mn_raid2/productionfiles/Archive_Logs/temp/temp_$( date +%m%d%y.%H%M%S ).txt
echo "     End:  " `date`;echo
#
echo  "  Deleting '080_QC' folders (except '3D Render', 'Code Ver', 'Compare', 'PDF for Blue'):  "
echo "     Start:  " `date`
find /mn_raid*/*/*/Archive\ Staging/*/*/080_QC -depth ! -path '*/080_QC/3D Renderings*' ! -path '*/080_QC/Code Verification*' ! -path '*/080_QC/Compare*' ! -path '*/080_QC/PDF for Blue*' ! -path '*/080_QC' -exec rm -Rfv {} \; >> /mn_raid2/productionfiles/Archive_Logs/080_QC/080_QC_$( date +%m%d%y.%H%M%S ).txt
echo "     End:  " `date`;echo
echo "Script Ends: " `date`;echo
