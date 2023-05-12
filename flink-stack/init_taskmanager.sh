#!/bin/bash

# copy confgig files

cp /opt/flink/tasks-conf/config.py /opt/flink/py_libs/m4i-flink-tasks/scripts/config.py > /tmp/log.out
cp /opt/flink/tasks-conf/credentials.py /opt/flink/py_libs/m4i-flink-tasks/scripts/credentials.base >> /tmp/log.out
sed "s/ELASTIC_PASSWORD/${ELASTIC_PASSWORD}/g" /opt/flink/py_libs/m4i-flink-tasks/scripts/credentials.base  \
     | sed "s/KEYCLOAK_ATLAS_ADMIN_PASSWORD/${KEYCLOAK_ATLAS_ADMIN_PASSWORD}/g" \
     > /opt/flink/py_libs/m4i-flink-tasks/scripts/credentials.py

# instakll m4i-flink-task library
cd /opt/flink/py_libs/m4i-flink-tasks
#git checkout -b ${M4I_FLINK_TASKS_BRANCH}
git pull
pip3 install -e . --use-feature=2020-resolver >> /tmp/log.out