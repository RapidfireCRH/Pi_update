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
    #get all scripts
    wget https://raw.githubusercontent.com/RapidfireCRH/Pi_update/master/scripts/listener.sh
    wget https://raw.githubusercontent.com/RapidfireCRH/Pi_update/master/scripts/compress.sh
    wget https://raw.githubusercontent.com/RapidfireCRH/Pi_update/master/scripts/temp.sh
    #get all python scripts
    wget https://raw.githubusercontent.com/RapidfireCRH/Pi_update/master/scripts/Client_Simple.py
    wget https://raw.githubusercontent.com/RapidfireCRH/Pi_update/master/scripts/temp.py
    
    #remove and replace all scripts
    rm /home/listener/listener.sh
    mv ./listener.sh /home/listener/listener.sh
    rm /home/listener/Client_Simple.py
    mv ./Client_Simple.py /home/listener/Client_Simple.py
    rm /home/scripts/compress.sh
    mv ./compress.sh /home/scripts/compress.sh
    
    #set permissions on each file
    chown listener:listener listener.sh
    chmod 774 /home/listener/listener.sh
    chown listener:listener Client_Simple.py
    chmod 774 /home/listener/Client_Simple.py
    chown root:root
    chmod 770 /home/scripts/compress.sh
    chown root:root
    chmod 770 /home/scripts/temp.sh
    chown root:root
    chmod 770 /home/scripts/temp.py
fi
