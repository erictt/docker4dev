#!/bin/bash
echo '*******************************************************************'
echo '** Dynamic execute scripts which under path /data/config/nodejs8/ **'
echo '******** all the names of scripts should start with "run-" ********'
echo '*******************************************************************'

# check directory
if [ ! -d /data/conf/nodejs8/ ]; then
    echo 'Path(/data/conf/nodejs8/) does not exist'
    exit
fi

for script in /data/conf/nodejs8/run-*; do
    chmod +x "$script"
    pm2 start "$script"
done

pm2 logs
