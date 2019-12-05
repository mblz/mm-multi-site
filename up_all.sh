#  --delete              \

rsync -avzp             \
  --exclude _*          \
  --exclude _bash       \
  --exclude cms         \
  --exclude .DS_Store   \
  --exclude *.rb        \
  --exclude pvr         \
  --exclude shutterstock \
  $MM_BUILD_DIR mblz@assets.integrated-internet.com:~/static/assets/

ssh ass "chmod -R 755 ~/static/assets/sites"