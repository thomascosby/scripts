# Dan B - 12.05.11
# Dan B - 06.11.14 - modified to reflect new paths due to GFS 
# Jim S - 06.27.14 - modified to use ksrm and not do a syncvol
#
# find and delete any directories in Staging older than 270 days
# find /mn_raid1/generalmills/PCBU93007/Images/Staging/* -type d -mtime +270 -exec rm -rf {} \;
find /mn_raid1/generalmills/PCBU93007/Images/Staging/* -depth -type d -mtime +270 -exec /usr/etc/appletalk/ksrm -r {} \;

# perform a syncvoltodb on Staging to update the WebNative database
# /usr/etc/venture/bin/syncvoltodb -delnorm /mn_raid1/generalmills/PCBU93007/Images/Staging/
