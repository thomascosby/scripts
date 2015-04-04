#!/bin/bash
# creates asset number folder in a new brand folder
echo;echo "This script creates numbered asset folders inside a new brand folder.";echo
read -p "Enter path to client assets (e.g. /mn_raid1/conagra/): " Client
# echo "Client asset path is: "$Client;echo
if [ ! -d "$Client" ]; then
  echo;echo "Invalid client path. Exiting.";echo
  exit
fi
read -p "Enter the name of the new Brand folder (e.g. Snacks): " Brand
# echo "Brand folder is: "$Brand;echo
if [ ! -d "$Client/""Assets/""$Brand" ]; then
  echo
  read -p "Brand folder doesn't exist: ""$Client""/""$Brand"". Create it? (y/n)" -n 1 -r
  echo
  if [[ ! $REPLY =~ ^[Yy]$ ]]
  then
    echo "###  USER CANCELLED  ###"
    exit
  fi
  mkdir "$Client/""Assets/""$Brand"
fi
echo;echo "Creating folders 5000-6000 in ""$Client/""Assets/""$Brand";echo
mkdir "$Client/""Assets/""$Brand""/5000"
mkdir "$Client/""Assets/""$Brand""/5100"
mkdir "$Client/""Assets/""$Brand""/5200"
mkdir "$Client/""Assets/""$Brand""/5300"
mkdir "$Client/""Assets/""$Brand""/5400"
mkdir "$Client/""Assets/""$Brand""/5500"
mkdir "$Client/""Assets/""$Brand""/5600"
mkdir "$Client/""Assets/""$Brand""/5700"
mkdir "$Client/""Assets/""$Brand""/5800"
mkdir "$Client/""Assets/""$Brand""/5900"
mkdir "$Client/""Assets/""$Brand""/6000"
chown -R root:schawk_users "$Client/""Assets/""$Brand"
chmod 755 "$Client/""Assets/""$Brand"
chmod 777 "$Client/""Assets/""$Brand/"*
echo "###  DONE  ###";echo

exit
