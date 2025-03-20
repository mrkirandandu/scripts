#!/bin/sh
#Scipt to delete when a dir has 100,000

#Command to delete files which are created last 24 hours from the directory
find /tmp/duplicatefiles/ -maxdepth 1 -name "file_*" -mtime -1 | tee /tmp/duplicatefiles/filecleaner_$(date +"%d-%m-%Y-%H:%M:%S").log | xargs -n 10000 rm -f

#This command is to delete files which are older than 60days from the directory for PROD and log the files with date which are deleted when files are more than 50,000
find /tmp/duplicatefiles/ -maxdepth 1 -name "file_*" -mtime +60 | tee /tmp/duplicatefiles/filecleaner_$(date +"%d-%m-%Y-%H:%M:%S").log | xargs -n 10000 rm -f
