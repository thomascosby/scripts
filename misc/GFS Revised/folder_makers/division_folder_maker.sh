#!/bin/bash
#  creates asset number folder in a new Division folder
#  revised 20140630 - adjusted the mkdir with the -p flag tcosby
echo;echo "This script creates a new division folder, including numbered asset folders & other required folders.";echo
read -p "Enter path to client assets (e.g. /mn_raid1/conagra/): " Client
#  check to see if this client folder exists; if not, offer to create
if [ ! -d "$Client" ]; then
    echo
  read -p "Client folder doesn't exist: "$Client/". Create it? (y/n) : " -n 1 -r
  echo
  if [[ ! $REPLY =~ ^[Yy]$ ]]
  then
    echo "###  USER CANCELLED - EXITING  ###"
    exit
  fi
  mkdir -p "$Client/"
fi
read -p "Enter the name of the new division folder (e.g. Snacks): " Division

#  check to see if this division folder exists; if not, offer to create
if [ ! -d "$Client/""PCBU93007/Images/""$Division" ]; then
  echo
  read -p "Division folder doesn't exist: ""$Client/""PCBU93007/Images/""$Division"". Create it? (y/n) : " -n 1 -r
  echo
  if [[ ! $REPLY =~ ^[Yy]$ ]]
  then
    echo "###  USER CANCELLED - EXITING ###"
    exit
  fi
  mkdir -p  "$Client/""PCBU93007/Images/""$Division"
fi

#  check to see if the Raster folder exists; if not, offer to create
if [ ! -d "$Client/""PCBU93007/Images/""$Division""Raster" ]; then
  echo
  read -p "Raster folder doesn't exist. Create it? (y/n) : " -n 1 -r
  echo
  if [[ ! $REPLY =~ ^[Yy]$ ]]
  then
    echo "###  CANNOT PROCEED WITHOUT IMAGES FOLDER - EXITING  ###"
    exit
  fi
  mkdir -p "$Client/""PCBU93007/Images/""$Division""/Raster"
fi

#  check to see if the Vector folder exists; if not, offer to create
if [ ! -d "$Client/""PCBU93007/Images/""$Division""Vector" ]; then
  echo
  read -p "Vector folder doesn't exist. Create it? (y/n) : " -n 1 -r
  echo
  if [[ ! $REPLY =~ ^[Yy]$ ]]
  then
    echo "###  CANNOT PROCEED WITHOUT IMAGES FOLDER - EXITING  ###"
    exit
  fi
  mkdir -p "$Client/""PCBU93007/Images/""$Division""/Vector"
fi

#  check to see if a PDF Library folder exists; if not, offer to create
if [ ! -d "$Client/""PCBU93007/Images/""$Division""PDF Library" ]; then
  echo
  read -p "PDF Library folder doesn't exist. Create it? (y/n) : " -n 1 -r
  echo
  if [[ ! $REPLY =~ ^[Yy]$ ]]
  then
    echo "###  PDF LIBRARY NOT CREATED  ###"
  else
    mkdir -p "$Client/""PCBU93007/Images/""$Division""/PDF Library"
  fi
fi

#  check to see if Dielines folder exists; if not, offer to create
# if [ ! -d "$Client/""PCBU93007/Images/""$Division""/Dielines" ]; then
  if [ ! -d "$Client/""PCBU93007/Dielines" ]; then
  echo
  read -p "Dielines folder doesn't exist. Create it? (y/n) : " -n 1 -r
  echo
  if [[ ! $REPLY =~ ^[Yy]$ ]]
  then
    echo "###  DIELINES FOLDER NOT CREATED  ###"
  else
    mkdir -p "$Client/""PCBU93007/Dielines"
    mkdir -p "$Client/""PCBU93007/Dielines/""3D Structures"
  fi
fi

#  check to see if Line_Art folder exists; if not, offer to create
#  if [ ! -d "$Client/""PCBU93007/Images/""$Division""/Line_Art" ]; then
if [ ! -d "$Client/""PCBU93007/Line_Art" ]; then
  echo
  read -p "Line_Art folder doesn't exist. Create it? (y/n) : " -n 1 -r
  echo
  if [[ ! $REPLY =~ ^[Yy]$ ]]
  then
    echo "###  LINE_ART FOLDER NOT CREATED  ###"
  else
    mkdir -p "$Client/""PCBU93007/Line_Art"
  fi
fi

#  create numbered folders
echo;echo "Creating folders 5000-6000 in ""$Client/""PCBU93007/Images/""$Division";echo
cd "$Client/""PCBU93007/Images/""$Division/""Raster/"
mkdir -p "5000"
mkdir -p "5100"
mkdir -p "5200"
mkdir -p "5300"
mkdir -p "5400"
mkdir -p "5500"
mkdir -p "5600"
mkdir -p "5700"
mkdir -p "5800"
mkdir -p "5900"
mkdir -p "6000"

#  set ownership and permissions
chown -R root:schawk_users "$Client/""PCBU93007/"
#chown -R root:schawk_users "$Client/""PCBU93007/""Dielines/"
#chown -R root:schawk_users "$Client/""PCBU93007/""Line_Art/"
chmod 777 "$Client/""PCBU93007/""Line_Art/"
chmod 755 "$Client/""PCBU93007/Images/""$Division"
chmod 755 "$Client/""PCBU93007/Images/""$Division""/Raster"
chmod 777 "$Client/""PCBU93007/Images/""$Division""/Vector"
chmod 777 "$Client/""PCBU93007/Images/""$Division""/Raster/"*
if [ -d "$Client/""PCBU93007/Images/""$Division/""PDF Library" ]; then
  chmod 777 "$Client/""PCBU93007/Images/""$Division/""PDF Library"
fi
if [ -d "$Client/""PCBU93007/""Dielines" ]; then
  chmod 755 "$Client/""PCBU93007/""Dielines"
fi
if [ -d "$Client/""PCBU93007/""Dielines/""3D Structures" ]; then
  chmod 777 "$Client/""PCBU93007/""Dielines/""3D Structures"
fi
echo "###  DONE  ###";echo

exit 0
#  A zero return value from the script upon exit indicates success
#+ to the shell.