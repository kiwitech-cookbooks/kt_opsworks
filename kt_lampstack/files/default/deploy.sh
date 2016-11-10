#!/bin/bash

cd /home/kiwitech/phpsysinfo

git pull origin master

PORTAL_PATH="/var/www/html/example.com"

sudo rsync -avz /home/kiwitech/phpsysinfo/* $PORTAL_PATH
#sudo cp -rf .htaccess $PORTAL_PATH;

sudo find $PORTAL_PATH -type d -exec chmod 755 {} \;
sudo find $PORTAL_PATH -type f -exec chmod 644 {} \;

#sudo cp -rf /mnt/database.php /var/www/html/sot/app/Config/
#sudo cp -rf /mnt/mh_constants.php /var/www/html/sot/app/Config/

#sudo chmod -R 755 /var/www/html/sot
#sudo chmod -R 777 /var/www/html/sot/app/tmp
#sudo chmod -R 777 /var/www/html/sot/app/webroot
#sudo chmod 777 /var/www/html/sot/app/Config/database.php

