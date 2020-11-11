#!/bin/bash
set -e
RRSHAREWEB_DIR=/opt/rrshareweb
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

# switch user
if [[ ! -z ${DOCKER_UID} && ! -f /.user-initialized ]]; then
    if [[ -z ${DOCKER_GID} ]]; then
        DOCKER_GID=${DOCKER_UID}
    fi
    groupadd -f -g ${DOCKER_GID} rrshareweb
    useradd -u ${DOCKER_UID} -g ${DOCKER_GID} --home-dir ${RRSHAREWEB_DIR} rrshareweb
    USER=rrshareweb
    touch /.user-initialized
    chown ${DOCKER_UID}:${DOCKER_GID} -R ${RRSHAREWEB_DIR}
fi

if [[ ${USER} == "root" ]];then
    exec "$@"
fi

exec su - ${USER} <<EOF
exec $@
EOF
