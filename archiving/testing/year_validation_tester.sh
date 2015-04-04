echo -n "Enter the year for which we're archiving (2000-2099): "; read theYear
# check input is 4 digit number in the range 2001-2099 - NOTE: this script will break as of 2100 AD!
#
# is the year entered composed only of digits?
DIGITS='^[0-9]+$'
if ! [[ $theYear =~ $DIGITS ]] ; then
	echo "ERROR: INVALID YEAR ENTERED (non-digit chars detected). EXITING." >&2; exit 1
fi
# is the year entered between 2010 & 2100 inclusive?
if [ $theYear -lt 2010 -o $theYear -gt 2100 ] ; then
	echo "ERROR: INVALID YEAR ENTERED (out of range). EXITING." >&2; exit 1
fi

# is there a folder for that year in the Gen Mills archive on mn_san_arch1?
if [ ! -d /mn_san_arch1/jobsarchive/genmillsarchive/Jobs\ Archive/$theYear  ] ; then
	echo "ERROR: INVALID YEAR ENTERED (folder doesn't exist). EXITING." >&2; exit 1
fi

echo "";echo "Valid Year Entered: "$theYear
exit 0