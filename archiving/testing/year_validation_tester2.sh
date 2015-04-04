#!/bin/bash
#

echo
echo "This script copies the contents of the client Archive Staging"
echo "folders to the appropriate Jobs Archive/year folders."
echo
read -p "Are you sure you want to proceed? (y/n) " -n 1
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    exit 1
fi

LOGPATH="/usr/schawk/logs/archiving/archive.log"

echo -n "Enter the year for which we're archiving (2012-2029): "; read theYear
# check input is 4 digit number in the range 2011-2029 - NOTE: this script will break as of 2030 AD.
#
# is the year entered composed only of digits?
DIGITS='^[0-9]+$'
if ! [[ $theYear =~ $DIGITS ]] ; then
	echo "ERROR: INVALID YEAR ENTERED (non-digit chars detected). EXITING." >&2; exit 1
fi
# is the year entered between 2011 & 2029 inclusive?
if [ $theYear -lt 2011 -o $theYear -gt 2029 ] ; then
	echo "ERROR: INVALID YEAR ENTERED (out of range). EXITING." >&2; exit 1
fi

# is there a folder for that year in the Gen Mills archive on mn_san_arch1?
if [ ! -d /mn_san_arch1/jobsarchive/genmillsarchive/Jobs\ Archive/$theYear  ] ; then
	echo "ERROR: INVALID YEAR ENTERED (folder doesn't exist in GM Archive on mn_san_arch1). EXITING." >&2; exit 1
fi

echo "";echo "Valid Year Entered: "$theYear