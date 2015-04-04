#!/bin/bash
#  This script will send an email to everyone detailing the deletion of +30 day old files
#  Email To @schawk.com only. @anthemww.com does not work
RECIPIENTS="thomas.cosby@schawk.com,becca.gorski@schawk.com"
#RECIPIENTS="alex.krzyzsoiak@schawk.com,amy.neiman@schawk.com,andy.flynn@schawk.com,anne.tsuei@schawk.com,becca.gorski@schawk.com,bill.larsen@schawk.com,carl.mazer@schawk.com,carol.best@schawk.com,chrystal.campbell@schawk.com,daryl.buhrman@schawk.com,heidi.grunenwald@schawk.com,irene.bassett@schawk.com,kim.bates@schawk.com,lisa.strick@schawk.com,liz.gallerani@schawk.com,mark.hamilton@schawk.com,mega.tjhin@schawk.com,miri.chan@schawk.com,nanda.sibol@schawk.com,neil.higgins@schawk.com,rob.eisenbach@schawk.com,sarah.medeiros@schawk.com,tammy.chung@schawk.com,teresa.diehl@schawk.com,tom.holownia@schawk.com,william.finn@schawk.com"
#  Email text/message
EMAILMESSAGE="/tmp/people_purge_email.txt"
echo "This is a friendly reminder that files and folders in your people folder"> $EMAILMESSAGE
echo "that are 30 days or older will be deleted on the 1st of every month @ 6 a.m. PST." >>$EMAILMESSAGE
echo "Please move the files to your local machine if you do not want them deleted." >>$EMAILMESSAGE
echo "" >>$EMAILMESSAGE
echo "The People folder is not backed up and should not contain any Client related work." >>$EMAILMESSAGE
echo "" >>$EMAILMESSAGE
echo "Thank you." >>$EMAILMESSAGE
echo "" >>$EMAILMESSAGE
echo "-Thomas" >>$EMAILMESSAGE

MAILTEXT=`cat /tmp/people_purge_email.txt`
echo "$MAILTEXT" | mail -s "*** WARNING *** Monthly People Folder Purge" "$RECIPIENTS"

exit 0
#  A zero return value from the script upon exit indicates success
#+ to the shell.
