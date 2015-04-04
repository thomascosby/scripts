#!/bin/bash
#
# deletes all items from client Archive Staging folders
#
# Dan B - v1.1 - 08.29.13
#
MAINLOGPATH="/usr/schawk/logs/archiving/archive.log"
PURGELOGPATH="/usr/schawk/logs/archiving/purge_staging.log"
echo
echo "You are about to DELETE the contents of all client job Archive Staging folders."
read -p "This action cannot be undone. Are you sure you want to proceed? (y/n) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]
then
	echo '### ' `date` ' ###' >> $MAINLOGPATH
	echo '###  DELETING CONTENTS OF ARCHIVE STAGING FOLDERS  ###' >> $MAINLOGPATH
	echo >> $MAINLOGPATH
	echo
	echo "Press 't' for 'test' mode (confirm every deletion) or any other"
	read -p "key to proceed with deletion of ALL Archive Staging files." -n 1 -r
	echo
	
	if [[ $REPLY =~ ^[Tt]$ ]]
	then
		echo "TESTING: INTERACTIVE MODE"
		rm -ri /mn_raid*/*jobs/*WIP/Archive\ Staging/* > $PURGELOGPATH
	else
		echo "PURGING MAIN ARCHIVE STAGING FOLDERS"
		rm -rfv /mn_raid*/*jobs/*WIP/Archive\ Staging/* > $PURGELOGPATH
		echo "PURGING MIRROR ARCHIVE STAGING FOLDERS"
		rm -rfv /mirror_raid*/*jobs/*WIP/Archive\ Staging/* > $PURGELOGPATH
	fi
	
else
		echo "###  User Cancelled  ###"
		exit
fi

echo "DELETION COMPLETE: `date` >> $MAINLOGPATH";echo >> $MAINLOGPATH
echo "Final Volume Sizes" >> $MAINLOGPATH;echo >> $MAINLOGPATH
echo "`df -h | grep "%" | grep -v "shm"`" >> $MAINLOGPATH;echo >> $MAINLOGPATH
echo "########################################" >> $MAINLOGPATH
echo "ARCHIVING COMPLETE: "`date` >> $MAINLOGPATH
echo "########################################" >> $MAINLOGPATH;echo >> $MAINLOGPATH

