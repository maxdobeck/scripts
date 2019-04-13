#!/bin/bash
# backup.sh script
# max dobeck github.com/maxdobeck

# Copy stuff
cp ~/.bashrc ~/Backup
echo "Copied ~/.bashrc file to ~/Backup"
cp ~/.bash_aliases ~/Backup
echo "Copied ~/.bash_aliases to ~/Backup"

# Tar it
tar -X ~/scripts/tar-exclude.txt -zcvf  /tmp/backup.tar.gz ~/Backup ~/ovpns ~/Pictures/Backgrounds  ~/Documents ~/scripts
tput setaf 1; echo "/tmp/backup.tar.gz created"
