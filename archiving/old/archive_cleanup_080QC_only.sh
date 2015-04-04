#!
# v 1.0  -  01.31.13  -  Dan B / Jim S
# 
# deletes unwanted folders from jobs in Archive Staging folders for all clients on MN_RAID1 and MN_RAID2
#
echo  "  Deleting '080_QC' folders (except '3D Render', 'Code Ver', 'Compare', 'PDF for Blue'):  "
echo "     Start:  " `date`
find /mn_raid*/*/*/Archive\ Staging/*/*/080_QC -depth ! -path '*/080_QC/3D Renderings*' ! -path '*/080_QC/Code Verification*' ! -path '*/080_QC/Compare*' ! -path '*/080_QC/PDF for Blue*' ! -path '*/080_QC' -exec rm -Rfv {} \; >> /mn_raid2/productionfiles/Archive_Logs/080_QC/080_QC_$( date +%m%d%y.%H%M%S ).txt
echo "     End:  " `date`;echo
echo "Script Ends: " `date`;echo
