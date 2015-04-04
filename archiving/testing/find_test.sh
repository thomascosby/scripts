#!/bin/bash
foundSet = `$(find /mn_raid*/*jobs/*WIP -maxdepth 0 -type d)`
for thisClient in "$foundSet"
do
	echo "Cleaning " "$thisClient";echo
	
	find "$thisClient"/Archive\ Staging/*/*/080_QC/* -depth ! -path '*/080_QC/3D Renderings*' ! -path '*/080_QC/Code Verification*' ! -path '*/080_QC/Compare*' ! -path '*/080_QC/PDF for Blue*' > /usr/schawk/logs/archiving/cleanup/080_QC_TEST.txt
	
done
