config = {
    "atlas.server.url": "http://$EXTERNAL_IP:21000/api/atlas",
    "kafka.bootstrap.server.hostname": "broker",
    "kafka.bootstrap.server.port": "29092",
    "kafka.consumer.group.id": "",
    "atlas.audit.events.topic.name": "ATLAS_ENTITIES",
    "enriched.events.topic.name": "ENRICHED_ENTITIES",
    "determined.events.topic.name": "DETERMINED_CHANGE",
    "sync_elastic.events.topic.name": "SYNC_ELASTIC",
    "exception.events.topic.name": "DEAD_LETTER_BOX",

    "elastic.search.index" : "atlas-dev-audit",
    "elastic.app.search.engine.name" : "atlas-dev",

    "operations.appsearch.engine.name": "atlas-dev",

    "elastic.cloud.username" : "elastic",
    "elastic.cloud.id" : None,
    # "elastic.base.endpoint" : "elastic.{{ .Release.Namespace }}.svc.cluster.local:9200/api/as/v1",
    # "elastic.search.endpoint" : "http://elastic-search-es-http.{{ .Release.Namespace }}.svc.cluster.local:9200",
    # "elastic.enterprise.search.endpoint" : "http://enterprise-search-ent-http.{{ .Release.Namespace }}.svc.cluster.local:3002",
    "elastic.base.endpoint" : "http://$EXTERNAL_IP:8087/elastic/api/as/v1", #via reverse proxy
    "elastic.search.endpoint" : "http://$EXTERNAL_IP:443/elastic", #reverse-proxy
    "elastic.enterprise.search.endpoint" : "http://$EXTERNAL_IP:443/app-search", #reverse-proxy

    "keycloak.server.url" : "http://$EXTERNAL_IP:8087/auth/",
    "keycloak.client.id" : "m4i_public",
    "keycloak.realm.name": "m4i",    
}