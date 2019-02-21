#mount /dev/sda1 /home/webhost
if ! [ -d /home/webhost/log ]
then
  mkdir /home/webhost/log
  chown webhost:webhost /home/webhost/log
fi
if ! [ -d /home/webhost/webroot ]
then
  mkdir /home/webhost/webroot
  chown webhost:webhost /home/webhost/webroot
fi
