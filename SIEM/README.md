# TheHive / Cortex / MISP
- Elasticsearch (7.11.1)
- TheHive (4.1.4-1)
- Cortex (3.1.1-1)
- MISP (2.4.141)

<img src="https://blogthehiveproject.files.wordpress.com/2018/11/the-hive-logo-schc3a9ma-v1_plan-de-travail-11.png" style="width: 100px;"/>


## RUTAS
```
.
├── cortex
│   └── application.conf
├── docker-compose.yml
├── README.md
├── thehive
│   └── application.conf
└── vol
    ├── cassandra-data
    ├── data
    ├── elasticsearch_data
    ├── elasticsearch_logs
    ├── index
    ├── mysql
```


### ELASTICSEARCH
- Necesitamos poner estas comandas para poder darles permisos a los contenedores de Elasticsearch y puedan realizar los cambios deseados.
- Los direcotrios de Elasticsearch son elasticsearch_data/ y elasticsearch_logs/.
```bash
chown -R 1000:1000 <path_to_elasticsearch>
```
```bash
docker-compose up -d elasticsearch
```

### THEHIVE
- Para TheHive necesitaremos darle permisos con el usuario a los directorios encontrados en /vol/ una vez se levanten los contenedores.
- Los directorios de TheHive son, data/ y index/.
```bash
chown -R 1000:1000 <path_to_thehive>
```
```bash
docker-compose up -d thehive
```

### CORTEX
- Para Cortex necesitaremos crear un usuario nuevo y extraer su API para copiarla y pegarla en la configuración de TheHive
```bash
chown -R 1000:1000 <path_to_thehive>
```
```bash
docker-compose up -d thehive
```

CONTAINER ID   IMAGE                                                  COMMAND                  CREATED        STATUS       PORTS                                         NAMES
c01139846f26   coolacid/misp-docker:core-latest                       "/entrypoint.sh"         24 hours ago   Up 3 hours   0.0.0.0:80->80/tcp, 0.0.0.0:443->443/tcp      misp
273dcbf1e2ce   mysql:latest                                           "docker-entrypoint.s…"   24 hours ago   Up 3 hours   3306/tcp, 33060/tcp                           db
b6787b9ae9d5   coolacid/misp-docker:modules-latest                    "/usr/local/bin/misp…"   24 hours ago   Up 3 hours                                                 misp-modules
d8834c5c6ba1   thehiveproject/thehive4:latest                         "/opt/thehive/entryp…"   24 hours ago   Up 3 hours   0.0.0.0:9000->9000/tcp                        thehive
2277631cafd7   thehiveproject/cortex:latest                           "/opt/cortex/entrypo…"   24 hours ago   Up 3 hours   0.0.0.0:9001->9001/tcp                        cortex
0be4f04fea03   docker.elastic.co/kibana/kibana:7.11.1                 "/bin/tini -- /usr/l…"   24 hours ago   Up 3 hours   0.0.0.0:5601->5601/tcp                        kibana
e15180935a9d   docker.elastic.co/elasticsearch/elasticsearch:7.11.1   "/bin/tini -- /usr/l…"   24 hours ago   Up 3 hours   0.0.0.0:9200->9200/tcp, 9300/tcp              elasticsearch
a8cc295ccbf3   redis:latest                                           "docker-entrypoint.s…"   24 hours ago   Up 3 hours   6379/tcp                                      redis
9c63be52d82c   cassandra:3.11                                         "docker-entrypoint.s…"   24 hours ago   Up 3 hours   7000-7001/tcp, 7199/tcp, 9042/tcp, 9160/tcp   cassandra

