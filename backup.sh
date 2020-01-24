#!/bin/bash
# backup.sh
# max dobeck
# github.com/maxdobeck

# Copy critical stuff before zipping
cp ~/.bashrc ~/Backup
echo "Copied ~/.bashrc file to ~/Backup"
cp ~/.bash_aliases ~/Backup
echo "Copied ~/.bash_aliases to ~/Backup"

dirs=("Backup" "ovpns" "Pictures/Backgrounds" "Documents" "Music" "Audio/raw" "scripts")

for dir in "${dirs[@]}"
do
    fn=$(echo "$dir" | tr / _)
    tar -X ~/scripts/tar-exclude.txt -zcvf  /tmp/$fn.tar.gz ~/$dir
    echo /tmp/$dir.tar.gz created
done

# scp the .tar files to the media server
for dir in "${dirs[@]}"
do
    fn=$(echo "$dir" | tr / _)
    echo "moving /tmp/$fn.tar.gz to $LOCALMAIN_SERVER"
    scp /tmp/$fn.tar.gz $LOCALMAIN_USER@$LOCALMAIN_SERVER:/home/mdobeck/media/backups
done

# python script to upload to linode goes here
# cheap to upload to raspberry pi locally.  expensive to go outside local network.