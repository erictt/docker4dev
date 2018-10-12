#!/bin/sh

usage() {
    echo "Usage: $0 [-c] db_name sql_path"
    echo "-c\tif you want to create the database"
    exit
}

NEED_CREATE=0
# while true ; do
while getopts c: option; do
    case "$option" in
        c)
            NEED_CREATE=1;
            shift
            ;;
    esac
done

db_name="$1"
dumpfile="$2"

# get database name and sql file path
if [ $db_name = "" ] || [ $dumpfile = "" ]; then
    echo "Please specify database name and sql file path"
    usage
    exit
else
    echo "Database name is $db_name"

    if [ ! -f "$dumpfile" ]; then
        echo "path '$dumpfile' doesn't exist"
        usage
        exit
    else
        echo "DB file path is $dumpfile"
    fi
fi

# store start date to a variable
imeron=`date`

ddl="set names utf8; "
ddl="$ddl set global net_buffer_length=10000000;"
ddl="$ddl set global max_allowed_packet=1000000000; "
ddl="$ddl SET foreign_key_checks = 0; "
ddl="$ddl SET UNIQUE_CHECKS = 0; "
ddl="$ddl SET AUTOCOMMIT = 0; "

if [ $NEED_CREATE -eq 1 ]; then
    echo "Create database $db_name";
    ddl="$ddl CREATE DATABASE $db_name CHARACTER SET utf8 COLLATE utf8_bin; ";
fi

# if your dump file does not create a database, select one
ddl="$ddl USE $db_name; "
ddl="$ddl source $dumpfile; "
ddl="$ddl SET foreign_key_checks = 1; "
ddl="$ddl SET UNIQUE_CHECKS = 1; "
ddl="$ddl SET AUTOCOMMIT = 1; "
ddl="$ddl COMMIT ; "

echo "Import started: OK"

# echo "$ddl"
mysql -hlocalhost -uroot -pnytcn -e "$ddl"
# time docker-compose run --rm mysql-cli -hdb -uroot -pnytcn -e "$ddl"

# store end date to a variable
imeron2=`date`

echo "Start import:$imeron"
echo "End import:$imeron2"
