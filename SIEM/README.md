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
