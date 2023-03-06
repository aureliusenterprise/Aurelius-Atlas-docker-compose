#!/bin/bash

# reverse-proxy 
envsubst '$EXTERNAL_IP' < reverse-proxy-files/templates/atlas_template.conf > reverse-proxy-files/config.d/atlas.conf
envsubst '$EXTERNAL_IP' < reverse-proxy-files/templates/atlas2_template.conf > reverse-proxy-files/config.d/atlas2.conf
envsubst '$EXTERNAL_IP' < reverse-proxy-files/templates/auth_template.conf > reverse-proxy-files/config.d/auth.conf

#keycloak
# modified only m4i_public, m4i_atlas, probably the other roles have to be modified
envsubst '$EXTERNAL_IP' < keycloak-stack/realm_m4i_templates.json > keycloak-stack/realm_m4i.json

#atlas
envsubst '$EXTERNAL_IP' < atlas-stack/keycloak-conf_template.json > atlas-stack/keycloak-conf.json

# kafka

# elastic

# flink

# rest-python