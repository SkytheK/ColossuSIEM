# TheHive / Cortex / MISP
- Elasticsearch (7.11.1)
- TheHive (4.1.4-1)
- Cortex (3.1.1-1)
- MISP (2.4.141)

<img src="https://blogthehiveproject.files.wordpress.com/2018/11/the-hive-logo-schc3a9ma-v1_plan-de-travail-11.png" style="width: 100px;"/>


## ROUTE
```
.
├── cortex
│   └── application.conf
├── docker-compose.yml
├── filebeat.yml
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
- We need to set these commands in order to give permissions to the Elasticsearch containers so they can make the desired changes.
- The Elasticsearch directories are elasticsearch_data/ and elasticsearch_logs/.
```bash
chown -R 1000:1000 <path_to_elasticsearch>
```
```bash
docker-compose up -d elasticsearch
```

### THEHIVE
- For TheHive we will need to give permissions with the user to the directories found in /vol/ once the containers are lifted.
- TheHive directories are, data/ and index/.
```bash
chown -R 1000:1000 <path_to_thehive>
```
```bash
docker-compose up -d thehive
```
