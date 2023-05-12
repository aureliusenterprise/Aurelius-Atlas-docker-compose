#!/bin/bash

# copy confgig files
cp /opt/flink/tasks-conf/config.py /opt/flink/py_libs/m4i-flink-tasks/scripts/config.py > /tmp/log.out
cp /opt/flink/tasks-conf/credentials.py /opt/flink/py_libs/m4i-flink-tasks/scripts/credentials.base >> /tmp/log.out
sed "s/ELASTIC_PASSWORD/${ELASTIC_PASSWORD}/g" /opt/flink/py_libs/m4i-flink-tasks/scripts/credentials.base  \
     | sed "s/KEYCLOAK_ATLAS_ADMIN_PASSWORD/${KEYCLOAK_ATLAS_ADMIN_PASSWORD}/g" \
     > /opt/flink/py_libs/m4i-flink-tasks/scripts/credentials.py

# install m4i-flink-task library
cd /opt/flink/py_libs/m4i-flink-tasks
git pull
pip3 install -e . --use-feature=2020-resolver  >> /tmp/log.out
cp /opt/flink/init-app-search-engines.py /opt/flink/py_libs/m4i-flink-tasks/scripts/init/init-app-search-engines.py >> /tmp/log.out

# setup the atlas related default users
cd /opt/flink/py_libs/m4i-flink-tasks/scripts/init
python create_keycloak_users.py -u atlas -p KEYCLOAK_ATLAS_ADMIN_PASSWORD -r ["ROLE_ADMIN","DATA_STEWARD"]  >> /tmp/log.out
#python create_keycloak_users.py -u steward -p KEYCLOAK_ATLAS_STEWARD_PASSWORD -r ["DATA_STEWARD"]  >> /tmp/log.out
#python create_keycloak_users.py -u scientist -p KEYCLOAK_ATLAS_USER_PASSWORD -r ["DATA_SCIENTIST"]  >> /tmp/log.out

# setup enterprise search engine and initialize m4i types 
python init-app-search-engines.py  >> /tmp/log.out
python init-atlas-m4i-types.py >> /tmp/log.out

# start flink jobs
# cd /opt/flink/py_libs/m4i-flink-tasks/scripts
/opt/flink/bin/flink run -d -py get_entity_job.py >> /tmp/log.out
/opt/flink/bin/flink run -d -py publish_state_job.py >> /tmp/log.out
/opt/flink/bin/flink run -d -py determine_change_job.py >> /tmp/log.out
/opt/flink/bin/flink run -d -py synchronize_appsearch_job.py >> /tmp/log.out
/opt/flink/bin/flink run -d -py local_operation_job.py >> /tmp/log.out
