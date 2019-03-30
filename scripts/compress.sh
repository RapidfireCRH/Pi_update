#!/usr/bin/env bash

# constants
cd /home/listener/working
yest=$(env TZ=Etc/UTC date -d "yesterday" +%Y-%m-%d_json)
correctformat=$(env TZ=Etc/UTC date -d "yesterday" +%Y-%m-%d.jsonl)
log=$(env TZ=Etc/UTC date -d "yesterday" +%Y-%m-%d.log)

#cleanup and logging
echo "Deleting old files in cache"
find /home/listener/working/cache -type f -mtime +7
find /home/listener/working/cache -type f -mtime +7 | xargs -r0 rm --

#actual compress
echo "Starting Compress: $(date)"
echo "Moving File $yest"
mv ../$yest ./$correctformat
echo "Moving Log File"
mv ../log/listener.log ./listener.log
echo "Creating 7zip file"
7zr a "$correctformat.7z" $correctformat listener.log

#post compress
echo "Deleting listener file"
rm ./listener.log
echo "deleting json file"
rm $correctformat
echo "moving 7zip file to completed folder"
mv "$correctformat.7z" "../../webhost/webroot/$correctformat.7z"
echo "Compress completed: $(date)"
echo "Changing ownership"
chown webhost:webhost "../../webhost/webroot/$correctformat.7z"
chmod 664 "../../webhost/webroot/$correctformat.7z"
chown listener:listener "./log/$log"
