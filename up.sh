# echo  $MM_BUILD_DIR$1
# exit
if [ -z "$1" ]   # Exit if no argument given.
then
  echo Usage: up.sh [SITE_NAME].
  echo None provide
  exit $E_NOARGS
fi  

rsync -avzp             \
  --delete              \
  --exclude _*          \
  --exclude _bash       \
  --exclude cms         \
  --exclude .DS_Store   \
  --exclude *.rb        \
  --exclude rakefile.rb \
  --exclude pvr         \
  --exclude shutterstock \
  $MM_BUILD_DIR$1/ mblz@assets.integrated-internet.com:~/static/assets/sites/$1/


ssh mblz@assets.integrated-internet.com "chmod -R 755 ~/static/assets/sites/$1"
#ssh bu "rm ~/static/assets/sites/$1/rakefile.rb"