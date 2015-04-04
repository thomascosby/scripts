#!/bin/bash
#######################
# make sure source & destination file systems exist
FAILFLAG=0
# check size of each vol to see if it contains a "T"
#RAID1_SIZE=`df -h | grep //mn_raid1 | sed -n 1p | awk '{print $1}'`
#RAID2_SIZE=`df -h | grep mn_raid2 | sed -n 1p | awk '{print $1}'`
#MIRROR1_SIZE=`df -h | grep mirror_raid1 | sed -n 2p | awk '{print $1}'`
#MIRROR2_SIZE=`df -h | grep mirror_raid2 | sed -n 1p | awk '{print $1}'`
#echo $RAID1_SIZE "  " $RAID2_SIZE "  " $MIRROR1_SIZE "  " $MIRROR2_SIZE

DF_TEXT=`df -h`

if ! [[ $DF_TEXT =~ .*mn_raid1.* ]]
then
   FAILFLAG=1
fi

if ! [[ $DF_TEXT =~ .*mn_raid2.* ]]
then
   FAILFLAG=1
fi

if ! [[ $DF_TEXT =~ .*mirror_raid1.* ]]
then
   FAILFLAG=1
fi

if ! [[ $DF_TEXT =~ .*mirror_raid2.* ]]
then
   $FAILFLAG=1
fi

if [ $FAILFLAG -eq 1 ]
then
  echo "FAILED!"
fi