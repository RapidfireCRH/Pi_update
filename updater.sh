wget https://raw.githubusercontent.com/RapidfireCRH/Pi_update/master/updater.version -o updater.version

if('$(wc -l updater.sh.new)' -eq '$(wc -l updater.sh)') then
    rm updater.sh.new
else
    rm updater.sh
    mv updater.sh.new updater.sh
    ./updater.sh
exit
fi

wget 
wget 
wget
wget
wget

