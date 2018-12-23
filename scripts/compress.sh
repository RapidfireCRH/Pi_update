# constants
cd /home/listener/working
yest=$(date +%Y-%m-%d_json)
log=$(date +%Y-%m-%d.log)
dat=$(date)

#cleanup and logging
echo "Deleting old files in cache">./log/$log 2>&1
find /home/listener/working/cache -type f -mtime +7>>./log/$log 2>&1
find /home/listener/working/cache -type f -mtime +7 | xargs -r0 rm -->>./log/$log 2>&1

#actual compress
echo "Starting Compress: $dat">>./log/$log 2>&1
echo "Moving File $yest">>./log/$log 2>&1
mv ../$yest ./$yest>>./log/$log 2>&1
echo "Moving Log File">>./log/$log 2>&1
mv ../log/listener.log ./listener.log>>./log/$log 2>&1
echo "Creating 7zip file">>./log/$log 2>&1
7zr a "$yest.7z" $yest listener.log>>./log/$log 2>&1

#post compress
echo "Deleting listener file">>./log/$log 2>&1
rm ./listener.log>>./log/$log 2>&1
echo "moving json file">>./log/$log 2>&1
mv $yest ./cache/$yest>>./log/$log 2>&1
echo "moving 7zip file to completed folder">>./log/$log 2>&1
mv "$yest.7z" "../../webhost/webroot/$yest.7z">>./log/$log 2>&1
dat=$(date)
echo "Compress completed: $dat">>./log/$log 2>&1
echo "Changing ownership">>./log/$log 2>&1
chown webhost:webhost "../../webhost/webroot/$yest.7z">>./log/$log 2>&1
chmod 664 "../../webhost/webroot/$yest.7z">>./log/$log 2>&1
chown listener:listener "./log/$log">>./log/$log 2>&1
