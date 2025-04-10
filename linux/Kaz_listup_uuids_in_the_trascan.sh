#!/bin/bash

curl --user admin:admin -X GET -i 'http://localhost:8080/alfresco/s/api/archive/workspace/SpacesStore?maxItems=100' > ArchiveStoreInfo.txt
echo ls -al
cat ArchiveStoreInfo.txt | grep "archive://SpacesStore/" | cut -d '/' -f 4 | cut -d ',' -f 1 | cut -d '"' -f 1 > UUIDs.txt
cat UUIDs.txt
rm ArchiveStoreInfo.txt

