#!/bin/bash
# backup.sh
# max dobeck
# github.com/maxdobeck

# example to generate hash of tar directory
# tar -c ~/Music/ | md5sum | awk '{ print $1}'

# Copy critical stuff before zipping
cp ~/.bashrc ~/Backup
echo "Copied ~/.bashrc file to ~/Backup"
cp ~/.bash_aliases ~/Backup
echo "Copied ~/.bash_aliases to ~/Backup"

dirs=("Backup" "ovpns" "Pictures/Backgrounds" "Documents" "Music" "Audio/raw" "scripts" "cheatsheet_project" "rust")

for dir in "${dirs[@]}"
do
    fn=$(echo "$dir" | tr / _)
    GZIP=-9 tar -X ~/scripts/tar-exclude.txt -zcf  /tmp/$fn.tar.gz ~/$dir
    echo /tmp/$dir.tar.gz created
done

# scp the .tar files to the media server
for dir in "${dirs[@]}"
do
    fn=$(echo "$dir" | tr / _)
    echo "moving /tmp/$fn.tar.gz to $LOCALMAIN_SERVER"
    scp /tmp/$fn.tar.gz $LOCALMAIN_USER@$LOCALMAIN_SERVER:/home/mdobeck/media/backups &
done


for dir in "${dirs[@]}"
do
    fn=$(echo "$dir" | tr / _)
    linode-cli obj put /tmp/$fn.tar.gz $REMOTE_BACKUP
done
