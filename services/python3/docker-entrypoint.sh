#!/bin/bash
echo '*******************************************************************'
echo '** Dynamic execute scripts which under path /data/config/python3/ **'
echo '******** all the names of scripts should start with "run-" ********'
echo '*******************************************************************'

# check directory
if [ ! -d /data/conf/python3/ ]; then
    echo 'Path(/data/conf/python3/) does not exist'
    exit
fi

for script in /data/conf/python3/run-*; do
    chmod +x "$script"
    bash "$script"
done
