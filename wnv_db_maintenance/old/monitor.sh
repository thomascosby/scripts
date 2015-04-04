#!/bin/bash

while sleep 300
do
   echo `date` >> /usr/schawk/logs/optimizelog.temp
   ps aux | grep dbmgr | grep -v grep | grep -v tail >> /usr/schawk/logs/optimizelog.temp
done

