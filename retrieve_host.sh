#!/usr/bin/bash

# Set mount script permissions
chmod 777 enterprise-search-stack/add_setting.sh
chmod 777 kafka-connect-stack/execute_connectors.sh

# reverse-proxy 
envsubst '$EXTERNAL_HOST' < templates/reverse-proxy/atlas_template.conf > reverse-proxy-files/config.d/atlas.conf
envsubst '$EXTERNAL_HOST' < templates/reverse-proxy/atlas2_template.conf > reverse-proxy-files/config.d/atlas2.conf
envsubst '$EXTERNAL_HOST' < templates/reverse-proxy/auth_template.conf > reverse-proxy-files/config.d/auth.conf

#keycloak - modifies only m4i_public, m4i_atlas
envsubst '$EXTERNAL_HOST' < templates/keycloak/realm_m4i_templates.json > keycloak-stack/realm_m4i.json

#atlas
envsubst '$EXTERNAL_HOST' < templates/atlas/keycloak-conf_template.json > atlas-stack/keycloak-conf.json

# rest-python
envsubst '$EXTERNAL_HOST' < templates/python-rest/m4i_atlas_config_template.py > rest-python/m4i_atlas_config.py
envsubst '$EXTERNAL_HOST' < templates/python-rest/m4i_backend_config_template.py > rest-python/m4i_backend_config.py

# environment variables
envsubst '$EXTERNAL_HOST' < templates/.env_template > .env

#docker compose
envsubst '$EXTERNAL_HOST' < templates/docker_compose_template > docker-compose.yml