#!/bin/bash
#
#  v1.0 - 20140909 - tcosby
#  creates folder structure in the Client Volume
#  
#
echo;echo "This script creates a client folder, including brand name & other required folders.";echo
read -p "Enter full path to client (e.g. /Volumes/15TB_RAID/Valhalla/Clients/Terra Tech):" CLIENTNAME
#
#  check to see if this client folder exists; if not, offer to create
if [ ! -d "$CLIENTNAME" ]; then
    echo
  read -p "Client folder doesn't exist: "$CLIENTNAME/". Create it? (y/n) : " -n 1 -r
  echo
  if [[ ! $REPLY =~ ^[Yy]$ ]]
  then
    echo "###  USER CANCELLED - EXITING  ###"
    exit
  fi
  mkdir -p "$CLIENTNAME/"
fi
read -p "Enter the name of the Brand folder (e.g. IVXX): " BRANDNAME
#
#  check to see if this brand folder exists; if not, offer to create
if [ ! -d "$CLIENTNAME/""$BRANDNAME/" ]; then
  echo
  read -p "Brand Name folder doesn't exist: "$CLIENTNAME/""$BRANDNAME/". Create it? (y/n) : " -n 1 -r
  echo
  if [[ ! $REPLY =~ ^[Yy]$ ]]
  then
    echo "###  USER CANCELLED - EXITING  ###"
    exit
  fi
  mkdir -p "$CLIENTNAME/""$BRANDNAME/"
fi
read -p "Enter the name of the Project folder (e.g. Snacks): " PROJECTNAME
#
#  check to see if this project folder exists; if not, offer to create
#if [ ! -d "$CLIENTNAME/""$BRANDNAME/""$PROJECTNAME/" ]; then
  echo
 # read -p "Project Name folder doesn't exist: "$CLIENTNAME/""$BRANDNAME/""$PROJECTNAME/" Create it? (y/n) : " -n 1 -r
  echo
 # if [[ ! $REPLY =~ ^[Yy]$ ]]
 # then
  #  echo "###  USER CANCELLED - EXITING  ###"
  #  exit
 # fi
  mkdir -p "$CLIENTNAME/""$BRANDNAME/""$PROJECTNAME/"
  mkdir -p "$CLIENTNAME/""$BRANDNAME/""Brand Resources/"
  mkdir -p "$CLIENTNAME/""Master Account/""Client Contacts/"
  mkdir -p "$CLIENTNAME/""Master Account/""Master Service Aggreements/"
  
#
echo;echo "Now creating folder structure for:"
echo;echo "$CLIENTNAME/""$BRANDNAME/""$PROJECTNAME/"Account"
"$CLIENTNAME/""$BRANDNAME/""$PROJECTNAME/"Design"
echo;echo "$CLIENTNAME/""$BRANDNAME/""$PROJECTNAME/"Strategy"
"$CLIENTNAME/""$BRANDNAME/""$PROJECTNAME/"Tech Design"
echo;echo
#  
#  now create required structure within $PROJECTNAME/Account/
mkdir -p "$CLIENTNAME/""$BRANDNAME/""$PROJECTNAME/""Account/""Billing/""Invoices/"
mkdir -p "$CLIENTNAME/""$BRANDNAME/""$PROJECTNAME/""Account/""Billing/""Revenue Recognition/"
mkdir -p "$CLIENTNAME/""$BRANDNAME/""$PROJECTNAME/""Account/""Billing/""Signed Pro-Forma"
mkdir -p "$CLIENTNAME/""$BRANDNAME/""$PROJECTNAME/""Account/""Client Provided/"
mkdir -p "$CLIENTNAME/""$BRANDNAME/""$PROJECTNAME/""Account/""Creative Brief/"
mkdir -p "$CLIENTNAME/""$BRANDNAME/""$PROJECTNAME/""Account/""Presentations/"
mkdir -p "$CLIENTNAME/""$BRANDNAME/""$PROJECTNAME/""Account/""Proposals/"
mkdir -p "$CLIENTNAME/""$BRANDNAME/""$PROJECTNAME/""Account/""SKU List/"
mkdir -p "$CLIENTNAME/""$BRANDNAME/""$PROJECTNAME/""Account/""Timeline/"
#
#  now create required structure within $PROJECTNAME/Design/
mkdir -p "$CLIENTNAME/""$BRANDNAME/""$PROJECTNAME/""Design/""Audits/"
mkdir -p "$CLIENTNAME/""$BRANDNAME/""$PROJECTNAME/""Design/""Rounds/""Prepro/"
mkdir -p "$CLIENTNAME/""$BRANDNAME/""$PROJECTNAME/""Design/""Rounds/""R1/""Design Files/"
mkdir -p "$CLIENTNAME/""$BRANDNAME/""$PROJECTNAME/""Design/""Rounds/""R1/""PDFs/"
mkdir -p "$CLIENTNAME/""$BRANDNAME/""$PROJECTNAME/""Design/""Rounds/""R1/""Presentation Deck/"
mkdir -p "$CLIENTNAME/""$BRANDNAME/""$PROJECTNAME/""Design/""Rounds/""R2/""Design Files/"
mkdir -p "$CLIENTNAME/""$BRANDNAME/""$PROJECTNAME/""Design/""Rounds/""R2/""PDFs/"
mkdir -p "$CLIENTNAME/""$BRANDNAME/""$PROJECTNAME/""Design/""Rounds/""R2/""Presentation Deck/"
mkdir -p "$CLIENTNAME/""$BRANDNAME/""$PROJECTNAME/""Design/""Rounds/""R3/""Design Files/"
mkdir -p "$CLIENTNAME/""$BRANDNAME/""$PROJECTNAME/""Design/""Rounds/""R3/""PDFs/"
mkdir -p "$CLIENTNAME/""$BRANDNAME/""$PROJECTNAME/""Design/""Rounds/""R3/""Presentation Deck/"
mkdir -p "$CLIENTNAME/""$BRANDNAME/""$PROJECTNAME/""Design/""Sketches/""atsuei/"
mkdir -p "$CLIENTNAME/""$BRANDNAME/""$PROJECTNAME/""Design/""Sketches/""cmazer/"
mkdir -p "$CLIENTNAME/""$BRANDNAME/""$PROJECTNAME/""Design/""Sketches/""kbates/"
mkdir -p "$CLIENTNAME/""$BRANDNAME/""$PROJECTNAME/""Design/""Sketches/""kkuian/"
mkdir -p "$CLIENTNAME/""$BRANDNAME/""$PROJECTNAME/""Design/""Sketches/""mchan/"
mkdir -p "$CLIENTNAME/""$BRANDNAME/""$PROJECTNAME/""Design/""Sketches/""mttjhin/"
mkdir -p "$CLIENTNAME/""$BRANDNAME/""$PROJECTNAME/""Design/""Sketches/""smederios/"
mkdir -p "$CLIENTNAME/""$BRANDNAME/""$PROJECTNAME/""Design/""Sketches/""tdiehl/"
#
#  now create required structure within $PROJECTNAME/Strategy/
mkdir -p "$CLIENTNAME/""$BRANDNAME/""$PROJECTNAME/""Strategy/""Phase01/"
mkdir -p "$CLIENTNAME/""$BRANDNAME/""$PROJECTNAME/""Strategy/""Phase02/"
mkdir -p "$CLIENTNAME/""$BRANDNAME/""$PROJECTNAME/""Strategy/""Phase03/"
mkdir -p "$CLIENTNAME/""$BRANDNAME/""$PROJECTNAME/""Strategy/""Phase04/"
mkdir -p "$CLIENTNAME/""$BRANDNAME/""$PROJECTNAME/""Strategy/""Phase05/"
mkdir -p "$CLIENTNAME/""$BRANDNAME/""$PROJECTNAME/""Strategy/""References/"

#
#  now create required structure within $PROJECTNAME/Tech Design/
mkdir -p "$CLIENTNAME/""$BRANDNAME/""$PROJECTNAME/""Tech Design/""Design Handoff/"
mkdir -p "$CLIENTNAME/""$BRANDNAME/""$PROJECTNAME/""Tech Design/""HiRes Final Imagery/"
mkdir -p "$CLIENTNAME/""$BRANDNAME/""$PROJECTNAME/""Tech Design/""History/"
mkdir -p "$CLIENTNAME/""$BRANDNAME/""$PROJECTNAME/""Tech Design/""Mechanicals/"
mkdir -p "$CLIENTNAME/""$BRANDNAME/""$PROJECTNAME/""Tech Design/""Released YYYYMMDD/"
mkdir -p "$CLIENTNAME/""$BRANDNAME/""$PROJECTNAME/""Tech Design/""Resources/"
mkdir -p "$CLIENTNAME/""$BRANDNAME/""$PROJECTNAME/""Tech Design/""Working psd/"
#
#  set ownership and permissions
chown -R localadmin:staff "$CLIENTNAME/"
chmod 744 "$CLIENTNAME"
chmod -R 764 "$CLIENTNAME""$BRANDNAME/""$PROJECTNAME/"
chmod -R 764 "$CLIENTNAME""Master Account/"


echo "###  Successful Completion of "$CLIENTNAME/""$BRANDNAME/""$PROJECTNAME/"  ###" ; echo

exit 0
#  A zero return value from the script upon exit indicates success
#+ to the shell.