# Installation on a Linux server

1. Create a new user: ``adduser --disabled-login --gecos 'EDDN Listener' eddn``
2. Install requirements
    * ``Python3``
    * Run pip of Python3 to install ``zmq``
    * ``p7zip``
    * A webserver. You can use ``apache2``, ``nginx`` or ``lighttpd``. The provided scripts assume that the user of the webserver has access to ``/home/eddn/webfolder``
3. Switch to the new user: ``su eddn`` and go to the home directoy ``cd ~``
    1. Clone or download this repository. Make sure you get the right branch (linux-service) and put the files from the scripts folder in ``/home/eddn``
    2. Make the scripts executable ``chmod +x compress.sh listener.sh``
    3. Create the webroot folder: ``mkdir webroot``
    4. Add to crontab of eddn: ``5 * * * * /home/scripts/compress.sh>>/home/eddn/log/log.log``\
    The script will only run in the hour past midnight. So there is no harm in calling it every hour.
4. Switch back to root
    1. Install the systemd service. Copy [extras/eddn-listener.service](https://github.com/RapidfireCRH/Pi_update/blob/linux-service/extras/eddn-listener.service) to ``/etc/systemd/system/eddn-listener.service``
    2. Reload systemd services ``sudo systemctl daemon-reload``
    3. Set it to start automatically ``sudo systemctl enable eddn-listener``
    4. Start it ``sudo systemctl start eddn-listener``
    5. Check if it's running ``systemctl status eddn-listener.service``
5. Configure Webserver
    * **lighttpd**: There is a config for it in (extras)[https://github.com/RapidfireCRH/Pi_update/tree/linux-service/extras]. This has to go to ``/etc/lighttpd/lighttpd.conf``
    * **Apache2**: Create a symlink to the webroot ``ln -s /home/eddn/webfolder/ /var/www/html/eddn`` and if necessary put the htaccess file from (extras)[https://github.com/RapidfireCRH/Pi_update/tree/linux-service/extras] into the webfolder to enable folder listing.
6. Contact Rapidfire, so he can pull the compressed files.


**Note**: To run 7zip with the lowest possible priority, edit ``compress.sh`` and change the line\
``7zr a "$jsonl_file.7z" $jsonl_file listener.log`` to\
``nice -n 19 7zr a "$jsonl_file.7z" $jsonl_file listener.log``
