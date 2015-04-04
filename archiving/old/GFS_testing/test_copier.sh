#!/bin/bash
#
# copies jobs in each client Archive Staging folder to the appropriate client Job Archive
# then sets restricted perms on the Archive folders
#
# Dan B - v1.00 - 02.05.12
# Dan B - v1.01 - 03.26.13 - bug fixes and new Archive locations
# Dan B - v1.02 - 06.06.13 - improved logging
# Dan B - v1.03 - 08.29.13 - logging changes, fixed "PetSmart"
# Dan B - v1.04 - 09.13.13 - added cmds to reset ownership & perms on the archives after the copy
# Dan B - v1.05 - 03.07.14 - added archive year input and validation
# Dan B - v1.06	- 05.05.14 - deleted ex-clients
# Dan B - v1.07	- 06.24.14 - modified for GFS

echo
echo "This script copies the contents of the client Archive Staging"
echo "folders to the appropriate Jobs Archive/Year folders."
echo
read -p "Are you sure you want to proceed? (y/n) " -n 1
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    exit 1
fi

LOGPATH="/usr/schawk/logs/archiving/TESTarchive.log"
touch $LOGPATH

# fetch and validate archive Year
echo -n "Enter the year to which we're archiving (2012-2049): "; read theYear
# check input is 4 digit number in the range 2012-2049
#
# is the year entered composed entirely of digits?
DIGITS='^[0-9]+$'
if ! [[ $theYear =~ $DIGITS ]] ; then
	echo "ERROR: INVALID YEAR ENTERED (non-digit chars detected). EXITING." >&2; exit 1
fi
# is the year entered between 2012 & 2049 inclusive?
if [ $theYear -lt 2012 -o $theYear -gt 2049 ] ; then
	echo "ERROR: INVALID YEAR ENTERED (out of range). EXITING." >&2; exit 1
fi
# is there a folder for that year in the Gen Mills archive on mn_san_arch1?
if [ ! -d /mn_san_arch1/jobsarchive/genmillsarchive/Jobs\ Archive/$theYear  ] ; then
	echo "ERROR: INVALID YEAR ENTERED (folder doesn't exist in GM Archive on mn_san_arch1). EXITING." >&2; exit 1
fi

TEST_YEAR="2099"

echo "";echo "Valid Year Selected: "$TEST_YEAR

echo "### ARCHIVE COPYING BEGINS: "`date`" ###" >> $LOGPATH;echo "" >> $LOGPATH

##################################
#  GENERAL MILLS                 #
##################################         
echo "*** Copying General Mills Archive Staging to Archive ***" >> $LOGPATH
DIRS_ARC_STG=`ls -1 /r1/genmillsjobs/Archive\ Staging/ | wc -l`
DIRS_ARC_YR_BEF=`ls -1 /s1/jobsarchive/genmillsarchive/Jobs\ Archive/$TEST_YEAR | wc -l`
THISTIME=`(time /bin/cp -rfp /r1/genmillsjobs/Archive\ Staging/* /s1/jobsarchive/genmillsarchive/Jobs\ Archive/$TEST_YEAR/) 2>&1 | grep real`
REALTIME=`(echo $THISTIME | cut -f 2 -d ' ')`
echo "    Copy Completed in "$REALTIME" ***" >> $LOGPATH
DIRS_ARC_YR_AFT=`ls -1 /s1/jobsarchive/genmillsarchive/Jobs\ Archive/$TEST_YEAR | wc -l`
DIRS_COPIED=$((DIRS_ARC_YR_AFT-DIRS_ARC_YR_BEF))
echo "    ITEMS IN ARCHIVE STAGING: "$DIRS_ARC_STG >> $LOGPATH
echo "    ITEMS ADDED TO ARCHIVE: "$DIRS_COPIED >> $LOGPATH
echo >> $LOGPATH
#
################################## 

##################################
#  OTHER CLIENTS                 #
################################## 
echo "*** Copying Other Clients Archive Staging to Archive ***" >> $LOGPATH

# copy job folders NOT contained in a client-name folder
find /mn_raid2/otherclientsjobs/Archive\ Staging/* -maxdepth 0 -regextype posix-extended -regex '.*/[0-9]{6,7}$' -type d | while read foundItem
do
	/bin/cp -rfp "$foundItem" /s2/jobsarchive/otherclientsarchive/Jobs\ Archive/$TEST_YEAR/
done

# copy jobs folders that ARE contained in client-name folders
find /mn_raid2/otherclientsjobs/Archive\ Staging/* -maxdepth 0 -type d | grep -Ev '.*/[0-9]{6,7}$' | cut -d/ -f 5 | while read foundItem
do
	mkdir -p /s2/jobsarchive/otherclientsarchive/Jobs\ Archive/$TEST_YEAR/"$foundItem"
	/bin/cp -rfp /mn_raid2/otherclientsjobs/Archive\ Staging/"$foundItem" /s2/jobsarchive/otherclientsarchive/Jobs\ Archive/$TEST_YEAR/"$foundItem"
done

#THISTIME=`(time /bin/cp -rfp /r2/otherclientsjobs/Archive\ Staging/* /s2/jobsarchive/otherclientsarchive/Jobs\ Archive/$TEST_YEAR/) 2>&1 | grep real`
#REALTIME=`(echo $THISTIME | cut -f 2 -d ' ')`
echo "    Copy Completed in "$REALTIME" ***" >> $LOGPATH
#DIRS_ARC_YR_AFT=`ls -1 /s2/jobsarchive/otherclientsarchive/Jobs\ Archive/$TEST_YEAR | wc -l`
#DIRS_COPIED=$((DIRS_ARC_YR_AFT-DIRS_ARC_YR_BEF))
echo "    ITEMS IN ARCHIVE STAGING: "$DIRS_ARC_STG >> $LOGPATH
echo "    ITEMS ADDED TO ARCHIVE: "$DIRS_COPIED >> $LOGPATH
echo >> $LOGPATH

### Set ownership and perms on the Archives
echo "" >> $LOGPATH
echo "*** Resetting Ownership and Permissions on $TEST_YEAR Job Archives ***" >> $LOGPATH
echo "" >> $LOGPATH
#chown -R root:archivers /mn_san_arch*/jobsarchive/*archive/*Archive/$TEST_YEAR
#chmod -R 755 /mn_san_arch*/jobsarchive/*archive/*Archive/$TEST_YEAR

echo "### ARCHIVE COPYING COMPLETE: "`date`" ###" >> $LOGPATH;echo "" >> $LOGPATH



