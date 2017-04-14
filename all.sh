echo "Running start all scripts! <3"

cd /fs-data/backups/files/script-bank

./dh-io-1-backups.sh
echo "Node Complete"
sleep 1

./dh-io-2-backups.sh
echo "Node Complete"
sleep 1

./dh-io-3-backups.sh
echo "Node Complete"
sleep 1

./dh-io-4-backups.sh
echo "Node Complete"
sleep 1

./dh-io-5-backups.sh
echo "Node Complete"
sleep 1

./dh-mh-1.sh
echo "Node Complete"
sleep 1

./dh-mh-2.sh
echo "Node Complete"
sleep 1

./solder-backup.sh
echo "Node Complete"
sleep 1

echo "All files complete"



