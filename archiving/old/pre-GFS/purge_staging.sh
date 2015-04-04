#!/bin/bash
#
# deletes all items from client Archive Staging folders
#
# Dan B - v1.1 - 08.29.13
#
LOGPATH="/usr/schawk/logs/archiving/archive.log"
PURGELOGPATH="/usr/schawk/logs/archiving/purge_staging.log"
echo
echo "You are about to DELETE the contents of all client job Archive Staging folders."
read -p "This action cannot be undone. Are you sure you want to proceed? (y/n) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]
then
	echo '### ' `date` ' ###' >> $LOGPATH
	echo '###  DELETING CONTENTS OF ARCHIVE STAGING FOLDERS  ###' >> $LOGPATH
	echo >> $LOGPATH
	echo
	echo "PURGING ARCHIVE STAGING FOLDERS (PRIMARY STORAGE)"
	# clear current contents of purge log
	echo "" > $PURGELOGPATH
	# delete Archive Staging folder contents, logging deleted paths
	rm -rfv /mn_raid*/*jobs/*WIP/Archive\ Staging/* >> $PURGELOGPATH
	# repeat the process, this time on the Mirror storage
	echo "PURGING ARCHIVE STAGING FOLDERS (MIRROR STORAGE)"
	rm -rfv /mirror_raid*/*jobs/*WIP/Archive\ Staging/* >> $PURGELOGPATH
else
		echo "###  User Cancelled  ###"
		exit
fi
echo "DELETION COMPLETE: `date` >> $LOGPATH";echo >> $LOGPATH
echo "Final Volume Sizes" >> $LOGPATH;echo >> $LOGPATH
echo "`df -h | grep "%" | grep -v "shm"`" >> $LOGPATH;echo >> $LOGPATH
echo "########################################" >> $LOGPATH
echo "ARCHIVING COMPLETE: "`date` >> $LOGPATH
echo "########################################" >> $LOGPATH;echo >> $LOGPATH

