#!/bin/bash
#  creates folder structure for the Archive folder structure as required by KB 785
echo;echo "This script creates the Archive folder structure. As well as appropriate permissions";echo
read -p "Enter path to client assets (e.g. /mn_san_arch2/jobsarchive/safewayarchive): " CLIENT

#  check to see if this archive folder exists; if not, offer to create
if [ ! -d "$CLIENT" ]; then
    echo
  read -p "Client folder doesn't exist: "$CLIENT/". Create it? (y/n) : " -n 1 -r
  echo
  if [[ ! $REPLY =~ ^[Yy]$ ]]
  then
    echo "###  USER CANCELLED - EXITING  ###"
    exit
fi
mkdir -p "$CLIENT/""Jobs Archive/""2014/"

echo;echo "This script creates the Archive2 folder structure. As well as appropriate permissions";echo
read -p "Enter path to client assets (e.g. /mn_arch3/jobsarchive/safewayarchive2): " CLIENT2

#  check to see if this archive folder exists; if not, offer to create
if [ ! -d "$CLIENT2" ]; then
    echo
  read -p "Client folder doesn't exist: "$CLIENT2/". Create it? (y/n) : " -n 1 -r
  echo
  if [[ ! $REPLY =~ ^[Yy]$ ]]
  then
    echo "###  USER CANCELLED - EXITING  ###"
    exit
fi
mkdir -p "$CLIENT2/""Jobs Archive/""2014/"

#  set ownership and permissions
chown -R root:archivers "$CLIENT"
chmod -R 755 "$CLIENT"
chown -R root:archivers "$CLIENT2"
chmod -R 755 "$CLIENT2"

echo "###  Successful Completion  ###";echo

exit 0
#  A zero return value from the script upon exit indicates success
#+ to the shell.