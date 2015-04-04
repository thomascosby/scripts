#!/bin/bash
#
# copies jobs in each client Archive Staging folder to the appropriate client Job Archive
# then sets restricted perms on the Archive folders
#
# Dan B - v1.0 - 02.05.12
# Dan B - v1.01 - 03.26.13 - bug fixes and new Archive locations
# Dan B - v1.02 - 06.06.13 - improved logging
# Dan B - v1.03 - 08.29.13 - logging changes, fixed "PetSmart"
# Dan B - v1.04 - 09.13.13 - added cmds to reset ownership & perms on the archives after the copy
# Dan B - v1.05 - 03.07.14 - added archive year input and validation
echo
echo "This script copies the contents of the client Archive Staging"
echo "folders to the appropriate Jobs Archive/(year) folders."
echo
read -p "Are you sure you want to proceed? (y/n) " -n 1
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    exit 1
fi

LOGPATH="/usr/schawk/logs/archiving/archiveTESTER.log"
touch $LOGPATH

# fetch and validate archive Year
echo -n "Enter the year to which we're archiving (2012-2029): "; read theYear
# check input is 4 digit number in the range 2012-2029
#
# is the year entered composed entirely of digits?
DIGITS='^[0-9]+$'
if ! [[ $theYear =~ $DIGITS ]] ; then
	echo "ERROR: INVALID YEAR ENTERED (non-digit chars detected). EXITING." >&2; exit 1
fi
# is the year entered between 2012 & 2029 inclusive?
if [ $theYear -lt 2012 -o $theYear -gt 2029 ] ; then
	echo "ERROR: INVALID YEAR ENTERED (out of range). EXITING." >&2; exit 1
fi
# is there a folder for that year in the Gen Mills archive on mn_san_arch1?
if [ ! -d /mn_san_arch1/jobsarchive/genmillsarchive/Jobs\ Archive/$theYear  ] ; then
	echo "ERROR: INVALID YEAR ENTERED (folder doesn't exist in GM Archive on mn_san_arch1). EXITING." >&2; exit 1
fi

echo "";echo "Valid Year Selected: "$theYear

echo "### ARCHIVE COPYING BEGINS: "`date`" ###" >> $LOGPATH;echo "" >> $LOGPATH

##################################
#  3M                            #
################################## 
echo "*** Copying 3M Archive Staging to Archive ***" >> $LOGPATH
DIRS_ARC_STG=`ls -1 /r2/3mjobs/3M\ Jobs\ WIP/Archive\ Staging/ | wc -l`
DIRS_ARC_YR_BEF=`ls -1 /s2/jobsarchive/3marchive/Jobs\ Archive/$theYear | wc -l`
THISTIME=`(time /bin/cp -rfp /r2/3mjobs/3M\ Jobs\ WIP/Archive\ Staging/* /s2/jobsarchive/3marchive/Jobs\ Archive/$theYear/) 2>&1 | grep real`
REALTIME=`(echo $THISTIME | cut -f 2 -d ' ')`
echo "    Copy Completed in "$REALTIME" ***" >> $LOGPATH
DIRS_ARC_YR_AFT=`ls -1 /s2/jobsarchive/3marchive/Jobs\ Archive/$theYear | wc -l`
DIRS_COPIED=$((DIRS_ARC_YR_AFT-DIRS_ARC_YR_BEF))
echo "    ITEMS IN ARCHIVE STAGING: "$DIRS_ARC_STG >> $LOGPATH
echo "    ITEMS ADDED TO ARCHIVE: "$DIRS_COPIED >> $LOGPATH
echo >> $LOGPATH
##################################
#  CENTRAL GARDEN                #
################################## 
echo "*** Copying Central Garden Archive Staging to Archive ***" >> $LOGPATH
DIRS_ARC_STG=`ls -1 /r2/centralgardenjobs/Central\ Garden\ Jobs\ WIP/Archive\ Staging/ | wc -l`
DIRS_ARC_YR_BEF=`ls -1 /s2/jobsarchive/centralgardenarchive/Jobs\ Archive/$theYear | wc -l`
THISTIME=`(time /bin/cp -rfp /r2/centralgardenjobs/Central\ Garden\ Jobs\ WIP/Archive\ Staging/* /s2/jobsarchive/centralgardenarchive/Jobs\ Archive/$theYear/) 2>&1 | grep real`
REALTIME=`(echo $THISTIME | cut -f 2 -d ' ')`
echo "    Copy Completed in "$REALTIME" ***" >> $LOGPATH
DIRS_ARC_YR_AFT=`ls -1 /s2/jobsarchive/centralgardenarchive/Jobs\ Archive/$theYear | wc -l`
DIRS_COPIED=$((DIRS_ARC_YR_AFT-DIRS_ARC_YR_BEF))
echo "    ITEMS IN ARCHIVE STAGING: "$DIRS_ARC_STG >> $LOGPATH
echo "    ITEMS ADDED TO ARCHIVE: "$DIRS_COPIED >> $LOGPATH
echo >> $LOGPATH
##################################
#  CON AGRA                      #
################################## 
echo "*** Copying Con Agra Archive Staging to Archive ***" >> $LOGPATH
DIRS_ARC_STG=`ls -1 /r2/conagrajobs/Con\ Agra\ Jobs\ WIP/Archive\ Staging/ | wc -l`
DIRS_ARC_YR_BEF=`ls -1 /s2/jobsarchive/conagraarchive/Jobs\ Archive/$theYear | wc -l`
THISTIME=`(time /bin/cp -rfp /r2/conagrajobs/Con\ Agra\ Jobs\ WIP/Archive\ Staging/* /s2/jobsarchive/conagraarchive/Jobs\ Archive/$theYear/) 2>&1 | grep real`
REALTIME=`(echo $THISTIME | cut -f 2 -d ' ')`
echo "    Copy Completed in "$REALTIME" ***" >> $LOGPATH
DIRS_ARC_YR_AFT=`ls -1 /s2/jobsarchive/conagraarchive/Jobs\ Archive/$theYear | wc -l`
DIRS_COPIED=$((DIRS_ARC_YR_AFT-DIRS_ARC_YR_BEF))
echo "    ITEMS IN ARCHIVE STAGING: "$DIRS_ARC_STG >> $LOGPATH
echo "    ITEMS ADDED TO ARCHIVE: "$DIRS_COPIED >> $LOGPATH
echo >> $LOGPATH

#
### Set ownership and perms on the Archives
echo "" >> $LOGPATH
echo "*** Resetting Owner and Permissions on $theYear Job Archives ***" >> $LOGPATH
echo "" >> $LOGPATH
chown -R root:archivers /mn_san_arch*/jobsarchive/*archive/*Archive/$theYear
chmod -R 755 /mn_san_arch*/jobsarchive/*archive/*Archive/$theYear

echo "### ARCHIVE COPYING COMPLETE: "`date`" ###" >> $LOGPATH;echo "" >> $LOGPATH



