#!/bin/bash

cat uuids.txt | while read line
do
  echo "curl --user admin:admin -X DELETE -i 'http://localhost:8080/alfresco/api/-default-/public/alfresco/versions/1/deleted-nodes/"$line"'"
  echo Deleting node in the trashcan UUID: "$line" 
  curl --user admin:admin -X DELETE -i http://localhost:8080/alfresco/api/-default-/public/alfresco/versions/1/deleted-nodes/"$line"
done


