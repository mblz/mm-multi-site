rsync   \
  -avz  \
    ass:/home/mblz/static/assets/sites/ @MM_BUILD_DIR
#ass:~/static/assets/sites/ ~/Pictures/assets/sites
# echo "syncing dbs and assets to mblzx"

# ssh mblz@z '~/cron/backup/dbs.sh'
# ssh mblz@z '~/cron/backup/assets.sh'

# echo "syncing assets from mblzx - including pvr and cms"

# rsync -avz mblz@x:~/assets/ .

# echo "download the dbs to local ~/Documents/dbs"

# scp mblz@x:~/db/cms.sql.gz ~/Documents/dbs/
# scp mblz@x:~/db/pvr.sql.gz ~/Documents/dbs/

# echo "unzipping dbs"

# gunzip -f ~/Documents/dbs/cms.sql.gz
# gunzip -f ~/Documents/dbs/pvr.sql.gz

# echo "drop/create dbs"

# mysql -uroot -e 'drop database cms'
# mysql -uroot -e 'create database cms'

# mysql -uroot -e 'drop database pvr'
# mysql -uroot -e 'create database pvr'

# echo 'importing the dbs'

# mysql -uroot cms < ~/Documents/dbs/cms.sql
# mysql -uroot pvr < ~/Documents/dbs/pvr.sql

# echo DONE