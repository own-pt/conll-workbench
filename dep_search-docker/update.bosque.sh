cd /root/bosque-UD/
git pull

cd /root/dep_search/
cat /root/bosque-UD/documents/*.conllu | python build_index.py --wipe -d /root/bosque.db
