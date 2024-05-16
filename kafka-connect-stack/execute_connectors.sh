#!/bin/bash

echo "Starting services"
echo "Configuring connectors"

cd /home/appuser/;
yes | keytool -import -alias elasticca -file secret_certs/ca/ca.crt -keypass elastic -keystore elastic.jks -storepass elastic | tee error.log;
sed 's/ELASTIC_PASSWORD/'"$elastic_password"'/' /etc/conf/app_search_documents.json > app_search_documents.json | tee -a error.log;
sed 's/ELASTIC_PASSWORD/'"$elastic_password"'/' /etc/conf/publish_state.json > publish_state.json | tee -a error.log;
while [ "$(curl -s http://localhost:8083/connectors)" != "[]" ]; do echo "Waiting..." >> error.log; sleep 5; done;
curl -X PUT -H "Content-Type: application/json" --data @app_search_documents.json http://localhost:8083/connectors/app-search-documents-sink/config | tee -a error.log;
curl -X PUT -H "Content-Type: application/json" --data @publish_state.json http://localhost:8083/connectors/publish-state-sink/config | tee -a error.log;
