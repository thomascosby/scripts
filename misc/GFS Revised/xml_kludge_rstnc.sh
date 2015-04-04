#!/bin/bash
#  This script rsyns the nfs mount from vq2pa605.corio.com:/sgk_integ/Client_Integ/GM_Coupon/Final_Dest_Folder to 
#+ /r2/auto/mpx/General_Mills_Coupon_XM by way of /r2/xml_kludge.
#  After the rsync, this script adjusts permissions so 'Switch' can process.
#+ Then it deletes rsyncd files.

#  varibles
LOG_DIR=/var/log/xml_kludge_log.txt


exit 0
#  A zero return value from the script upon exit indicates success
#+ to the shell.