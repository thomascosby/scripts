#!/bin/bash
LOCK_FILE="/usr/schawk/scripts/misc/disktest/disktest.lock"
LOG_FILE="/usr/schawk/scripts/misc/disktest/disktest.log"
TEST_FILE="/usr/schawk/scripts/misc/disktest/testfiles"
COPY_FILE="/usr/schawk/scripts/misc/disktest/testfilescopy"

if [ -e $LOCK_FILE ]; then
	TIMESTAMP=$(date)
	echo "$TIMESTAMP: lock file alredy exists, exiting now" >> $LOG_FILE
	exit
fi

touch $LOCK_FILE
touch $LOG_FILE

if [ -d $COPY_FILE ]; then
	rm -rf $COPY_FILE
echo "removed existing copy"
fi

START=$(date +%s)
#echo "start= " $START
cp -rp $TEST_FILE $COPY_FILE
END=$(date +%s)
#echo "end= " $END
DIFF=`echo $(( $END - $START ))`
#echo "diff= " $DIFF
echo `date` "  :  $DIFF" >> $LOG_FILE
rm -rf $COPY_FILE
rm -f $LOCK_FILE
exit
