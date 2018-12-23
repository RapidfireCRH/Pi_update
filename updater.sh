#check for update on updater
wget https://raw.githubusercontent.com/RapidfireCRH/Pi_update/master/updater.version -o updater.version.new
if [ "$(md5sum < updater.version.new)" = "$(md5sum < updater.version)" ]; then
    rm updater.verison.new
else
    rm updater.sh
    rm updater.version
    wget https://raw.githubusercontent.com/RapidfireCRH/Pi_update/master/updater.sh -o updater.sh
    mv updater.version.new updater.version
    ./updater.sh
    exit
fi

#check for newer version of scripts
wget 
if [ "$(md5sum < lastupdate.new)" = "$(md5sum < lastupdate)" ]; then
wget 
wget 
wget
wget
wget

