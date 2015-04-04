# Dan B - 12.05.11
# 
# revised to work with GFS 1.0 - Dan B - 06.06.14
#
# find and delete directories in Staging older than 90 months
find /mn_raid1/generalmills/PCBU93007/Images/Staging/* -type d -mtime +270 -exec rm -rf {} \;
# perform a syncvoltodb on Staging to update the WebNative database
/usr/etc/venture/bin/syncvoltodb -delnorm /mn_raid1/generalmills/Assets/Staging/

