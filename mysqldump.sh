#!/bin/bash
source .env

_os="`uname`"
_now=$(date +"%m_%d_%Y")
_file="./db-dumps/data_$_now.sql"


# Export dump
EXPORT_COMMAND="exec mysqldump $DB_NAME -uroot -p$DB_ROOT_PASSWORD"
docker-compose exec --no-TTY db sh -c "$EXPORT_COMMAND" > $_file

if [[ $_os == "Darwin"* ]] ; then
  sed -i '.bak' 1,1d $_file
else
  sed -i 1,1d $_file # Removes the password warning from the file
fi
