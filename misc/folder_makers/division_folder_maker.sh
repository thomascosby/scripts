#!/bin/bash
# creates asset number folder in a new Division folder
echo;echo "This script creates numbered asset folders inside a new division folder.";echo
read -p "Enter path to client assets (e.g. /mn_raid1/conagra/): " Client

if [ ! -d "$Client" ]; then
  echo;echo "###  INVALID CLIENT PATH - EXITING  ###";echo
  exit
fi
read -p "Enter the name of the new division folder (e.g. Snacks): " Division

# check to see if this division folder exists; if not, offer to create
if [ ! -d "$Client/""Assets/""$Division" ]; then
  echo
  read -p "Division folder doesn't exist: ""$Client""/""$Division"". Create it? (y/n) : " -n 1 -r
  echo
  if [[ ! $REPLY =~ ^[Yy]$ ]]
  then
    echo "###  USER CANCELLED - EXITING ###"
    exit
  fi
  mkdir "$Client/""Assets/""$Division"
fi

# check to see if the Images folder exists; if not, offer to create
if [ ! -d "$Client/""Assets/""$Division""Images" ]; then
  echo
  read -p "Images folder doesn't exist. Create it? (y/n) : " -n 1 -r
  echo
  if [[ ! $REPLY =~ ^[Yy]$ ]]
  then
    echo "###  CANNOT PROCEED WITHOUT IMAGES FOLDER - EXITING  ###"
    exit
  fi
  mkdir "$Client/""Assets/""$Division""/Images"
fi

# check to see if a PDF Library folder exists; if not, offer to create
if [ ! -d "$Client/""Assets/""$Division/""PDF Library" ]; then
  echo
  read -p "PDF Library folder doesn't exist. Create it? (y/n) : " -n 1 -r
  echo
  if [[ ! $REPLY =~ ^[Yy]$ ]]
  then
    echo "###  PDF LIBRARY NOT CREATED  ###"
  else
    mkdir "$Client/""Assets/""$Division""/PDF Library"
  fi
fi

# check to see if a Dielines folder exists; if not, offer to create
if [ ! -d "$Client/""Dielines" ]; then
  echo
  read -p "Dielines folder doesn't exist. Create it? (y/n) : " -n 1 -r
  echo
  if [[ ! $REPLY =~ ^[Yy]$ ]]
  then
    echo "###  DIELINES NOT CREATED  ###"
  else
    mkdir "$Client/""Dielines"
    mkdir "$Client/""Dielines/""3D Structures"
  fi
fi

# create numbered folders
echo;echo "Creating folders 5000-6000 in ""$Client/""Assets/""$Division";echo
mkdir "$Client/""Assets/""$Division""/Images/5000"
mkdir "$Client/""Assets/""$Division""/Images/5100"
mkdir "$Client/""Assets/""$Division""/Images/5200"
mkdir "$Client/""Assets/""$Division""/Images/5300"
mkdir "$Client/""Assets/""$Division""/Images/5400"
mkdir "$Client/""Assets/""$Division""/Images/5500"
mkdir "$Client/""Assets/""$Division""/Images/5600"
mkdir "$Client/""Assets/""$Division""/Images/5700"
mkdir "$Client/""Assets/""$Division""/Images/5800"
mkdir "$Client/""Assets/""$Division""/Images/5900"
mkdir "$Client/""Assets/""$Division""/Images/6000"

# set ownership and permissions
chown -R root:schawk_users "$Client/""Assets/""$Division"
chown -R root:schawk_users "$Client/""Dielines/"
chmod 755 "$Client/""Assets/""$Division"
chmod 755  "$Client/""Assets/""$Division""/Images"
chmod 777 "$Client/""Assets/""$Division/""/Images/"*
if [ -d "$Client/""Assets/""$Division/""PDF Library" ]; then
  chmod 777 "$Client/""Assets/""$Division/""PDF Library"
fi
if [ -d "$Client/""Dielines" ]; then
  chmod 755 "$Client/""Dielines"
fi
if [ -d "$Client/""Dielines/""3D Structures" ]; then
  chmod 777 "$Client/""Dielines/""3D Structures"
fi
echo "###  DONE  ###";echo

exit
