#  --delete              \

rsync -avzp             \
  --exclude _*          \
  --exclude _bash       \
  --exclude cms         \
  --exclude .DS_Store   \
  --exclude *.rb        \
  --exclude pvr         \
  --exclude shutterstock \
  ~/Pictures/assets/ mblz@assets.integrated-internet.com:~/static/assets/

ssh bu "chmod -R 755 ~/static/assets/sites"