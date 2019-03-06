#!/bin/bash
set -e
CONF_FILE=/opt/rrshareweb/conf/rrshare.json
# replace list port in config file.
if [[ ! -z "$RR_LISTEN_PORT" ]]; then
    sed -i 's/3001/${RR_LISTEN_PORT}/g' $CONF_FILE
fi

if [[ -z "$RR_SAVE_PATH" ]]; then
    RR_SAVE_PATH="/var/lib/rrshareweb"
fi
# replace defaultsavepath to /var/lib/rrshareweb default path f:/store is not a good choice.
sed -i 's#f:/store#${RR_SAVE_PATH}#g' $CONF_FILE

if [[ -z "$1" ]]; then
    /opt/rrshareweb/rrshareweb
fi
exec "$@"
