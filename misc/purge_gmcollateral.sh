# Jim S - 06.27.2014 changed to use ksrm
#
#find /mn_raid1/gmcollateral/*/* -type d -mtime +90 -exec rm -rf {} \;
find /mn_raid1/gmcollateral/*/* -depth -type d -mtime +90 -exec /usr/etc/appletalk/ksrm -r {} \;
