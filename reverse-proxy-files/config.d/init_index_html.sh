#!/bin/bash
mv /usr/local/apache2/atlas/index.html /usr/local/apache2/atlas/index.orig.html
sed "s/<base href=\"\//<base href=\"\/atlas\//g" /usr/local/apache2/atlas/index.orig.html > /usr/local/apache2/atlas/index.html
if [[ -v ENTERPRISE_SEARCH_INTERNAL_URL ]]; then
     export ATLAS_APP_SEARCH_TOKEN=$( curl -X GET "${ENTERPRISE_SEARCH_INTERNAL_URL}api/as/v1/credentials/search-key" \
     -H 'Content-Type: application/json' --insecure \
     -u $ELASTIC_USERNAME:$ELASTIC_PASSWORD | jq '.key' | sed 's/^"\(.*\)"$/\1/' )
     mkdir /usr/local/apache2/bak/
     cp /usr/local/apache2/atlas/main*.js /usr/local/apache2/bak/
     sed -i "s/atlas:{appSearchToken:\"[a-z0-9\-]*\"/atlas:{appSearchToken:\"${ATLAS_APP_SEARCH_TOKEN}\"/g" /usr/local/apache2/atlas/main*.js
fi