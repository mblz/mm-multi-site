rsync -avzp             \
  --exclude _*          \
  --exclude _bash       \
  --exclude cms         \
  --exclude .DS_Store   \
  --exclude *.rb        \
  --exclude shutterstock \
  ~/Pictures/assets/ mblz@ass:~/static/assets/

ssh bu "chmod -R 755 ~/static/assets/sites"