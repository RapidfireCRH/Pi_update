#!/usr/bin/env bash

# check if it's past midnight
if [[ $(env TZ=Etc/UTC date +"%H") != "00" ]]; then
    exit 0 # not midnight, stop execution
fi

# constants
home_dir=/home/listener
jsonl_file=$(env TZ=Etc/UTC date -d "yesterday" +%Y-%m-%d.jsonl)
log=$(env TZ=Etc/UTC date -d "yesterday" +%Y-%m-%d.log)

mkdir -p $home_dir/working
mkdir -p $home_dir/webfolder
cd $home_dir/working

#cleanup and logging
echo "Deleting old files in cache"
find /home/listener/working/cache -type f -mtime +7
find /home/listener/working/cache -type f -mtime +7 | xargs -r0 rm --

#actual compress
echo "Starting Compress: $(date)"
echo "Moving File $jsonl_file"
mv ../$jsonl_file ./$jsonl_file
echo "Moving Log File"
mv ../log/listener.log ./listener.log
echo "Creating 7zip file"
7zr a "$jsonl_file.7z" $jsonl_file listener.log

#post compress
echo "Deleting listener file"
rm ./listener.log
echo "deleting json file"
rm $jsonl_file
echo "moving 7zip file to completed folder"
mv "$jsonl_file.7z" "$home_dir/webfolder/$jsonl_file.7z"
echo "Compress completed: $(date)"
echo "Removing old files"
find $home_dir/webfolder/ -type f -name '*.7z' -mtime +30 -exec rm {} \;
