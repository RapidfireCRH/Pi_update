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
wget https://github.com/RapidfireCRH/Pi_update/blob/master/lastupdate -o lastupdate.new
if [ "$(md5sum < lastupdate.new)" = "$(md5sum < lastupdate)" ]; then
    exit
else
    wget listener
    wget compress
    wget temp
fi
