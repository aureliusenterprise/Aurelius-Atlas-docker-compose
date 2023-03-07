#!/bin/bash

# reverse-proxy 
envsubst '$EXTERNAL_IP' < templates/reverse-proxy/atlas_template.conf > reverse-proxy-files/config.d/atlas.conf
envsubst '$EXTERNAL_IP' < templates/reverse-proxy/atlas2_template.conf > reverse-proxy-files/config.d/atlas2.conf
envsubst '$EXTERNAL_IP' < templates/reverse-proxy/auth_template.conf > reverse-proxy-files/config.d/auth.conf

#keycloak
# modifies only m4i_public, m4i_atlas, what about other roles?
envsubst '$EXTERNAL_IP' < templates/keycloak/realm_m4i_templates.json > keycloak-stack/realm_m4i.json

#atlas
envsubst '$EXTERNAL_IP' < templates/atlas/keycloak-conf_template.json > atlas-stack/keycloak-conf.json

# flink
envsubst '$EXTERNAL_IP' < templates/flink/config_template.py > flink-stack/config.py

# rest-python
envsubst '$EXTERNAL_IP' < templates/python-rest/m4i_atlas_config_template.py > rest-python/m4i_atlas_config.py
envsubst '$EXTERNAL_IP' < templates/python-rest/m4i_backend_config_template.py > rest-python/m4i_backend_config.py

# environment variables
envsubst '$EXTERNAL_IP' < templates/.env_template > .env