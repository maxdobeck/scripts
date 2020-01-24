#!/bin/bash
# backup.sh
# max dobeck
# github.com/maxdobeck

# Copy stuff
cp ~/.bashrc ~/Backup
echo "Copied ~/.bashrc file to ~/Backup"
cp ~/.bash_aliases ~/Backup
echo "Copied ~/.bash_aliases to ~/Backup"

# Tar it
tar -X ~/scripts/tar-exclude.txt -zcvf  /tmp/backup.tar.gz ~/Backup ~/ovpns ~/Pictures/Backgrounds  ~/Documents ~/Music ~/Audio/raw ~/scripts
tput setaf 1; echo "/tmp/backup.tar.gz created"

# scp to the media server
echo "moving /tmp/backup.tar.gz to $LOCALMAIN_SERVER"
scp /tmp/backup.tar.gz $LOCALMAIN_USER@$LOCALMAIN_SERVER:/home/mdobeck/media/backups
